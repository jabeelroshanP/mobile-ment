import 'package:flutter/material.dart';
import 'package:mobilement/constants/colors.dart';
import 'package:mobilement/constants/text.dart';

AppBar customAppBar([List<Widget>? actionButtons]) {
  return AppBar(
    backgroundColor: AppColors.appBarBg,
    title: Row(children: [
        Text(
          TextConsts.mobile,
          style: TextStyle(
            color: AppColors.appBarMobileTitle,
            fontWeight: FontWeight.bold,fontSize: 27
          ),
        ),
        Text(
          TextConsts.mend,
          style: TextStyle(
            color: AppColors.whiteClr,
            fontWeight: FontWeight.bold,fontSize: 27
          ),
        ),
      ],
    ),
    actions: actionButtons,
  );
  
}
