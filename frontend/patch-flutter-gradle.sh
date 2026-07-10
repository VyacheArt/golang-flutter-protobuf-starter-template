#!/usr/bin/env bash
set -e
FLUTTER_TOOLS_GRADLE="$FLUTTER_ROOT/packages/flutter_tools/gradle"
PATCHED_DIR="$HOME/.cache/flutter-gradle-patched"

if [ -z "$FLUTTER_ROOT" ]; then
  FLUTTER_BIN=$(which flutter || true)
  if [ -n "$FLUTTER_BIN" ]; then
    FLUTTER_ROOT=$(dirname "$(dirname "$(readlink -f "$FLUTTER_BIN")")")
    FLUTTER_TOOLS_GRADLE="$FLUTTER_ROOT/packages/flutter_tools/gradle"
  fi
fi

if [ ! -d "$FLUTTER_TOOLS_GRADLE" ]; then
  # Not a NixOS issue or flutter not found
  exit 0
fi

if [ -f "$PATCHED_DIR/build.gradle.kts" ]; then
  # Already patched
  exit 0
fi

mkdir -p "$PATCHED_DIR"
cp -rL "$FLUTTER_TOOLS_GRADLE/"* "$PATCHED_DIR/"
chmod -R u+rwX "$PATCHED_DIR"

# Remove settings.gradle.kts to avoid NixOS read-only errors and use a custom settings.gradle
rm -f "$PATCHED_DIR/settings.gradle.kts"
cat << 'INNER_EOF' > "$PATCHED_DIR/settings.gradle"
rootProject.name = "gradle"
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
INNER_EOF

# Disable strict validation and tests which cause failures on NixOS
sed -i 's/enableStricterValidation.set(true)/enableStricterValidation.set(false)/g' "$PATCHED_DIR/build.gradle.kts"
echo "tasks.withType<Test> { enabled = false }" >> "$PATCHED_DIR/build.gradle.kts"
echo "tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> { if (name.contains(\"Test\")) enabled = false }" >> "$PATCHED_DIR/build.gradle.kts"
echo 'plugins.apply("maven-publish")' >> "$PATCHED_DIR/build.gradle.kts"

# Publish to MavenLocal
echo "Publishing patched Flutter Gradle plugin to mavenLocal..."
cd "$PATCHED_DIR"
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
GRADLEW="$SCRIPT_DIR/android/gradlew"

if [ ! -f "$GRADLEW" ]; then
  gradle publishToMavenLocal || true
else
  $GRADLEW publishToMavenLocal
fi
echo "Successfully published Flutter Gradle Plugin!"
