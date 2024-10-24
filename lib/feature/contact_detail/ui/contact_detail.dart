import 'package:contactapp/database_service/firebase_database_service.dart';
import 'package:contactapp/feature/contact/model/contact_model.dart';
import 'package:contactapp/feature/contact/ui/add_contact.dart';
import 'package:contactapp/widgets/app_bar.dart';
import 'package:contactapp/widgets/text_widget.dart';
import 'package:contactapp/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactDetail extends StatefulWidget {
  String firstName;
  String lastName;
  String mobilenumber;
  String email;
  Contact contact;
  ContactDetail(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.mobilenumber,
      required this.email,
      required this.contact});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: appBar(context, ''),
          ),
          Expanded(
            child: Visibility(visible: !isLoading,
            replacement: const Center(child: SizedBox(height: 30,width: 30, child: CircularProgressIndicator(color: Colors.black,strokeWidth: 1.5,),),),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 30, top: 40),
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey),
                        width: 60,
                        child: const Icon(
                          Icons.person,
                          size: 50,
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "${widget.firstName} ${widget.lastName}",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          InkWell(
                            onTap: () {
                              launchUrlString("tel://${widget.mobilenumber}");
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.green),
                                child: const Icon(
                                  Icons.call,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: AppText(
                        text: "+91 ${widget.contact.contactNumber}",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 1));
                  final success = await FirebaseDatabaseService.deleteContact(
                      widget.mobilenumber);
                  if (success) {
                    setState(() {
                    isLoading = false;
                  });
                    showToast('Contact Delete Successfully');
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                  } else {
                     setState(() {
                    isLoading = false;
                  });
                    showToast('Contact Delete Failed', isError: true);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        AppText(
                          text: 'Delete Contact',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    )),
              ),
              const SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddContact(
                          isFromEdit: true,contact: widget.contact,
                        ),
                      ));
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        AppText(
                          text: 'Edit Contact',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }
}
