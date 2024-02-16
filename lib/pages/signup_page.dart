import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/show_snackbar.dart';
import '../widgets/text_button_builder.dart';
import '../widgets/text_field_builder.dart';
import '../pages/signin_page.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();

  // var email = '';
  // var password = '';
  // var confirmPassword = '';
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

  void registerNewUser() async {
    // if (password == confirmPassword) {
    if (passwordController.text == confirmPasswordController.text) {
      try {
        final userCredentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        debugPrint('UserCredentials: $userCredentials');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('Registered Successfully. Please Login...'),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                TextFieldBuilder(
                  controller: emailController,
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
                  controller: passwordController,
                  obscureText: true,
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
                  controller: confirmPasswordController,
                  obscureText: true,
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
                    if (formKey.currentState!.validate()) registerNewUser();
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an Account?'),
                    TextButtonBuilder(SignInPage(), text: 'Login'),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
