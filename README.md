# IUC News Frontend

This is the frontend application for managing and interacting with scraping requests and results. Built using Flutter, it provides a user-friendly interface for creating, viewing, editing, and managing scraping tasks and their results.

## Features

- *Home Screen*: View a list of all scraping requests.
- *Create Scraping Requests*: Easily create new scraping tasks via the create_screen.dart.
- *View Details*: Access detailed results of scraping tasks in the detail_screen.dart.
- *Edit Requests*: Update existing scraping tasks in the edit_screen.dart.
- *Card Widgets*: Reusable UI components for displaying scraping data.
- *API Integration*: Communication with backend services via scraping_service.dart.
- *Push Notifications*: Receive real-time updates on scraping tasks using Firebase, managed by notification_service.dart.

## Prerequisites

- *Flutter SDK*: Ensure that Flutter is installed on your system. [Get Started with Flutter](https://flutter.dev/docs/get-started)
- *Dart*: This project uses Dart as the programming language.
- *Firebase*: Set up Firebase for notification services.

## Getting Started

1. *Clone the Repository:*
    Use Git to clone this repository locally.

2. *Run the App:*
    - From the project directory, run:
      bash
      flutter pub get
      
    - Then run:
      bash
      flutter run
      

## Additional Notes

- This README.md provides a high-level overview. Refer to specific source code files for detailed implementation.
- Feel free to contribute to this project by creating pull requests!

## Example Usage (Optional - Add if applicable)

If you have specific usage examples, include them here. For example:

### Creating a new scraping request:

1. Navigate to the "Create" screen.
2. Fill in the required fields (URL, CSS selectors, etc.).
3. Tap the "Create" button.

### Viewing scraping results:

1. Select a scraping request from the list on the home screen.
2. The results will be displayed on the details screen.

## Contributing

If you'd like to contribute, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request.
