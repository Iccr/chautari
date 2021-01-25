import 'package:chautari/utilities/loading/loading_view.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// how to use

//  ProgressHud(
//         isLoading: true,
//         child: HomePage(),
//       ),

class ProgressHud extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  Color color;
  Widget progressIndicator;
  final Widget child;
  final String title;
  final String description;

  ProgressHud({
    @required this.isLoading,
    @required this.child,
    this.opacity = 0.5,
    this.title,
    this.description,
    this.progressIndicator,
    this.color,
  }) {
    progressIndicator = LoadingScreen(
      title: this.title ?? 'Loading...',
      description: this.description ?? 'Please wait for a while',
    );
    color = ChautariColors.black.withOpacity(0.5);
  }

  @override
  _ProgressHudState createState() => _ProgressHudState();
}

class _ProgressHudState extends State<ProgressHud>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool _overlayVisible;

  _ProgressHudState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      // ignore: unnecessary_statements
      if (status == AnimationStatus.forward) {
        setState(() => {_overlayVisible = true});
      }
      // ignore: unnecessary_statements
      if (status == AnimationStatus.dismissed) {
        setState(() => {_overlayVisible = false});
      }
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(ProgressHud oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Theme.of(context).colorScheme.background,
              ),
              opacity: widget.opacity,
            ),
            widget.progressIndicator,
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}

class CircularBorder extends StatefulWidget {
  final Widget icon;

  const CircularBorder({Key key, this.icon}) : super(key: key);

  @override
  _CircularBorderState createState() => _CircularBorderState();
}

class _CircularBorderState extends State<CircularBorder>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(from: 0.0);
      }
    });
  }

  final Color color = Colors.redAccent;

  final double size = 40;

  final double width = 8;

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              widget.icon == null ? Container() : widget.icon,
              CustomPaint(
                size: Size(size, size),
                foregroundPainter:
                    new MyPainter(completeColor: color, width: width),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyPainter extends CustomPainter {
  Color lineColor = Colors.transparent;
  Color completeColor;
  double width;
  MyPainter({this.completeColor, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width * 0.001) / 2;

    double arcAngle = 2 * -pi * percent;
    print("$radius - radius");
    print("$arcAngle - arcAngle");
    print("${radius / arcAngle} - divider");

    for (var i = 0; i < 8; i++) {
      var init = (-pi / 2) * (i / 2);

      canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), init,
          arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// CircularBorder(
//         width: 10,
//         size: 50,
//         color: Colors.redAccent,
//       )

class ProgressHudView extends StatelessWidget {
  const ProgressHudView();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          // color: Colors.black45,
          ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white),
          child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text("Loading..."), CircularBorder()],
              )),
        ),
        height: 100,
      ),
    ]);
  }
}
