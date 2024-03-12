import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groundbooking/api.dart';
import 'package:groundbooking/widjents/textfield.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController dobController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedGender = 'Male';
  XFile? image = XFile('No Image picked');

  Future<XFile?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomTextField(
                  labelText: 'Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Nmae';
                    } else if (value.length < 3) {
                      return 'Must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                CustomTextField(
                  labelText: 'Address',
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Address';
                    } else if (value.length < 3) {
                      return 'Must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                CustomTextField(
                  labelText: 'Username',
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    } else if (value.length < 3) {
                      return 'Must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                CustomTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length < 6) {
                      return 'Must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                CustomTextField(
                  labelText: 'E-mail',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    } else if (value.length < 3) {
                      return 'Must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Phone',
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Phone';
                    } else if (value.length < 10) {
                      return 'Must be at least 10 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: 'DD/MM/YYYY',
                  labelText: 'Date Of Birth',
                  controller: dobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter DOB';
                    } else if (value.length < 10) {
                      return 'invalid';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  value: selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          image = await pickImage();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text('Pick Image'),
                          ),
                        )),
                    Text(image!.path),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // You can also access the input values directly from the controllers
                      print(nameController.text);

                      print(addressController.text);
                      print(emailController.text);
                      print(dobController.text);
                      print(addressController.text);

                      Map<String, dynamic> dataToPost = {
                        'username': usernameController.text,
                        'password': passwordController.text,
                        'name': nameController.text,
                        'address': addressController.text,
                        'email': emailController.text,
                        'phoneno': phoneController.text,
                        'date_of_birth': dobController.text,
                        'gender': selectedGender,
                        'user_type':'MEMBER',
                        'photo':image!.path,
                        'date_of_join': '2024-01-12T04:06:04.616570Z'
                      };
                      postDataToDjango(dataToPost,image!.path);
                      print(image!.path);
                    }
                  },
                  child: Text('Submit'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
     ),
);
}
}