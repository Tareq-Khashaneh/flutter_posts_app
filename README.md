# Project Goal
Create a Flutter application that implements the prototype identical to the provided Figma design, following Clean Architecture principles.

## Features
1. Backend Integration
    - Implement a Firestore service that handles:
        - Create, read, update, and delete (CRUD) operations for posts.
        - Add comments for each post.
2. State Management
    - Use Provider for state management.
    - Create two providers: one for the posts screen, another for the post details screen.
3. Responsive UI
    - Design a clean and user-friendly UI.
    - Make the UI fully responsive using the flutter_screenutil package.
    - Create reusable widgets for common components (buttons, text fields, titles, cards, etc.).
4. Offline Support
    - Store posts locally using Shared Preferences.
    - When the device is offline, fetch data from the local cache instead of Firestore.
5. Clean Architecture
    - Structure the project according to Clean Architecture principles:
        - Domain Layer: Entities, Use Cases, and Repositories interfaces.
        - Data Layer: Models, Repository Implementations, and Remote Data Sources.
        - Presentation Layer: Providers (state management), Screens, and Widgets.
    - Ensure each feature is modular and easily testable.
