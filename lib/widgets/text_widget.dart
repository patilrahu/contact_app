import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text; 
  final double? fontSize; 
  final FontWeight? fontWeight; 
  final Color? color; 
  final TextAlign? textAlign; 
  final int? maxLines; 

  const AppText({
    Key? key,
    required this.text,
    this.fontSize, 
    this.fontWeight, 
    this.color, 
    this.textAlign, 
    this.maxLines, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 16.0,
        fontWeight: fontWeight ?? FontWeight.normal, 
        color: color ?? Colors.black, 
      ),
      textAlign: textAlign ?? TextAlign.left, 
    );
  }
}
