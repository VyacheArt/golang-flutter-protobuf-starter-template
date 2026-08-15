.PHONY: setup generate deps deps-android build-linux build-macos build-windows run-linux run-macos run-windows build-linux-app build-macos-app build-windows-app run-backend-standalone test lint format clean

# Android NDK ships prebuilt toolchains for x86_64 hosts only
# (darwin-x86_64 also serves Apple Silicon via Rosetta)
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
NDK_HOST_TAG := darwin-x86_64
else
NDK_HOST_TAG := linux-x86_64
endif

# Oldest Android API level the Go library links against. Must not exceed the
# app's minSdk (flutter.minSdkVersion, currently 24), or the library would
# fail to load on the oldest devices the app itself still supports.
ANDROID_API := 24

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

# Requires Git Bash + GNU make + a MinGW gcc on PATH
# (e.g. `choco install make mingw`); cgo cannot use MSVC
build-windows:
	cd backend && go build -buildmode=c-shared -o ../frontend/windows/libbackend.dll ./cmd/shared/main.go

build-android-arm64:
	@if [ -z "$(ANDROID_NDK_HOME)" ]; then echo "ANDROID_NDK_HOME is not set"; exit 1; fi
	mkdir -p frontend/android/app/src/main/jniLibs/arm64-v8a
	cd backend && CGO_ENABLED=1 GOOS=android GOARCH=arm64 CC="$(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/$(NDK_HOST_TAG)/bin/aarch64-linux-android$(ANDROID_API)-clang" CXX="$(ANDROID_NDK_HOME)/toolchains/llvm/prebuilt/$(NDK_HOST_TAG)/bin/aarch64-linux-android$(ANDROID_API)-clang++" go build -buildmode=c-shared -o ../frontend/android/app/src/main/jniLibs/arm64-v8a/libbackend.so ./cmd/shared/main.go

# === Flutter Development Runs ===
run-linux: build-linux
	cd frontend && flutter run -d linux

run-macos: build-macos
	cd frontend && flutter run -d macos

run-windows: build-windows
	cd frontend && flutter run -d windows

# === Flutter Production Builds ===
build-linux-app: build-linux
	cd frontend && flutter build linux

# Embeds the Go dylib into the .app and re-signs ad-hoc (adding a file breaks
# the code-signature seal). CI re-signs with a real identity afterwards.
build-macos-app: build-macos
	cd frontend && flutter build macos
	APP_PATH="$$(ls -d frontend/build/macos/Build/Products/Release/*.app | head -1)"; \
	mkdir -p "$$APP_PATH/Contents/Frameworks"; \
	cp frontend/macos/libbackend.dylib "$$APP_PATH/Contents/Frameworks/"; \
	codesign --force --sign - "$$APP_PATH/Contents/Frameworks/libbackend.dylib"; \
	codesign --force --sign - "$$APP_PATH"

# The DLL is bundled next to the .exe by an install rule in
# frontend/windows/CMakeLists.txt (mirroring the Linux bundle step)
build-windows-app: build-windows
	cd frontend && flutter build windows

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
	rm -f frontend/windows/libbackend.dll frontend/windows/libbackend.h
	rm -rf frontend/lib/src/gen
	rm -rf backend/gen
	cd frontend && flutter clean
