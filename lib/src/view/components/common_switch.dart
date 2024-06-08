import 'package:flutter/material.dart';

import '../../constants/app_color.dart';

class CommonSwitch extends StatefulWidget {
  final bool value;
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
          value: widget.value, 
          onChanged:(value) => setState(() {
            value = !value;
          }) 
        ),
      ),
    );
  }
}
