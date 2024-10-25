import 'package:contactapp/constant/constant.dart';
import 'package:contactapp/database_service/firebase_database_service.dart';
import 'package:contactapp/feature/contact/model/contact_model.dart';
import 'package:contactapp/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class Favouritelist extends StatefulWidget {
  const Favouritelist({super.key});

  @override
  State<Favouritelist> createState() => _FavouritelistState();
}

class _FavouritelistState extends State<Favouritelist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
               padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: appBar(context, AppConstant.favourite),
            ),
            Expanded(
              child: FutureBuilder<List<Contact>>(
                future: FirebaseDatabaseService.fetchFavoriteContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No favorite contacts found.'));
                  } else {
                    // Display the list of favorite contacts
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final contact = snapshot.data![index];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text('${contact.firstName} ${contact.lastName}'),
                          subtitle: Text(contact.contactNumber),
                          trailing: const Icon(
                            Icons.favorite,
                            color: Colors.red, // Indicating favorite
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
