import 'package:get/get.dart';
import 'package:we_connect_iui_mobile/src/model/onboarding/onboarding_data.dart';

import '../../constants/app_image.dart';

class OnboardingController extends GetxController {
  // This variable is used to track the current page in the PageView.
  var currentPage = 0.obs;

  // This list contains the data for each onboarding page.
  // Replace 'OnboardingData' with the actual type of your onboarding data.
  var demoData = [
    OnboardingData(
      image: AppImage.onboardingFirstImage,
      title: "Welcome to ",
      description:
          "Your school's social network, where staying connected is easier than ever!",
    ),
    OnboardingData(
      image: AppImage.onboardingSecondImage,
      title: "Stay Updated",
      description:
          "Get instant updates on class changes, announcements, and more.",
    ),
    OnboardingData(
      image: AppImage.onboardingThirdImage,
      title: "Share and Connect",
      description:
          "Share your ideas, achievements, projects. Post updates, photos, and comments to stay connected with your peers.",
    ),
    OnboardingData(
      image: AppImage.onboardingFourthImage,
      title: "Your Profile",
      description: "Create Your Profile. customize it,  express yourself.",
    ),
    OnboardingData(
      image: AppImage.onboardingFifthImage,
      title: "Secure and Private",
      description:
          "Your data is safe with us. We prioritize your privacy and security.",
    ),
    OnboardingData(
      image: AppImage.onboardingSixthImage,
      title: "Get Started",
      description:
          "Sign up now and start connecting with your school community!",
    ),
  ];

  // Call this method to change the current page.
  void setPage(int page) {
    currentPage.value = page;
  }

  // Add methods to manipulate 'demoData' as needed.
}
