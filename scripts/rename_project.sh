#!/bin/bash

# Usage: ./scripts/rename_project.sh new_project_name
# Example: ./scripts/rename_project.sh my_awesome_app

if [ -z "$1" ]; then
  echo "Error: No new name provided."
  echo "Usage: ./scripts/rename_project.sh <new_project_name>"
  exit 1
fi

NEW_NAME=$1
OLD_NAME="flutter_mvvm_101" # The current name of this template

echo "🚀 Renaming project from '$OLD_NAME' to '$NEW_NAME'..."

# 1. Update pubspec.yaml and Dart imports
# specific to macOS sed syntax (-i '')
find . -type f \( -name "*.dart" -o -name "*.yaml" -o -name "*.xml" -o -name "*.gradle" -o -name "*.kt" -o -name "*.swift" -o -name "*.pbxproj" -o -name "*.plist" \) -not -path '*/.*' -print0 | xargs -0 sed -i '' "s/$OLD_NAME/$NEW_NAME/g"

echo "✅ Text replacement complete."
echo "⚠️  Note: This script updates imports and configuration names."
echo "⚠️  For a full package rename (e.g., com.example.app), you may need to rename folders in android/app/src/main/kotlin and ios/Runner manually."
echo "runs 'make get' to update dependencies..."

flutter pub get
