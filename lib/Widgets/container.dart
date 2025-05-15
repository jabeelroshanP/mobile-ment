//Home containers 4

import 'package:flutter/material.dart';
import 'package:mobilement/constants/colors.dart';

Widget homeContainers([icons,texts]) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 175,
        width: 180,
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //     colors: [AppColors.justSample, AppColors.darkBluePurple],
            //     end: Alignment.bottomCenter,
            //     begin: Alignment.topCenter,),
            color: AppColors.appBarMobileTitle,
                borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                   Container(height: 35,width: 35,decoration: BoxDecoration(color: Colors.amber),)
                  ],
                ),
      ),
    ),
  );
}
