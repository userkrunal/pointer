import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/home_screen.dart';

class PointerController extends GetxController
{
  RxDouble slider=0.0.obs;
  var ccolor = Color(0xff000000).obs;
  RxList<PointerModel> points = <PointerModel>[].obs;
}



class PointerModel {
  Paint paint;
  Offset offset;

  PointerModel(this.paint, this.offset);
}