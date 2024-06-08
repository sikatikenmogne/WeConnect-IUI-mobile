
<div align="center">
<img src="assets\images\logo\4-no_bg.png" width="300px">

<h1 align="center"> 
WeConnect IUI
</h1>

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![wakatime](https://wakatime.com/badge/github/sikatikenmogne/WeConnect-IUI-mobile.svg)](https://wakatime.com/badge/github/sikatikenmogne/WeConnect-IUI-mobile)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)](#)
[![Coverage Status](https://img.shields.io/badge/coverage-100%25-brightgreen)](#)
[![Flutter Version](https://img.shields.io/badge/flutter-v3.19.0-blue)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/dart-v3.4.1-blue)](https://dart.dev)
<!-- [![Contributors](https://img.shields.io/github/contributors/sikatikenmogne/WeConnect-IUI-mobile)](https://github.com/sikatikenmogne/WeConnect-IUI-mobile/graphs/contributors)
[![Forks](https://img.shields.io/github/forks/sikatikenmogne/WeConnect-IUI-mobile)](https://github.com/sikatikenmogne/WeConnect-IUI-mobile/network/members)
[![Issues](https://img.shields.io/github/issues/sikatikenmogne/WeConnect-IUI-mobile)](https://github.com/sikatikenmogne/WeConnect-IUI-mobile/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/sikatikenmogne/WeConnect-IUI-mobile)](https://github.com/sikatikenmogne/WeConnect-IUI-mobile/pulls) -->

</div>

A Social Network for empowering the Educational Community of UCAC-ICAM Institute - Built by Students, For Students, Alumni and Faculty.

</div>

## 🚀 Getting Started

Welcome to our project! This is a social network designed to empower the educational community of UCAC-ICAM Institute. Built by students, for students, alumni, and faculty, our aim is to foster a vibrant, collaborative environment where ideas can be shared and connections can be made.

This project is built using Flutter, following best practices for state management. Whether you're a student looking to contribute or a faculty member interested in seeing how it all works, this project is a great starting point for understanding the development of robust, scalable Flutter applications.

For comprehensive guidance on Flutter development, refer to the [official Flutter documentation](https://flutter.dev/docs). It provides tutorials, samples, mobile development best practices, and a complete API reference.

## 🌍 Localization

In our commitment to inclusivity, this project supports multiple languages to cater to our diverse community. Currently, the application is localized in:

- English
- French

Localization is achieved through arb files located in the `lib/src/localization` directory. These files contain the translations for all the text used in the application.

To add more languages to the application, follow the guide on [Internationalizing Flutter apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization).

## ✅ Features

- [x] User Authentication (Login/Signup)
- [x] Onboarding for new users
- [x] User Profile (View/Edit)
- [x] Chat functionality
- [x] Settings customization
- [x] Localization (English/French)
- [x] Home Page
- [x] About Page
- [x] Sample Items (List/Details)
- [x] Splash Screen
- [ ] Wheather news functionality

<details>
<summary>📸 App Preview</summary>
<div align="center">
    <img src=".github/readme_assets/WhatsApp Image 2024-06-03 at 04.11.14.jpeg" width="300px">
    <img src=".github/readme_assets/WhatsApp Image 2024-06-03 at 04.18.26.jpeg" width="300px">
    <img src=".github/readme_assets/Screen_recording_20240605_202921.webm" width="300px">
    <img src=".github/readme_assets/WhatsApp Image 2024-06-03 at 04.09.57.jpeg" width="300px">
    <img src=".github/readme_assets/Screenshot_20240605_055916.png" width="300px">
    <img src=".github/readme_assets/Screenshot_20240607_102804.png" width="300px">
    <img src=".github/readme_assets/Screenshot_20240607_102840.pngd" width="300px">
</div>
</details>

## 🛠️ Installation & Setup

1. Clone the repository: `git clone https://github.com/sikatikenmogne/we_connect_iui_mobile.git`
2. Navigate to the project directory: `cd we_connect_iui_mobile`
3. Copy the `assets/.env.example` file and rename the new file to `.env`
   1. Ex: `cp assets/.env.example assets/.env`
   2. then replace the placeholders with your actual Firebase API keys.
      1. for any issues about this step contact @sikatikenmogne
4. Download the `google-services.json` file from your Firebase project and place it in the `android/app/` directory.
   1. for any issues about this step contact @sikatikenmogne
5. Install the dependencies: `flutter pub get`
6. Run the app: `flutter run`

## 📚 Usage

This project follows a layered MVC architecture. The `models` directory contains the data models, the `pages` directory contains the UI components, and the `controllers` directory contains the business logic.

```text
└── 📁lib
    └── firebase_options.dart
    └── 📁generated
        └── 📁intl
            └── messages_all.dart
            └── messages_en.dart
        └── l10n.dart
    └── main.dart
    └── 📁src
        └── app.dart
        └── 📁constants
        └── 📁controller
            └── 📁settings
                └── settings_controller.dart
        └── 📁localization
            └── app_en.arb
            └── app_fr.arb
        └── 📁model
            └── 📁sample_item
                └── sample_item.dart
        └── 📁routes
        └── 📁service
            └── 📁settings
                └── settings_service.dart
        └── 📁state
        └── 📁utils
        └── 📁view
            └── 📁components
            └── 📁pages
                └── 📁sample_item
                    └── 📁components
                    └── sample_item_details_view.dart
                    └── sample_item_list_view.dart
                └── 📁settings
                    └── settings_view.dart
```

## 🧪 Testing

To run the test suite for this app, use the command: `flutter test`

## 📝 Contributing

We welcome contributions from the community. To contribute:

1. Fork this repository
2. Create your feature branch: `git checkout -b feature/your-feature`
   1. example: `git checkout -b feature/add-login`
3. Commit your changes following the [Conventional Commits](https://www.conventionalcommits.org/) specification: `git commit -m 'feat: add some feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a pull request

Please make sure your commits follow the Conventional Commits specification so your changes can be easily tracked.

### :bookmark: Conventional Commits

The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history, which makes it easier to write automated tools on top of. Here are some common types you might use:

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools and libraries such as documentation generation

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 📞 Contact Information

For any questions or support, please email us at:

- **Samuel SIKATI KENMOGNE**: [sikatikenmogne@gmail.com](mailto:sikatikenmogne@gmail.com)
- **Jordan TCHOUNGA ZOUATOUM**: [tchounga18jordan@gmail.com](mailto:tchounga18jordan@gmail.com)
- **Florian Dimitri NDIBA NDOUH**: [florianndiba01@gmail.com](mailto:florianndiba01@gmail.com)

You can also raise an issue in the [GitHub issue tracker](https://github.com/sikatikenmogne/WeConnect-IUI-mobile/issues) for this project.

## 🙏 Acknowledgements

This project was created by [Samuel SIKATI KENMOGNE]([github.c](https://github.com/sikatikenmogne)), [Jordan TCHOUNGA ZOUATOUM](https://github.com/Mr-Tchounga), and [Florian Dimitri NDIBA NDOUH](https://github.com/Flo-Dim). We would like to thank the Flutter community for their valuable resources and support.
