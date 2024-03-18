class User {
  int? id;
  String fName;
  String lName;
  String email;
  String contact;
  String course;
  int createdAt;

  User(
      {this.id,
      required this.fName,
      required this.lName,
      required this.email,
      required this.contact,
      required this.course,
      required this.createdAt});

  // convert object into map
  Map<String, dynamic> toMap() {
    return {
      'fname': fName,
      'lname': lName,
      'email': email,
      'contact': contact,
      'course': course,
      'createdAt': createdAt
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        fName: map['fname'],
        lName: map['lname'],
        email: map['email'],
        contact: map['contact'],
        course: map['course'],
        createdAt: map['createdAt']);
  }
}
