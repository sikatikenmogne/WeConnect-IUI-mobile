
<div align="center">
<img src="assets/images/ucac-icam.png" width="300px">

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

This project is a starting point for a Flutter application that follows the [simple app state management tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the [online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## 🎨 Assets

The `assets` directory houses images, fonts, and any other files you want to include with your application.

The `assets/images` directory contains [resolution-aware images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## 🌍 Localization

This project supports multiple languages. The currently supported languages are:

- English
- French

The localized messages are generated based on arb files found in the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on [Internationalizing Flutter apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## 🛠️ Installation & Setup

1. Clone the repository: `git clone https://github.com/sikatikenmogne/we_connect_iui_mobile.git`
2. Navigate to the project directory: `cd we_connect_iui_mobile`
3. Copy the `.env.example` file and rename it to `.env`, then replace the placeholders with your actual Firebase API keys.
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
            └── settings_controller.dart
        └── 📁localization
            └── app_en.arb
            └── app_fr.arb
        └── 📁model
            └── sample_item.dart
        └── 📁routes
        └── 📁service
            └── settings_service.dart
        └── 📁state
        └── 📁utils
        └── 📁view
            └── 📁pages
                └── sample_item_details_view.dart
                └── sample_item_list_view.dart
                └── settings_view.dart
            ├── widgets
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

This project was created by [Samuel SIKATI KENMOGNE]([github.c](https://github.com/sikatikenmogne)), [Jordan TCHOUNGA ZOUATOUM](https://github.com/Mr-Tchounga), and [Florian Dimitri NDIBA NDOUH](#). We would like to thank the Flutter community for their valuable resources and support.
