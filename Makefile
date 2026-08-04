.PHONY: setup generate deps deps-android build-linux build-macos run-linux run-macos build-linux-app build-macos-app run-backend-standalone test lint format clean

# Android NDK ships prebuilt toolchains for x86_64 hosts only
# (darwin-x86_64 also serves Apple Silicon via Rosetta)
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
NDK_HOST_TAG := darwin-x86_64
else
NDK_HOST_TAG := linux-x86_64
endif

# === Initialization ===
setup:
	go run scripts/setup.go
	make generate
	make deps-android

# === Code Generation ===
generate:
	cd proto && buf generate

deps:
	cd backend && go mod tidy
	cd frontend && flutter pub get

deps-android: deps
	cd frontend && ./patch-flutter-gradle.sh

# === C-Shared Library Builds ===
build-linux:
	cd backend && go build -buildmode=c-shared -o ../frontend/linux/libbackend.so ./cmd/shared/main.go

build-macos:
	cd backend && go build -buildmode=c-shared -o ../frontend/macos/libbackend.dylib ./cmd/shared/main.go

build-android-arm64:
	@if [ -z "$(ANDROID_NDK_HOME)" ]; then echo "ANDROID_NDK_HOME is not set"; exit 1; fi
	mkdir -p frontend/android/app/src/main/jniLibs/arm64-v8a
	cd backend && CGO_ENABLED=1 GOOS=android GOARCH=arm64 CC="$(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/$(NDK_HOST_TAG)/bin/aarch64-linux-android30-clang" CXX="$(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/$(NDK_HOST_TAG)/bin/aarch64-linux-android30-clang++" go build -buildmode=c-shared -o ../frontend/android/app/src/main/jniLibs/arm64-v8a/libbackend.so ./cmd/shared/main.go

# === Flutter Development Runs ===
run-linux: build-linux
	cd frontend && flutter run -d linux

run-macos: build-macos
	cd frontend && flutter run -d macos

# === Flutter Production Builds ===
build-linux-app: build-linux
	cd frontend && flutter build linux

build-macos-app: build-macos
	cd frontend && flutter build macos

build-android-apk: build-android-arm64
	cd frontend && flutter build apk --target-platform android-arm64 --release

# === Backend Standalone ===
run-backend-standalone:
	cd backend && go run ./cmd/standalone/main.go

# === Code Quality ===
test:
	cd backend && go test ./...
	cd frontend && flutter test

lint:
	cd backend && go vet ./...
	cd frontend && flutter analyze

format:
	cd backend && go fmt ./...
	cd frontend && dart format .

clean:
	rm -f frontend/linux/libbackend.so frontend/linux/libbackend.h
	rm -f frontend/macos/libbackend.dylib frontend/macos/libbackend.h
	rm -rf frontend/lib/src/gen
	rm -rf backend/gen
	cd frontend && flutter clean
