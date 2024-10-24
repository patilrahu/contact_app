import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieConstant {
static String _getLottiePath(String fileName) {
    return 'assets/$fileName';
  }

  static var welcomeLottie = _getLottiePath('welcome.json');
  static var noContactData = _getLottiePath('noContactData.json');
static Widget getLottieFile(String fileName,{double? height,double? width}) {
    return LottieBuilder.asset(fileName,height: height,width: width,);
  }
 
}

 