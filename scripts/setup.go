package main

import (
	"bufio"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"strings"
)

const (
	// Default template values
	TemplateGoMod   = "template/backend"
	TemplateAppID   = "com.example.frontend"
	TemplateAppName = "Starter Template"
	TemplateDartPkg = "frontend"

	// Replacement patterns
	PatternDartPkgName = "name: %s"
	PatternCMakeBinary = `set(BINARY_NAME "%s")`
)

func main() {
	fmt.Println("=== Starter Template Setup ===")

	reader := bufio.NewReader(os.Stdin)

	prompt := func(msg, def string) string {
		fmt.Printf("%s [%s]: ", msg, def)
		input, _ := reader.ReadString('\n')
		input = strings.TrimSpace(input)
		if input == "" {
			return def
		}
		return input
	}

	goMod := prompt("Go module name", "github.com/username/myproject/backend")
	appID := prompt("Flutter App ID", "com.company.myproject")
	appName := prompt("Flutter App Name", "My Awesome App")
	dartPkg := prompt("Dart package name", TemplateDartPkg)

	fmt.Println("\nApplying changes...")

	// 1. Replace Go module
	replaceInFiles(".", TemplateGoMod, goMod, []string{".go", ".mod", ".proto"})

	// 2. Replace App ID
	replaceInFiles(".", TemplateAppID, appID, nil)

	// 3. Move MainActivity.kt if needed
	oldPackagePath := filepath.Join("frontend", "android", "app", "src", "main", "kotlin", strings.ReplaceAll(TemplateAppID, ".", string(os.PathSeparator)))
	newPackagePath := filepath.Join("frontend", "android", "app", "src", "main", "kotlin", strings.ReplaceAll(appID, ".", string(os.PathSeparator)))
	
	if _, err := os.Stat(oldPackagePath); err == nil {
		os.MkdirAll(newPackagePath, 0755)
		oldFile := filepath.Join(oldPackagePath, "MainActivity.kt")
		newFile := filepath.Join(newPackagePath, "MainActivity.kt")
		if err := os.Rename(oldFile, newFile); err == nil {
			fmt.Printf("Moved: MainActivity.kt to %s\n", newPackagePath)
		}
		// Clean up old empty directories (ignore errors)
		os.Remove(oldPackagePath)
		os.Remove(filepath.Join("frontend", "android", "app", "src", "main", "kotlin", "com", "example"))
	}

	// 4. Replace App Name in Flutter UI
	replaceInFiles(filepath.Join("frontend", "lib"), TemplateAppName, appName, []string{".dart"})

	// 5. Replace dart package name if changed
	if dartPkg != TemplateDartPkg {
		replaceInFiles("frontend", fmt.Sprintf(PatternDartPkgName, TemplateDartPkg), fmt.Sprintf(PatternDartPkgName, dartPkg), []string{".yaml"})
		replaceInFiles("frontend", fmt.Sprintf(PatternCMakeBinary, TemplateDartPkg), fmt.Sprintf(PatternCMakeBinary, dartPkg), []string{".txt"})
	}

	fmt.Println("\nSetup complete! Run `make generate` to regenerate protobufs with new module name.")
	fmt.Println("You can now delete scripts/setup.go if you want.")
}

func replaceInFiles(rootDir, from, to string, extensions []string) {
	filepath.WalkDir(rootDir, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return nil
		}
		if d.IsDir() {
			// Skip .git, build, .dart_tool, etc.
			name := d.Name()
			if name == ".git" || name == "build" || name == ".dart_tool" || name == "Pods" {
				return filepath.SkipDir
			}
			return nil
		}

		if len(extensions) > 0 {
			match := false
			for _, ext := range extensions {
				if strings.HasSuffix(path, ext) {
					match = true
					break
				}
			}
			if !match {
				return nil
			}
		}

		content, err := os.ReadFile(path)
		if err != nil {
			return nil
		}

		text := string(content)
		if strings.Contains(text, from) {
			text = strings.ReplaceAll(text, from, to)
			os.WriteFile(path, []byte(text), 0644)
			fmt.Printf("Updated: %s\n", path)
		}
		return nil
	})
}
