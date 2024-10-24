import 'package:contactapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text; 
  final VoidCallback onPressed; 
  final Color? color; 
  final Color? textColor;
  final double? fontSize; 
  final double? borderRadius; bool? isLoading;

   AppButton({
    Key? key,
    required this.text,
    required this.onPressed, 
    this.color, 
    this.textColor,
    this.fontSize, 
    this.borderRadius,this.isLoading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width,padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0), 
          ),
          
        ),
        child: (isLoading ?? false) ? const SizedBox(height: 20,width: 20, child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.5,),) : AppText(
        text:   text,
        
            fontSize: fontSize ?? 16.0, 
            color: textColor ?? Colors.white, 
            fontWeight: FontWeight.bold,
          
        ),
      ),
    );
  }
}
