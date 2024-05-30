import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:we_connect_iui_mobile/src/controller/onboarding/onboarding_controller.dart';

import '../../../constants/app_color.dart';
import '../../components/common_button.dart';
import '../../components/common_text.dart';
import '../login/loginPage.dart';
import '../login/signupPage.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();

  static const routeName = '/onboarding';
}

class _OnboardingViewState extends State<OnboardingView> {
  final homeCon = Get.put<OnboardingController>(OnboardingController());
  late PageController _pageController; // Declare PageController

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(); // Initialize PageController
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose(); // Dispose PageController
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    bool isSignInPage = true;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: CommonText(
                  text: "Skip",
                  color: AppColor.header,
                ),
              ),
            ),
            PageView.builder(
              controller: _pageController,
              itemCount: homeCon.demoData.length,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                homeCon.currentPage.value = index;
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    CommonText(
                      text: homeCon.demoData[index].title,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        homeCon.demoData[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CommonText(
                      text: homeCon.demoData[index].description,
                      color: AppColor.mutexText,
                      fontSize: 13,
                    ),
                    const Spacer(),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        homeCon.demoData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 8,
                          width: homeCon.currentPage.value == index
                              ? 38
                              : 8, // Adjust the size of the active dot
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: homeCon.currentPage.value == index
                                ? AppColor.pinkAccent
                                : AppColor
                                    .header, // Adjust active and inactive dot colors
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // CommonButton(
                  //   text: "Previous page",
                  //   color: AppColor.pinkAccent,
                  //   onPressed: () {
                  //     if (_pageController.hasClients) {
                  //       _pageController.previousPage(
                  //         duration: Duration(milliseconds: 300),
                  //         curve: Curves.easeIn,
                  //       ); // Change to previous page on button press
                  //     }
                  //   },
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButton(
                    text: "Next page",
                    color: AppColor.pinkAccent,
                    onPressed: () {
                      if (_pageController.hasClients) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        ); // Change to next page on button press
                      }
                      if (homeCon.currentPage.value == homeCon.demoData.length - 1) {
                        if (isSignInPage) {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        } else {
                          Navigator.pushNamed(context, SignupPage.routeName);
                        }
                        isSignInPage = !isSignInPage;    
                    }
                    }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
