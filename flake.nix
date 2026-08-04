{
  description = "Flutter + Go + ConnectRPC Starter Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          cmdLineToolsVersion = "8.0";
          toolsVersion = "26.1.1";
          platformToolsVersion = "37.0.0";
          buildToolsVersions = [ "34.0.0" "35.0.0" "36.0.0" ];
          includeEmulator = false;
          emulatorVersion = "34.1.9";
          platformVersions = [ "34" "35" "36" ];
          includeSources = false;
          includeSystemImages = false;
          systemImageTypes = [ "google_apis_playstore" ];
          abiVersions = [ "arm64-v8a" ];
          cmakeVersions = [ "3.22.1" ];
          includeNDK = true;
          ndkVersions = ["26.1.10909125"];
          useGoogleAPIs = false;
          useGoogleTVAddOns = false;
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
          ANDROID_NDK_HOME = "${androidSdk}/libexec/android-sdk/ndk/26.1.10909125";
          ANDROID_NDK_VERSION = "26.1.10909125";
          JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
          
          shellHook = ''
            echo "Environment is ready! Go, Flutter, Buf, JDK 17, and Android SDK/NDK are installed."
            
            # Ensure AAPT2 override is set in global Gradle properties for NixOS
            mkdir -p ~/.gradle
            if ! grep -q "android.aapt2FromMavenOverride" ~/.gradle/gradle.properties 2>/dev/null; then
              echo "android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/36.0.0/aapt2" >> ~/.gradle/gradle.properties
            else
              sed -i "s|android.aapt2FromMavenOverride=.*|android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/36.0.0/aapt2|" ~/.gradle/gradle.properties
            fi
          '';
        };
      }
    );
}
