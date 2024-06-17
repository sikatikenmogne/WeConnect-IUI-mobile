import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_header.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';
import 'package:we_connect_iui_mobile/src/view/components/email_text.dart';
import 'package:we_connect_iui_mobile/src/view/components/header_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppHeader(
        width: width,
        height: height,
        leading: null,
        title: HeaderText(
          "Back",
          fontSize: 25,
        ),
        titleSpacing: -width * .001,
        actions: [
          HeaderText(
            AppLocalizations.of(context)!.aboutPagetitle,
            fontSize: 25,
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(width * .08),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width * .6,
                  height: width * .6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo/1-no_bg.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                CommonText(
                  text:
                      "A Social Network for empowering the Educational Community of UCAC-ICAM Institute - Built by Students, For Students, Alumni and Faculty.",
                  alignment: TextAlign.center,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                SizedBox(
                  height: height * .05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Contact Us",
                      alignment: TextAlign.center,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                    CommonText(
                      text: "For any question or support, please email us at: ",
                      fontSize: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * .05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "-  Samuel SIKATI KENMOGNE:",
                            fontSize: 16,
                          ),
                          EmailText("sikatikenmogne@gmail.com"),
                          SizedBox(
                            height: height * .01,
                          ),
                          CommonText(
                            text: "-  Jordan TCHOUNGA:",
                            fontSize: 16,
                          ),
                          EmailText("tchounga18jordan@gmail.com"),
                          SizedBox(
                            height: height * .01,
                          ),
                          CommonText(
                            text: "-  Florian Ndiba:",
                            fontSize: 16,
                          ),
                          EmailText("florianndiba01@gmail.com"),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
