# Vera Clinic

Vera Clinic is a Flutter application designed for a dietary and rehab clinic. It enables doctors to track patient progress while replacing paper logs with 100% digital records, promoting sustainability.

## Features

- **Digital Records**: Replace paper logs with digital records for better sustainability.
- **Patient Tracking**: Track patient progress efficiently.
- **Real-time Updates**: Ensure real-time updates and secure data storage with Firebase.
- **State Management**: Utilize the Provider package for seamless data flow management.
- **MVC Architecture**: Enhance code readability and maintainability with the MVC architectural pattern.

## Getting Started

### Prerequisites

- Flutter SDK
- Firebase account

### Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/yourusername/vera_clinic.git
    cd vera_clinic
    ```

2. **Install dependencies**:
    ```sh
    flutter pub get
    ```

3. **Set up Firebase**:
    - Follow the instructions to set up Firebase for your Flutter project.
    - Add the `google-services.json` file to the 

app

 directory.
    - Add the `firebase_options.dart` file to the 

Firebase

 directory.

4. **Run the app**:
    ```sh
    flutter run
    ```

## Project Structure

```plaintext
lib/
├── Core/
│   ├── Controller/
│   │   ├── Providers/
│   │   ├── UtilityFunctions.dart
│   ├── Model/
│   │   ├── Classes/
│   │   ├── Firebase/
│   ├── View/
│   │   ├── Pages/
│   │   ├── Reusable widgets/
├── NewClientRegistration/
│   ├── Controller/
│   │   ├── TextEditingControllers.dart
│   │   ├── UtilityFunctions.dart
│   ├── View/
│   │   ├── NewClientPage.dart
│   │   ├── UsedWidgets/
├── NewVisit/
│   ├── Controller/
│   │   ├── TextEditingControllers.dart
│   │   ├── UtilityFunctions.dart
│   ├── View/
│   │   ├── NewVisit.dart
├── main.dart
```

## Key Components

### State Management

The app uses the Provider package to manage state and data flow between the Firebase backend and the UI layer. This ensures real-time updates and secure data storage.

### MVC Architecture

The app follows the MVC (Model-View-Controller) architectural pattern to enhance code readability and maintainability.

### Firebase Integration

The app integrates with Firebase for backend services, including real-time database.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.

## Contact

For any inquiries or support, please contact [omarahmed7703@gmail.com].
