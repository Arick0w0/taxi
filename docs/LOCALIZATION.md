# 🌍 Localization Guide

This project supports **English (en)**, **Thai (th)**, and **Lao (lo)** using `flutter_localizations` and the `.arb` file standard. We use the shorthand class `S` for easy access in code.

## 📂 File Structure

- `lib/l10n/app_en.arb` - **Template File** (English)
- `lib/l10n/app_th.arb` - Thai Translations
- `lib/l10n/app_lo.arb` - Lao Translations
- `l10n.yaml` - Configuration file (Defines class name `S`)

---

## 📝 How to Add a New Message

Follow these 3 simple steps to add a new text string (e.g., a "Logout" button).

### Step 1: Define in English (Template)

Open `lib/l10n/app_en.arb` and add your key-value pair.

```json
{
  "logout": "Logout",
  "@logout": {
    "description": "Label for the logout button"
  }
}
```

### Step 2: Add Translations

Open the other language files and add the **same key**.

**`lib/l10n/app_th.arb`**

```json
{
  "logout": "ออกจากระบบ"
}
```

**`lib/l10n/app_lo.arb`**

```json
{
  "logout": "ອອກຈາກລະບົບ"
}
```

### Step 3: Use in Code

Save the files. The code generator runs automatically. You can now use the new key:

```dart
Text(S.of(context)!.logout)
```

---

## 🔄 How to Change Language Programmatically

We use a `LocaleNotifier` (Riverpod) to manage the state.

```dart
// To toggle (Loop: EN -> TH -> LO -> EN)
ref.read(localeProvider.notifier).toggleLocale();

// To set a specific language
ref.read(localeProvider.notifier).setLocale(const Locale('lo'));
```

---

## 🛠 Troubleshooting

**"Undefined name 'S' or 'AppLocalizations'"**

1.  Run the generator manually:
    ```bash
    flutter gen-l10n
    ```
2.  If the error persists in VS Code but the app runs fine, **Restart VS Code** (Command Palette -> `Developer: Reload Window`). This refreshes the analysis server to see the generated files.

**"The getter 'logout' isn't defined"**

- Make sure you saved the `.arb` files.
- Make sure the key exists in the `app_en.arb` (template) file.
