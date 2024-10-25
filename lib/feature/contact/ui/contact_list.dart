import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactapp/constant/constant.dart';
import 'package:contactapp/constant/lottie_constant.dart';
import 'package:contactapp/database_service/firebase_database_service.dart';
import 'package:contactapp/feature/contact/model/contact_model.dart';
import 'package:contactapp/feature/contact/ui/add_contact.dart';
import 'package:contactapp/feature/contact_detail/ui/contact_detail.dart';
import 'package:contactapp/feature/favourite/ui/favouriteList.dart';
import 'package:contactapp/widgets/app_bar.dart';
import 'package:contactapp/widgets/button.dart';
import 'package:contactapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final FirebaseDatabaseService firebaseDatabaseService =
      FirebaseDatabaseService();
  late Future<List<Contact>> future;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      future = firebaseDatabaseService.fetchContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appBar(context, AppConstant.contactListTitle),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Favouritelist(),));
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                        ),
                        const AppText(
                                  text: 'Favourites',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Contact>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 1.7,
                            )));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Column(
                      children: [
                        LottieConstant.getLottieFile(
                            LottieConstant.noContactData),
                        InkWell(
                            onTap: () {
                              setState(() {
                                future =
                                    firebaseDatabaseService.fetchContacts();
                              });
                            },
                            child: Container(
                                height: 25,
                                alignment: Alignment.center,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const AppText(
                                  text: 'Retry',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )))
                      ],
                    ));
                  } else {
                    List<Contact> contacts = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ContactDetail(
                                  contact: contact,
                                  firstName: contact.firstName,
                                  lastName: contact.lastName,
                                  mobilenumber: contact.contactNumber,
                                  email: contact.email,
                                );
                              },
                            )).then(
                              (value) {
                                setState(() {
                                  future =
                                      firebaseDatabaseService.fetchContacts();
                                });
                              },
                            );
                          },
                          title: AppText(
                              text: '${contact.firstName} ${contact.lastName}'),
                          subtitle: Text(contact.contactNumber),
                          leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Icon(Icons.person)),
                          trailing: InkWell(
                            onTap: () {
                              setState(() {
                                contact.isFavourite =
                                    !(contact.isFavourite ?? false);
                              });
                              FirebaseDatabaseService.updateIsFavorite(
                                  contact.contactNumber,
                                  contact.isFavourite ?? false);
                            },
                            child: Icon(
                              contact.isFavourite ?? false
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: contact.isFavourite ?? false
                                  ? Colors.red
                                  : null,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            AppButton(
              text: AppConstant.addContact,
              isLoading: isLoading,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await Future.delayed(const Duration(seconds: 1));
                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddContact();
                  },
                )).then(
                  (value) {
                    setState(() {
                      future = firebaseDatabaseService.fetchContacts();
                    });
                  },
                );
                setState(() {
                  isLoading = false;
                });
                // FirebaseDatabaseService.addData('8291073112','Rahul','Patil','');
              },
            )
          ],
        ),
      ),
    );
  }
}
