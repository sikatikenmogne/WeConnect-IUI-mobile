import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    Future.delayed(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final packageInfo = await PackageInfo.fromPlatform();

      final lastSeenVersion = prefs.getString('lastSeenVersion');
      final currentVersion = packageInfo.version;

      if (lastSeenVersion == null || lastSeenVersion != currentVersion) {
        // Show the onboarding screen and update the last seen version
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
        await prefs.setString('lastSeenVersion', currentVersion);
      } else {
        // Go directly to the login screen
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
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
      // color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 11,
            child: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Image.asset(
                    AppImage.appLogoBlack,
                    width: constraints.maxWidth * 0.45,
                    height: constraints.maxWidth * 0.45,
                  );
                },
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: CommonText(
                    text: "© 2024 - Powered by X2025",
                    fontSize: 12,
                    color: AppColor.white),
              ))
        ],
      ),
    );
  }
}
