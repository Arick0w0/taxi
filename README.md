# Flutter Production Template (MVVM + Clean Architecture)

This project is a production-ready Flutter template designed for scalability, testability, and maintainability. It implements the **MVVM (Model-View-ViewModel)** pattern combined with **Clean Architecture** principles.

## 🏗 Architecture Overview

The project follows a **Feature-First** structure, where each feature (e.g., `auth`, `profile`, `feed`) is self-contained with its own Data, Domain, and Presentation layers.

### Layers

1.  **Presentation Layer (UI)**:
    *   **View**: Widgets that draw the UI. purely declarative.
    *   **ViewModel**: Manages state, handles user input, and talks to the Domain layer.
    *   **State**: Immutable state classes (freezed/equatable) representing the UI at a specific point in time.

2.  **Domain Layer (Business Logic)**:
    *   **UseCase**: Encapsulates a specific business rule or task (e.g., `LoginUser`, `GetProducts`).
    *   **Repository Interface**: Defines the contract for data operations without knowing the implementation details.

3.  **Data Layer (Data Access)**:
    *   **Repository Implementation**: Implements the domain repository interface. Coordinates data sources.
    *   **DataSource (Network/Local)**: API clients (Dio), Database handlers, etc.
    *   **Model**: Data transfer objects (DTOs) with JSON serialization logic.

4.  **Core Layer**:
    *   Cross-cutting concerns like Routing, Theming, Error Handling, and Utilities shared across features.

## 📂 Project Structure

```text
lib/
├── core/                       # Global/Shared functionality
│   ├── error/                  # Custom Exceptions & Failures
│   ├── network/                # Dio Client, Interceptors, API configs
│   ├── router/                 # GoRouter configuration
│   ├── theme/                  # AppThemes, Colors, TextStyles
│   └── utils/                  # Connectivity, Constants, Extensions
│
├── features/                   # Feature-based modules
│   └── sample_feature/         # Example Feature
│       ├── data/               # Data Layer
│       │   ├── model/          # JSON parsing models
│       │   └── repository/     # Repository Implementations
│       │
│       ├── domain/             # Domain Layer (Pure Dart)
│       │   ├── repository/     # Repository Interfaces
│       │   └── usecase/        # Single responsibility business logic
│       │
│       └── presentation/       # UI Layer
│           ├── view/           # Flutter Widgets
│           └── viewmodel/      # State management (Riverpod Notifiers)
│
├── shared/                     # Shared UI components (dumb widgets)
│   └── widgets/
│
└── main.dart                   # Application Entry Point
```

## 🛠 Tech Stack & Libraries

*   **Framework**: Flutter
*   **Language**: Dart
*   **State Management**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) (Notifier / AsyncNotifier)
*   **Navigation**: [go_router](https://pub.dev/packages/go_router)
*   **Networking**: [dio](https://pub.dev/packages/dio)
*   **Value Equality**: [equatable](https://pub.dev/packages/equatable)
*   **Connectivity**: [connectivity_plus](https://pub.dev/packages/connectivity_plus)

## 🚀 Key Patterns

### 1. Repository Pattern
Abstracts the data source from the rest of the app. The Domain layer defines *what* data is needed (Interface), and the Data layer defines *how* to get it (Implementation).

### 2. UseCase (Interactor)
Acts as a bridge between ViewModel and Repository. Each UseCase represents a single user action (e.g., `GetUsersUseCase`). This makes code readable and easy to test.

```dart
// Example UseCase
class GetUsersUseCase {
  final UserRepository _repo;
  GetUsersUseCase(this._repo);

  Future<List<User>> call() => _repo.getUsers();
}
```

### 3. StateNotifier / Notifier (Riverpod)
ViewModels extend `Notifier` or `StateNotifier` to expose an immutable state to the inputs.

```dart
// Example ViewModel
class UserViewModel extends Notifier<UserState> { ... }
```

## 🧪 Error Handling

Errors are caught in the Data/Repository layer and thrown as custom Exceptions (`NetworkException`, `ServerException`). The ViewModel catches these exceptions and maps them to UI states.

## 🚦 Navigation

Routing is handled by `GoRouter`. Navigation logic is defined locally in `lib/core/router/`. It supports redirections (e.g., for Auth) and nested navigation.
