import 'package:flutter/material.dart';

class TextButton extends StatefulWidget {
  final String label;
  final Color color;
  final Function onTap;
  TextButton({@required this.label, this.color, this.onTap});

  @override
  State<StatefulWidget> createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (this.widget.onTap != null) {
          this.widget.onTap();
        }
      },
      minWidth: 100.0,
      height: 42.0,
      child: Text(
        this.widget.label,
        style: TextStyle(color: this.widget.color),
      ),
    );
  }
}
