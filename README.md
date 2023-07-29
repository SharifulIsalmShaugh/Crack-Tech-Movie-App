# Crack Tech Movie App

It's a interview task Flutter project.

# Getting Started

## Flutter Pubspec Dependencies you need to use

This repository contains the Flutter project with its required dependencies listed in the `pubspec.yaml` file. Below is a brief description of each dependency:

1. **cupertino_icons: ^1.0.2**  
   Description: Cupertino icons for Flutter apps.
   Version: 1.0.2

2. **get: 4.6.5**  
   Description: State management library for Flutter.
   Version: 4.6.5

3. **flutter_launcher_icons: ^0.11.0**  
   Description: A package which simplifies the process of setting up custom app icons for Flutter applications.
   Version: 0.11.0

4. **dio: ^4.0.6**  
   Description: A powerful HTTP client for Dart that allows you to make network requests.
   Version: 4.0.6

5. **cached_network_image: ^3.2.1**  
   Description: A Flutter library to load and cache network images.
   Version: 3.2.1

6. **hive: ^2.2.3**  
   Description: A lightweight and efficient key-value database designed for use with Flutter.
   Version: 2.2.3

7. **hive_flutter: ^1.1.0**  
   Description: Hive plugin for Flutter that enables storing and querying data in Hive databases.
   Version: 1.1.0

8. **path_provider: ^2.0.15**  
   Description: Provides a platform-independent way to access the device's file system.
   Version: 2.0.15

9. **connectivity_plus: ^2.3.7**  
   Description: A Flutter plugin for detecting network connectivity changes.
   Version: 2.3.7

## How to Use

1. First, ensure you have Flutter installed on your machine.
2. Clone this repository to your local machine.
3. Open the project in your preferred Flutter IDE (e.g., Android Studio, VSCode).
4. Locate the `pubspec.yaml` file in the root directory of the project.
5. Add or update the dependencies section with the dependencies listed above.
6. Save the `pubspec.yaml` file, and Flutter will automatically fetch the new dependencies.

```yaml
dependencies:
  cupertino_icons: ^1.0.2
  get: 4.6.5
  flutter_launcher_icons: ^0.11.0
  dio: ^4.0.6
  cached_network_image: ^3.2.1
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.0.15
  connectivity_plus: ^2.3.7
```

7. Run `flutter pub get` in your terminal or click on the "Packages get" button in your IDE to fetch the new dependencies.
8. You are now ready to use the added packages in your Flutter project!

# Work Done

1. Implemented a loading screen that displays while fetching the data.
2. Handled network issues and provided error feedback to enhance the user experience.
3. Created a detailed view that appears when an item in the list is tapped, allowing users to view more information about the selected movie.
4. Utilized GetX for efficient state management, ensuring smooth app performance.
5. Wrote comprehensive tests for the application to ensure its reliability and functionality.
6. Cached API responses using Flutter Hive and GetX, which improves the app's loading speed and reduces data consumption.

```NB: Please be aware that there is a known issue with Flutter Hive that may affect automated testing. The issue is related to the usage of Hive databases in Flutter tests. Since tests run in a different environment, the default location for Hive's database files may not be accessible during automated testing.```
