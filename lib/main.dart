import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer/view/home_screen.dart';
import 'package:sizer/sizer.dart';


void main()
{
  runApp(
    Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(p0) => HomeScreen()
        },
      );
    },)
  );
}