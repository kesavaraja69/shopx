SHOPX

SHOPX is a Flutter e-commerce app that implements authentication using Firebase Auth, BLoC, fpdart, get_it, and Clean Architecture. The app includes an onboarding screen, a splash screen that checks the user's login status using shared_preferences, and redirects accordingly. The home screen fetches product data from the Fake Store API.

Features

Firebase Authentication (Email/Password Sign-In & Sign-Up)

State management using BLoC

Dependency injection with get_it

Functional programming utilities with fpdart

Onboarding screen for first-time users

Splash screen that checks login status with shared_preferences

Home screen displaying products from the Fake Store API

Clean Architecture implementation

Firebase setup using FlutterFire CLI

Project Structure

Dependencies

Add the following dependencies in your pubspec.yaml file:

Setup Instructions

Clone the repository:

Set up Firebase using FlutterFire CLI:

Install FlutterFire CLI:

Configure Firebase:

Install dependencies:

Run the app:

App Flow

User opens the app → Onboarding screen appears for first-time users.

After onboarding, the splash screen checks if the user is logged in via shared_preferences.

If logged in, navigates to Home Screen; otherwise, navigates to Login Screen.

Users can sign up or log in using email/password.

After successful login, user details are saved in shared_preferences.

Users can log out, which clears session data and navigates back to Login Screen.

API Integration (Fake Store API)

The home screen fetches product data from the Fake Store API.

Contact

For any queries or contributions, feel free to open an issue or submit a pull request!

Developed with ❤️ by Kesavaraja M
