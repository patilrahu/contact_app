import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  int? maxlenght = 0;

   CustomTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,this.maxlenght
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0), 
        borderRadius: BorderRadius.circular(8.0), 
      ),
      child: TextField(maxLength: widget.maxlenght,
        controller: widget.controller, 
        keyboardType: widget.keyboardType, 
        decoration: InputDecoration(counterText: '',
          border: InputBorder.none, 
          hintText: widget.hintText, 
        ),
      ),
    );
  }
}
