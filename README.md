# Golang + Flutter + Protobuf Starter Template

A starter template for cross-platform applications.
It features a Flutter frontend and a Go backend running seamlessly in a single process via FFI, communicating over a Unix Domain Socket (UDS) with [ConnectRPC](https://connectrpc.com/) (protobuf).

## Features
- **Single-Process Architecture**: Go backend is compiled as a C-shared library and loaded directly into Flutter via FFI.
- **ConnectRPC**: Typesafe API communication using HTTP/2 over UDS (Linux/macOS) and TCP fallback.
- **Server-Side Streaming**: Ready-to-use example of real-time server streaming.
- **Nix Flake**: Reproducible development environment.

## 🚀 Getting Started (Personalizing the Template)

When you clone this template for a new project, run the setup script to instantly rename the Go module, App ID, and project name:

```bash
make setup
```

The script will interactively ask for:
- Go module name (e.g., `github.com/myuser/myapp/backend`)
- Flutter App ID (e.g., `com.mycompany.myapp`)
- Flutter App Name (e.g., `My Awesome App`)
- Dart Package Name (default: `frontend`)

It automatically replaces all configurations, moves Android activities to the correct package path, regenerates protobufs, and updates dependencies.

## 🛠 Commands

- `make run-linux` - Build shared library and run Flutter on Linux
- `make run-macos` - Build shared library and run Flutter on macOS
- `make build-linux-app` / `make build-macos-app` - Build production release bundle
- `make run-backend-standalone` - Run the Go backend natively on TCP (127.0.0.1:8080) for API testing
- `make generate` - Regenerate protobuf definitions
- `make deps` - Fetch Go/Flutter dependencies (`make deps-android` additionally patches the Flutter Gradle plugin, required before Android builds on NixOS)
- `make test`, `make lint`, `make format` - Code quality tools

## Nix Development Shells

- `nix develop` - Full environment: Go, Flutter, Buf, JDK 17, Android SDK/NDK
- `nix develop .#desktop` - Slim environment without the Android toolchain; used by CI for Linux desktop builds and quality checks (macOS CI jobs use the official Flutter/Go toolchains instead — the read-only `/nix/store` breaks Flutter's in-place `lipo` thinning of `FlutterMacOS.framework`)

On Intel Macs pass extra flags (the flake already uses the Intel-supporting `nixpkgs-26.05-darwin` branch for `x86_64-darwin`, but `nix develop` itself resolves its inner bash through the `nixpkgs` input, which dropped Intel support):

```bash
nix develop --no-write-lock-file --override-input nixpkgs github:NixOS/nixpkgs/nixpkgs-26.05-darwin
```

## CI Signing Secrets

CI builds unsigned artifacts by default. Add repository secrets to enable signing:

**Android** (skipped when `ANDROID_KEYSTORE_BASE64` is empty):
- `ANDROID_KEYSTORE_BASE64` — keystore file, base64-encoded
- `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, `ANDROID_STORE_PASSWORD`

**macOS** (requires an Apple Developer Program membership; skipped when `MACOS_CERT_P12_BASE64` is empty):
- `MACOS_CERT_P12_BASE64` — "Developer ID Application" certificate + private key exported as `.p12`, base64-encoded
- `MACOS_CERT_PASSWORD` — password of the `.p12`
- `APPLE_ID`, `APPLE_APP_PASSWORD`, `APPLE_TEAM_ID` — Apple ID, an [app-specific password](https://support.apple.com/102654), and Team ID for notarization (notarization is skipped when `APPLE_ID` is empty)

Signed + notarized macOS builds pass Gatekeeper on download. Unsigned (ad-hoc) builds require `xattr -cr MyApp.app` after unzipping.

## TCP vs UDS

By default, the template uses UDS (Unix Domain Sockets) in production and development for maximum performance.
You can force TCP transport during development:
```bash
flutter run --dart-define=APP_USE_TCP=true --dart-define=APP_TCP_ADDRESS=127.0.0.1:8080
```
