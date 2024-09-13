import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _username,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('USERNAME'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('EMAIL'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('PASSWORD'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool UsernameExist = await _isUsernameTaken(_username.text.trim());
                           bool emailExists = await _isEmailTaken(_email.text.trim());

                          if(UsernameExist){
                             ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                        content: Text('Username already exists. Please choose another.'),
                             ),
                         );
                          return;
                          }
                            if (emailExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                        content: Text('Email already exists. Please use another email.'),
                          ),
                     );
                       return;
                        }

                          try {
                            UserCredential userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _email.text.trim(),
                              password: _password.text.trim(),
                            );
                          if (userData != null) {
                              FirebaseFirestore.instance.collection('users').doc(userData.user!.uid).set({
                                'uid': userData.user!.uid,
                                'email': userData.user!.email,
                                'createdAt': DateTime.now(),
                                'status': 1,
                              }).then((value) async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', true);
                              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                              });
                            }
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              ),
                            );
                          }
                          _formKey.currentState!.save();
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
Future<bool> _isUsernameTaken(String username) async {
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username)
      .get();

  final List<DocumentSnapshot> documents = result.docs;
  return documents.isNotEmpty;
}


Future<bool> _isEmailTaken(String email) async {
  try {
    final List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  } catch (e) {
    return false; // Or handle the error as necessary
  }
}

}
