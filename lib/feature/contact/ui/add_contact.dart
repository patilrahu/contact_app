import 'package:contactapp/constant/constant.dart';
import 'package:contactapp/database_service/firebase_database_service.dart';
import 'package:contactapp/feature/contact/model/contact_model.dart';
import 'package:contactapp/widgets/app_bar.dart';
import 'package:contactapp/widgets/app_textField.dart';
import 'package:contactapp/widgets/button.dart';
import 'package:contactapp/widgets/toast.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  bool? isFromEdit = false;
  Contact? contact;
  AddContact({super.key, this.isFromEdit = false, this.contact});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    if (widget.isFromEdit ?? false) {
      setState(() {
        firstnameController.text = widget.contact?.firstName ?? '';
        lastnameController.text = widget.contact?.lastName ?? '';
        mobilenumberController.text = widget.contact?.contactNumber ?? '';
        emailController.text = widget.contact?.email ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: appBar(
                    context,
                    widget.isFromEdit ?? false
                        ? AppConstant.editContact
                        : AppConstant.addContact),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        controller: firstnameController,
                        keyboardType: TextInputType.name,
                        hintText: 'Enter First Name'),
                    CustomTextField(
                        controller: lastnameController,
                        keyboardType: TextInputType.name,
                        hintText: 'Enter Last Name '),
                    CustomTextField(
                        maxlenght: 10,
                        controller: mobilenumberController,
                        keyboardType: TextInputType.number,
                        hintText: 'Enter Mobile Number'),
                    CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter Email Address'),
                  ],
                ),
              ),
              AppButton(
                text: widget.isFromEdit ?? false
                    ? AppConstant.save
                    : AppConstant.addContact,
                isLoading: isLoading,
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 1));
                  if (_validateField()) {
                    if (widget.isFromEdit ?? false) {
                      Map<String, dynamic> updatedData = {
                        'firstName': firstnameController.text,
                        'lastName': lastnameController.text,
                        'contactNumber':
                            mobilenumberController.text, 
                        'email':emailController.text
                      };
                      await FirebaseDatabaseService.updateContact(
                          widget.contact?.contactNumber ?? '', updatedData);
                       // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                     // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                    } else {
                      await FirebaseDatabaseService.addData(
                          mobilenumberController.text,
                          firstnameController.text,
                          lastnameController.text,
                          emailController.text);
                           // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                    }
                   
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _validateField() {
    if (firstnameController.text == "") {
      showToast('Please enter your first name', isError: true);
      return false;
    }

    if (lastnameController.text == "") {
      showToast('Please enter your last name', isError: true);
      return false;
    }

    if (mobilenumberController.text == "") {
      showToast('Please enter your mobile number', isError: true);
      return false;
    }
    if (mobilenumberController.text.length != 10) {
      showToast('Mobile number must be 10 digits', isError: true);
      return false;
    }
    if (emailController.text == "") {
      showToast('Email Cannot be empty.', isError: true);
      return false;
    }
    if (!isValidEmail(emailController.text)) {
      showToast('Please enter valid email.', isError: true);
      return false;
    }
    return true;
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}
