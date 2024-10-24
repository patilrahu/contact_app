class Contact {
  final String contactNumber;
  final String firstName;
  final String lastName;
   bool? isFavourite;
  final String email;

  Contact({
    required this.contactNumber,
    required this.firstName,
    required this.lastName,
     this.isFavourite,
    required this.email,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'contactNumber': contactNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isFavourite': isFavourite,
      'email': email,
    };
  }


  factory Contact.fromMap(Map<String, dynamic>? map) {
    return Contact(
      contactNumber: map?['contactNumber'],
      firstName: map?['firstName'],
      lastName: map?['lastName'],
      isFavourite: map?['isFavourite'] ?? false,
      email: map?['email'],
    );
  }
}
