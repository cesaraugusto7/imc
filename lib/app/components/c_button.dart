import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  late double height, width, borderSize, borderRadius, fontSize;
  late String text;
  late Object colorText, colorButton, colorBorder;
  final VoidCallback onClick;

  CButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onClick,
    String? text,
    double? borderSize,
    double? borderRadius,
    double? fontSize,
    Color? colorText,
    Color? colorButton,
    Color? colorBorder,
  }) : super(key: key) {
    this.text = text ?? '';
    this.fontSize = fontSize ?? 14;
    this.borderSize = borderSize ?? 0;
    this.borderRadius = borderRadius ?? 0;
    this.colorText = colorText ?? Colors.black;
    this.colorButton = colorButton ?? Colors.grey;
    this.colorBorder = colorBorder ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: colorText as Color, fontSize: fontSize),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
              color: colorBorder as Color,
              width: borderSize,
              style: borderSize != 0 ? BorderStyle.solid : BorderStyle.none),
          color: colorButton as Color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
