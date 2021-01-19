import 'package:chautari/extensions/color_extensions.dart';
import 'package:chautari/utilities/utilities.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  final String title;
  final String description;

  const LoadingScreen({Key key, this.title, this.description})
      : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        // color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.black54
      ),
      Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: Container(
          height: 102,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8),
                            Text(widget.description,
                                style: GoogleFonts.poppins(
                                    color: HexColor('#777777'),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))
                          ]),
                    ),
                    AnimatedProgressHud()
                    // RotationTransition(
                    //   turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    //   child: DashedBorder(),
                    // ),

                    //         Container(
                    //           width: 54,
                    //           height: 54,
                    //           decoration: BoxDecoration(
                    //             border: DashPathBorder.all(
                    //             dashArray: CircularIntervalList<double>(<double>[3, 8]),
                    // )
                    //           )
                    //         ,)
                  ]),
            ),
          ),
        ),
      )
    ]);
  }
}

class AnimatedProgressHud extends StatefulWidget {
  @override
  _AnimatedProgressHudState createState() => _AnimatedProgressHudState();
}

class _AnimatedProgressHudState extends State<AnimatedProgressHud>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

    _controller.forward();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * -pi,
            child: Image(
              width: 54,
              height: 54,
              fit: BoxFit.fill,
              image: getIconFromAsset('ic_loading.png'),
            ),
          );
        });
  }
}
