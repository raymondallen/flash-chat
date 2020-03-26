import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final String label;
  final Color color;
  final Function onTap;
  RoundedButton({@required this.label, this.color, this.onTap});

  @override
  State<StatefulWidget> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        color: this.widget.color,
        child: MaterialButton(
          onPressed: () {
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
  }
}
