import 'package:flutter/material.dart';

class SweepButton extends StatefulWidget {
  final String label;
  final Color color;
  final Color tapColor;
  final Function onTap;
  SweepButton({@required this.label, this.color, this.tapColor, this.onTap});

  @override
  State<StatefulWidget> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<SweepButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  Color getButtonColor() {
    return (_animation.value == null ||
            _animation.status == AnimationStatus.completed
        ? Theme.of(context).accentColor
        : _animation.value);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      vsync: this,
      upperBound: 1.0,
    );

    _animation = ColorTween(begin: this.widget.color, end: this.widget.tapColor)
        .animate(_controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reset();
            }
          });

    print(_animation.value);
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
      builder: (context, Widget child) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: getButtonColor(),
            child: MaterialButton(
              onPressed: () {
                _controller.forward();
                if (this.widget.onTap != null) {
                  this.widget.onTap();
                }
              },
              minWidth: 200.0,
              height: 42.0,
              child: Text(
                this.widget.label,
              ),
            ),
          ),
        );
      },
    );
  }
}
