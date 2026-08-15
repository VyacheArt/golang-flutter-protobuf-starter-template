{
  description = "Flutter + Go + ConnectRPC Starter Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Unstable (26.11) dropped x86_64-darwin; the 26.05 stable branch keeps
    # supporting Intel Macs until the end of 2026
    nixpkgs-x86_64-darwin.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-x86_64-darwin, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        nixpkgsForSystem =
          if system == "x86_64-darwin" then nixpkgs-x86_64-darwin else nixpkgs;
        pkgs = import nixpkgsForSystem {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
        # Must match the Flutter Gradle plugin's default ndkVersion
        # (FlutterExtension.kt in flutter_tools)
        ndkVersion = "28.2.13676358";
        # Must match AGP's default build-tools version; the aapt2 override in
        # the shellHook below points into the same version
        buildToolsVersion = "36.0.0";
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          # Components not listed here (cmdline-tools, platform-tools, ...)
          # default to the latest version available in the pinned nixpkgs,
          # so they only move together with flake.lock updates
          buildToolsVersions = [ buildToolsVersion ];
          # compileSdk/targetSdk of the app
          platformVersions = [ "36" ];
          # The Flutter Gradle plugin drives an externalNativeBuild, and AGP
          # requests exactly this CMake version. It must be preinstalled:
          # AGP cannot download it into the read-only /nix/store SDK
          cmakeVersions = [ "3.22.1" ];
          includeNDK = true;
          ndkVersions = [ ndkVersion ];
        };
        androidSdk = androidComposition.androidsdk;
        desktopTools = with pkgs; [
          go
          flutter
          buf
          protobuf
          protoc-gen-go
          go-tools
        ];
      in
      {
        # Slim shell without Android SDK/NDK — used by CI for desktop builds,
        # quality checks, and as the base for macOS runners.
        devShells.desktop = pkgs.mkShell {
          buildInputs = desktopTools;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = desktopTools ++ [
            androidSdk
            pkgs.jdk17
          ];

          ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
          ANDROID_NDK_HOME = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}";
          ANDROID_NDK_VERSION = ndkVersion;
          JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
          
          shellHook = ''
            echo "Environment is ready! Go, Flutter, Buf, JDK 17, and Android SDK/NDK are installed."
            
            # Ensure AAPT2 override is set in global Gradle properties for NixOS
            mkdir -p ~/.gradle
            if ! grep -q "android.aapt2FromMavenOverride" ~/.gradle/gradle.properties 2>/dev/null; then
              echo "android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/${buildToolsVersion}/aapt2" >> ~/.gradle/gradle.properties
            else
              sed -i "s|android.aapt2FromMavenOverride=.*|android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/${buildToolsVersion}/aapt2|" ~/.gradle/gradle.properties
            fi
          '';
        };
      }
    );
}
