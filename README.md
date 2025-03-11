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
    - Add the `google-services.json` file to the app directory.
    - Add the `firebase_options.dart` file to the Firebase directory.
    

4. **Run the app**:
    ```sh
    flutter run
    ```

## Project Structure
<details>
  <summary>Click to expand</summary>
                              
```plaintext
├── lib\
│   ├── CheckInPage\
│   │   ├── Controller\
│   │   │   ├── CheckInPageTEC.dart
│   │   │   └── UtilityFunctions.dart
│   │   ├── View\
│   │   │   ├── InfoCards\
│   │   │   │   ├── CheckInButton.dart
│   │   │   │   ├── ClientInfoCard.dart
│   │   │   │   ├── MeasurementsCard.dart
│   │   │   │   └── SubscriptionCard.dart
│   │   │   └── CheckInPage.dart
│   ├── ClientDetailsPage\
│   │   ├── InfoCards\
│   │   │   ├── bodyMeasurementsCard.dart
│   │   │   ├── dietPreferencesCard.dart
│   │   │   ├── medicalHistoryCard.dart
│   │   │   ├── personalInfoCard.dart
│   │   │   ├── weightDistributionCard.dart
│   │   │   └── weightHistoryCard.dart
│   │   └── ClientDetailsPage.dart
│   ├── ClientSearchPage\
│   │   ├── ClientSearchPage.dart
│   │   └── UsedWidgets\
│   │       └── ClientSearchWidget.dart
│   ├── Core\
│   │   ├── Controller\
│   │   │   ├── Providers\
│   │   │   │   ├── ClientConstantInfoProvider.dart
│   │   │   │   ├── ClientMonthlyFollowUpProvider.dart
│   │   │   │   ├── ClientProvider.dart
│   │   │   │   ├── ClinicProvider.dart
│   │   │   │   ├── DiseaseProvider.dart
│   │   │   │   ├── PreferredFoodsProvider.dart
│   │   │   │   ├── VisitProvider.dart
│   │   │   │   └── WeightAreasProvider.dart
│   │   ├── Model\
│   │   │   ├── Classes\
│   │   │   │   ├── Client.dart
│   │   │   │   ├── ClientConstantInfo.dart
│   │   │   │   ├── ClientMonthlyFollowUp.dart
│   │   │   │   ├── Clinic.dart
│   │   │   │   ├── Disease.dart
│   │   │   │   ├── PreferredFoods.dart
│   │   │   │   ├── Visit.dart
│   │   │   │   └── WeightAreas.dart
│   │   │   ├── Firebase\
│   │   │   │   ├── ClientFirestoreMethods.dart
│   │   │   │   ├── ClientConstantInfoFirestoreMethods.dart
│   │   │   │   ├── ClientMonthlyFollowUpFirestoreMethods.dart
│   │   │   │   ├── ClinicFirestoreMethods.dart
│   │   │   │   ├── DiseaseFirestoreMethods.dart
│   │   │   │   ├── DefaultFirebaseOptions.dart
│   │   │   │   ├── FirebaseSingleton.dart
│   │   │   │   ├── PreferredFoodsFirestoreMethods.dart
│   │   │   │   ├── VisitFirestoreMethods.dart
│   │   │   │   └── WeightAreasFirestoreMethods.dart
│   │   └── View\
│   │       ├── Pages\
│   │       │   ├── FollowUpNav.dart
│   │       │   ├── AnalysisPage.dart
│   │       ├── Reusable widgets\
│   │       │   ├── BackGround.dart
│   │       │   ├── ClientSearchWidget.dart
│   │       │   ├── myCard.dart
│   │       │   ├── MyInputField.dart
│   │       │   ├── MyNavigationButton.dart
│   │       │   ├── MyTextBox.dart
│   │       │   └── SnackBars\
│   │       │       ├── InvalidDataTypeSnackBar.dart
│   │       │       ├── MySnackBar.dart
│   │       │       └── RequiredFieldSnackBar.dart
│   ├── HomePage\
│   │   ├── HomePage.dart
│   │   └── UsedWidgets\
│   │       ├── GridMenu.dart
│   │       ├── Header.dart
│   │       └── WelcomeSection.dart
│   ├── MonthlyFollowUp\
│   │   ├── Controller\
│   │   │   ├── MonthlyFollowUpTEC.dart
│   │   ├── View\
│   │       ├── MonthlyFollowUp.dart
│   │       └── UsedWidgets\
│   │           ├── ActionButton.dart
│   │           ├── infoCard.dart
│   │           ├── infoField.dart
│   │           └── newMonthlyFollowUpForm.dart
│   ├── NewClientRegistration\
│   │   ├── Controller\
│   │   │   ├── ClientRegistrationTEC.dart
│   │   │   ├── ClientRegistrationUF.dart
│   │   │   └── NewClientCreation.dart
│   │   ├── View\
│   │       ├── InfoSections\
│   │       │   ├── ActionButtons.dart
│   │       │   ├── PersonalInfoCard.dart
│   │       │   ├── bodyMeasurementsCard.dart
│   │       │   ├── dietPreferencesCard.dart
│   │       │   ├── medicalHistoryCard.dart
│   │       │   ├── weightDistributionCard.dart
│   │       │   ├── weightHistoryCard.dart
│   │       ├── UsedWidgets\
│   │       │   ├── ActivityLevelDropdownMenu.dart
│   │       │   ├── MyCheckBox.dart
│   │       │   └── SubscriptionTypeDropdown.dart
│   │       └── NewClientPage.dart
│   ├── NewVisit\
│   │   ├── Controller\
│   │   │   ├── NewVisitTEC.dart
│   │   │   └── NewVisitUF.dart
│   │   ├── View\
│   │       └── NewVisit.dart
│   ├── VisitsDetailsPage\
│   │   ├── UsedWidgets\
│   │   │   └── visitCard.dart
│   │   └── VisitsDetailsPage.dart
│   └── WeeklyFollowUp\
│       ├── Controller\
│       │   ├── UtilityFunctions.dart
│       │   └── VisitTEC.dart
│       ├── View\
│       │   ├── UsedWidgets\
│       │   │   ├── WFUActionButton.dart
│       │   │   ├── WFUClientInfoCard.dart
│       │   │   ├── WFUInfo1.dart
│       │   │   └── WFUInfo2.dart
│       │   └── WeeklyFollowUp.dart
└── main.dart
```
</details>

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
