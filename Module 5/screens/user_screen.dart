import 'package:data_base/database/db_helper.dart';
import 'package:data_base/model/user.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  User? user;

  UserScreen({this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<String> courses = ['Java', 'Dart', 'Android', 'Python'];
  String? selectedCourse;

  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  DbHelper dbHelper = DbHelper();

  Future<void> updateUser(User user, BuildContext context) async {
    int result = await dbHelper.updateRecord(user);

    if (result > 0) {
      print('Record updated successfully..');
      Navigator.pop(context, user);
    } else {
      print('Getting error..');
      Navigator.pop(context, null);
    }
  }

  Future<void> addUser(User user, BuildContext context) async {
    print(user.toMap());
    int result = await dbHelper.insertRecord(user);

    if (result != -1) {
      print('result : $result');
      user.id = result;
      print('Record saved successfully..');
      Navigator.pop(context, user);
    } else {
      print('Getting error..');
      Navigator.pop(context, null);
    }
  }

  @override
  void initState() {
    if (widget.user != null) {
      // update
      _fNameController.text = widget.user!.fName;
      _lNameController.text = widget.user!.lName;
      _emailController.text = widget.user!.email;
      _contactController.text = widget.user!.contact;
      selectedCourse = widget.user!.course;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _fNameController,
                        decoration: InputDecoration(labelText: 'First name'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _lNameController,
                        decoration: InputDecoration(labelText: 'Last name'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email address'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact'),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  isExpanded: true,
                  hint: Text('Select Course'),
                  value: selectedCourse,
                  items: List.generate(
                    courses.length,
                    (index) => DropdownMenuItem(
                      child: Text(courses[index]),
                      value: courses[index],
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedCourse = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      String fName = _fNameController.text.trim();
                      String lName = _lNameController.text.trim();
                      String email = _emailController.text.trim();
                      String contact = _contactController.text.trim();

                      print('''
                      Name : $fName $lName
                      Email : $email
                      Contact : $contact
                      Course : $selectedCourse
                      ''');

                      User user = User(
                          id: widget.user != null ? widget.user!.id : null,
                          fName: fName,
                          lName: lName,
                          email: email,
                          contact: contact,
                          course: selectedCourse!,
                          createdAt: widget.user != null
                              ? widget.user!.createdAt
                              : DateTime.now().millisecondsSinceEpoch);

                      if (widget.user != null) {
                        // update
                        updateUser(user, context);
                      } else {
                        addUser(user, context);
                      }
                    },
                    child:
                        Text(widget.user != null ? 'Update User' : 'Add User'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
