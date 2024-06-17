import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_text.dart';

class EmailText extends StatelessWidget {

  String email;

  EmailText(this.email,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '   ',
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                launchUrl(Uri.parse('mailto:${this.email}'));
              },
              child: CommonText(
                text: this.email,
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,),
            ),
          ),
        ],
      ),
    );
  }
}