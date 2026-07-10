.PHONY: setup generate deps build-linux build-macos run-linux run-macos build-linux-app build-macos-app run-backend-standalone test lint format clean

# === Initialization ===
setup:
	go run scripts/setup.go
	make generate
	make deps

# === Code Generation ===
generate:
	cd proto && buf generate

deps:
	cd backend && go mod tidy
	cd frontend && flutter pub get

# === C-Shared Library Builds ===
build-linux:
	cd backend && go build -buildmode=c-shared -o ../frontend/linux/libbackend.so ./cmd/shared/main.go

build-macos:
	cd backend && go build -buildmode=c-shared -o ../frontend/macos/libbackend.dylib ./cmd/shared/main.go

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
