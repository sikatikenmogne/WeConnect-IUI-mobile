import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_header.dart';

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
      leading: Icons.arrow_back_ios,
      title: Text("Back", style: TextStyle(color: AppColor.black),),
      titleSpacing: -width*.001,
      actions: [Text(
          AppLocalizations.of(context)!.aboutPagetitle, 
          style: TextStyle(color: AppColor.black, fontSize: 22),
        )],
    ),
    body: Container(
      width: width,
      height: height,
      color: AppColor.white,
      padding: EdgeInsets.all(width*.08),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
            width: width*.6,
            height: width*.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo/1-no_bg.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              "A Social Network for empowering the Educational Community of UCAC-ICAM Institute - Built by Students, For Students, Alumni and Faculty.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", fontStyle: FontStyle.italic, color: AppColor.black),  
            ),
            SizedBox(height: height*.05,),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 19, fontFamily: "RedHatDisplay", fontWeight: FontWeight.bold, color: AppColor.black), 
                  ),
                Text(
                  "For any question or support, please email us at: ",
                  style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", color: AppColor.black), 
                  ),
                Padding(
                  padding:  EdgeInsets.only(left: width*.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "-  Samuel SIKATI KENMOGNE:",
                        style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", color: AppColor.black), 
                      ),
                      Text(
                        "   sikatikenmogne@gmail.com",
                        style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", color: Colors.blue), 
                      ),
                      SizedBox(height: height*.01,),
                      Text(
                        "-  Jordan TCHOUNGA:",
                        style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", color: AppColor.black), 
                      ),
                      Text(
                        "   tchounga18jordan@gmail.com",
                        style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", color: Colors.blue), 
                      ),
                      SizedBox(height: height*.01,),
                      Text(
                        "-  Florian Ndiba:",
                        style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", color: AppColor.black), 
                      ),
                      Text(
                        "   florianndiba01@gmail.com",
                        style: TextStyle(fontSize: 16, fontFamily: "RedHatDisplay", color: Colors.blue), 
                      ),
                    ],
                  ),
                  
                ),
              ],
            )
          ],
        ),
      )
    ),
  );
  }
}
