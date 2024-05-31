import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/routes/routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';

import '../../constants/app_image.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  static const routeName = '/splashscreen';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1858, 0.3194, 0.5237, 0.6454, 0.9636],
          colors: [
            Color(0xFFFF3131),
            Color(0xFFFF3131),
            Color(0xFFC62626),
            Color(0xFFFF3535),
            Color(0xFFFD5959),
          ],
        ),
      ),
      // color: AppColor.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 11,
            child: Center(
              child:
                  Image.asset(AppImage.appLogoBlack, width: 200, height: 200),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: CommonText(
                    text: "© 2024 - Powered by X2025",
                    fontSize: 8,
                    color: AppColor.white),
              ))
        ],
      ),
    );
  }
}
