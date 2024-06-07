import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/controller/onboarding/onboarding_controller.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';

import '../../../constants/app_color.dart';
import '../../components/common_button.dart';
import '../../components/common_text.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();

  static const routeName = '/onboarding';
}

class _OnboardingViewState extends State<OnboardingView> {
  final homeCon = Get.put<OnboardingController>(OnboardingController());
  late PageController _pageController; // Declare PageController
  String onboardingButton = "Next";
  bool isSignInPage = true;

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

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    if (isLoggedIn == true) {
      // Retrieve the session from Supabase
      final session = supabaseClient.auth.currentSession;

      if (session != null) {
        // There is an active session
        print('Session: ${session.user}');
      } else {
        // There is no active session
        print('No active session');
      }

      // Redirect to home route
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      if (homeCon.currentPage.value == homeCon.demoData.length - 1) {
        if (isSignInPage) {
          Navigator.pushNamed(context, AppRoutes.login);
        } else {
          Navigator.pushNamed(context, AppRoutes.signUp);
        }
        isSignInPage = !isSignInPage;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var indexMemory = 0;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: homeCon.demoData.length,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                homeCon.currentPage.value = index;
                indexMemory = index;
                setState(() {
                  if (indexMemory == homeCon.demoData.length - 1) {
                    onboardingButton = "Continue";
                  } else {}
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonText(
                        text: homeCon.demoData[index].title,
                        fontSize: 27,
                        // fontWeight: FontWeight.bold,
                        alignment: TextAlign.left,
                      ),
                    ),
                    (index == 0)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: CommonText(
                              text: "WeConnect",
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              alignment: TextAlign.left,
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 20),
                    Image.asset(
                      homeCon.demoData[index].image,
                      fit: BoxFit.cover,
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
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  _pageController.jumpToPage(homeCon.demoData.length - 1);
                },
                child: CommonText(
                  text: "Skip",
                  color: AppColor.header,
                ),
              ),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 1.5),
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
                      text: onboardingButton,
                      color: AppColor.pinkAccent,
                      onPressed: () async {
                        if (_pageController.hasClients) {
                          // setState(() {
                          //   if (indexMemory == homeCon.demoData.length - 1) {
                          //     onboardingButton = "Continue";
                          //   }
                          // });
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ); // Change to next page on button press
                        }
                        if (homeCon.currentPage.value ==
                            homeCon.demoData.length - 1) {
                          await checkLoginStatus();

                          // if (isSignInPage) {
                          //   Navigator.pushNamed(context, AppRoutes.login);
                          // } else {
                          //   Navigator.pushNamed(context, AppRoutes.signUp);
                          // }
                          // isSignInPage = !isSignInPage;
                        }
                      }),
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
