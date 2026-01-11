.PHONY: clean get watch build gen-l10n format lint fix test

# Clean the project
clean:
	flutter clean

# Get dependencies
get:
	flutter pub get

# Watch build_runner (for Riverpod/Freezed code generation in background)
watch:
	dart run build_runner watch --delete-conflicting-outputs

# Build build_runner (one-time code generation)
build:
	dart run build_runner build --delete-conflicting-outputs

# Generate Localization files
gen-l10n:
	flutter gen-l10n

# Format code
format:
	dart format .

# Analyze code for lint errors
lint:
	flutter analyze

# Fix auto-fixable lint errors
fix:
	dart fix --apply

# Run tests
test:
	flutter test
