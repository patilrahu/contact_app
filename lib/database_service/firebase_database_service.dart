import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactapp/feature/contact/model/contact_model.dart';

class FirebaseDatabaseService {
  static var dataBaseName = 'contact';
  static CollectionReference contactsCollection =
      FirebaseFirestore.instance.collection(dataBaseName);
  static Future<void> addData(String contactNumber, String firstName,
      String lastName, String email) async {
    final data = {
      "contactNumber": contactNumber,
      "firstName": firstName,
      "lastName": lastName,
      "isFavourite": false,
      "email": email
    };

    contactsCollection.add(data);
  }

  Future<List<Contact>> fetchContacts() async {
    try {
      QuerySnapshot snapshot = await contactsCollection.get();

      return snapshot.docs.map((doc) {
        return Contact.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching contacts: $e');
      return [];
    }
  }

  static Future<bool> deleteContact(String mobileNumber) async {
    try {
      QuerySnapshot snapshot = await contactsCollection
          .where('contactNumber', isEqualTo: mobileNumber)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        String documentId = snapshot.docs.first.id;
        await contactsCollection.doc(documentId).delete();
        print('Contact with mobile number $mobileNumber deleted successfully');
        return true;
      } else {
        print('No contact found with mobile number $mobileNumber');
        return false;
      }
    } catch (e) {
      print('Error deleting contact: $e');
      return false;
    }
  }

  static Future<bool> updateContact(
      String mobileNumber, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot snapshot = await contactsCollection
          .where('contactNumber', isEqualTo: mobileNumber)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String documentId = snapshot.docs.first.id;

        await contactsCollection.doc(documentId).update(updatedData);
        print('Contact with mobile number $mobileNumber updated successfully');
        return true;
      } else {
        print('No contact found with mobile number $mobileNumber');
        return false;
      }
    } catch (e) {
      print('Error updating contact: $e');
      return false;
    }
  }

  static Future<bool> updateIsFavorite(
      String mobileNumber, bool isFavorite) async {
    try {
    
      QuerySnapshot snapshot = await contactsCollection
          .where('contactNumber', isEqualTo: mobileNumber)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String documentId = snapshot.docs.first.id;

       
        await contactsCollection
            .doc(documentId)
            .update({'isFavourite': isFavorite});
        print(
            'Contact with mobile number $mobileNumber updated successfully: isFavourite = $isFavorite');
        return true;
      } else {
        print('No contact found with mobile number $mobileNumber');
        return false;
      }
    } catch (e) {
      print('Error updating isFavorite: $e');
      return false;
    }
  }

 static Future<List<Contact>> fetchFavoriteContacts() async {
  try {
    QuerySnapshot snapshot = await contactsCollection
        .where('isFavourite', isEqualTo: true)
        .get();

    return snapshot.docs.map((doc) {
      return Contact.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print('Error fetching favorite contacts: $e');
    return [];
  }
}
}
