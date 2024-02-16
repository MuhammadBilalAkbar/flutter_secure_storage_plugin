import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/text_field_builder.dart';
import '../widgets/show_snackbar.dart';
import '../pages/signin_page.dart';
import '../pages/signup_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBar('Password Reset Email has been sent!'),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('No user found for that email.'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: const Text(
                'Reset Link will be sent to your email id!',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: TextFieldBuilder(
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate())
                                resetPassword();
                            },
                            child: const Text('Send Email'),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) =>
                                      const SignInPage(),
                                ),
                                (route) => false,
                              ),
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an Account?',
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) =>
                                      const Signup(),
                                ),
                                (route) => false,
                              ),
                            },
                            child: const Text('Signup'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
