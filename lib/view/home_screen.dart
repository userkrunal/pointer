import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer/pointer/controller/pointer_controller.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PointerController controller = Get.put(PointerController());
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 5.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent.shade100,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.points.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
                  controller.points.add(PointerModel(
                      Paint()
                        ..color = controller.ccolor.value
                        ..strokeCap = StrokeCap.round
                        ..strokeWidth = controller.slider.value
                        ..isAntiAlias = true,
                      renderBox!.globalToLocal(details.globalPosition)));
                });
              },
              onPanEnd: (details) {
                setState(() {
                  controller.points.add(PointerModel(Paint(), Offset.zero));
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  RenderBox? renderBox =
                  context.findRenderObject() as RenderBox?;
                  controller.points.add(PointerModel(
                      Paint()
                        ..color = controller.ccolor.value
                        ..strokeCap = StrokeCap.square
                        ..strokeWidth = controller.slider.value
                        ..isAntiAlias = true,
                      renderBox!.globalToLocal(details.globalPosition)));
                });
              },
              child: Container(
                width: 100.w,
                height: 72.h,
                child: CustomPaint(
                  painter: Customdrawing(controller.points),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 13.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.cyanAccent.shade100,
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.brush),
                    // ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.opacity),
                    // ),
                    // // IconButton(
                    // //   onPressed: () {},
                    // //   icon: Icon(Icons.),
                    // // ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.camera),
                    // ),
                    //
                    colorPick(Colors.red),
                    colorPick(Colors.purpleAccent),
                    colorPick(Colors.pink),
                    colorPick(Colors.indigoAccent),
                    colorPick(Colors.limeAccent),
                    colorPick(Colors.lightGreen),
                  ],
                ),
                Obx(
                      () => Slider(
                    value: controller.slider.value,
                    min: 0,
                    activeColor: controller.ccolor.value,
                    inactiveColor: Colors.indigo.shade100,
                    max: 20,
                    onChanged: (value) {
                      controller.slider.value=value;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell colorPick(Color c1) {
    return InkWell(
      onTap: () {
        controller.ccolor.value=c1;
      },
      child: Container(
        height: 4.h,
        width: 10.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: c1,
        ),
      ),
    );
  }
}


class Customdrawing extends CustomPainter {
  List<PointerModel> pointsList;

  Customdrawing(this.pointsList);

  List<Offset> offlist = [];

  void clear() {
    pointsList.clear();
    offlist.clear();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < (pointsList.length - 1); i++) {
      if (pointsList[i] != null && pointsList[i + 1] == null) {
        canvas.drawLine(pointsList[i].offset, pointsList[i + 1].offset,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] != null) {
        offlist.clear();
        offlist.add(pointsList[i].offset);
        offlist.add(Offset(
            pointsList[i].offset.dx + 0.1, pointsList[i].offset.dy + 0.1));
        canvas.drawPoints(PointMode.points, offlist, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}