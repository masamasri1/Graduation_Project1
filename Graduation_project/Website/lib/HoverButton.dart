import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final String? image;
  final Function? hover;
  HoverButton({this.hover, this.image});
  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (val) {
          widget.hover!();
        },
        child: Container(
          height: 80,
          width: 100,
          child: Image(
            image: AssetImage(widget.image!),
          ),
        ));
  }
}
