import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage_plugin/widgets/show_snackbar.dart';
import 'package:flutter_secure_storage_plugin/widgets/text_button_builder.dart';
import 'package:flutter_secure_storage_plugin/widgets/text_field_builder.dart';

import 'signin_page.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var confirmPassword = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  registerNewUser() async {
    if (password == confirmPassword) {
      try {
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        debugPrint('UserCredentials: $userCredentials');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('Registered Successfully. Please Login...'),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('Password Provided is too Weak');
          ScaffoldMessenger.of(context).showSnackBar(
            showSnackBar('Password Provided is too Weak'),
          );
        } else if (e.code == 'email-already-in-use') {
          debugPrint('Account Already exists');
          ScaffoldMessenger.of(context).showSnackBar(
            showSnackBar('Account Already exists'),
          );
        }
      }
    } else {
      debugPrint('Password and Confirm Password doesn\'t match');
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBar('Password and Confirm Password doesn\'t match'),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('User Sign Up'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              children: [
                TextFieldBuilder(
                  emailController: emailController,
                  labelText: 'Enter your email address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFieldBuilder(
                  emailController: passwordController,
                  labelText: 'Enter your password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFieldBuilder(
                  emailController: confirmPasswordController,
                  labelText: 'Confirm your password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                        confirmPassword = confirmPasswordController.text;
                      });
                      registerNewUser();
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an Account?'),
                    TextButtonBuilder(Login(), text: 'Login'),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
