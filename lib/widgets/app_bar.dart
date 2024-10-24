import 'package:contactapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context,String title) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Row(children: [
      const Icon(Icons.chevron_left,size: 25,color: Colors.black,),
      AppText(text: title,fontSize: 15,fontWeight: FontWeight.w600,)
    ],),
  );
}