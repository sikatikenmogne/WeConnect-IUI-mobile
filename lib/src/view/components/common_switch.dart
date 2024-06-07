import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_connect_iui_mobile/main.dart';

import '../../constants/app_color.dart';

class CommonSwitch extends StatefulWidget {
  final String value;
  final double width;

  const CommonSwitch({
    Key? key,
    required this.value,
    required this.width
  }) : super(key: key);

  @override
  State<CommonSwitch> createState() => _CommonSwitchState();
}

class _CommonSwitchState extends State<CommonSwitch> {
  Future<void> _persistSwitchValue(bool value) async {
    setState(() {
      userSettings![widget.value] = value;   
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings', json.encode(userSettings));
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width*.15,
      height: widget.width*.08,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          activeColor: AppColor.header,
          inactiveThumbColor: AppColor.header,
          inactiveTrackColor: AppColor.inputText,
          value: userSettings![widget.value]!, 
          onChanged:(value) => _persistSwitchValue(value)
        ),
      ),
    );
  }
}
