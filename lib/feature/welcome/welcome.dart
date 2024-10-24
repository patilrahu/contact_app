import 'package:contactapp/constant/constant.dart';
import 'package:contactapp/constant/lottie_constant.dart';
import 'package:contactapp/feature/contact/ui/contact_list.dart';
import 'package:contactapp/widgets/button.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = false;
    });
  }

  _navigateContact()async {
    setState(() {
      isLoading = true;
    });
await Future.delayed(const Duration(seconds: 1));
// ignore: use_build_context_synchronously
Navigator.push(context,MaterialPageRoute(builder: (context) => const ContactList(),));
 setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
     Padding(padding: const EdgeInsets.only(left: 20,right: 20),child:LottieConstant.getLottieFile(LottieConstant.welcomeLottie,)),
Padding(
  padding: const EdgeInsets.only(top: 20),
  child: AppButton(text: AppConstant.welcomeButtonTitle,isLoading: isLoading, onPressed: () {
    _navigateContact();
  },),
)
    ],),);
  }
}