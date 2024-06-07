import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';

Widget buildShimmerListView(double width) {
  return ListView.builder(
    itemCount: 10,  // Number of shimmer items to display
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: width * .008),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: width * .06),
            tileColor: AppColor.inputText.withOpacity(.2),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.contact_emergency),
            ),
            title: Container(
              width: width * 0.6,
              height: 20,
              color: Colors.white,
            ),
            subtitle: Container(
              width: width * 0.4,
              height: 15,
              color: Colors.white,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 15,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
