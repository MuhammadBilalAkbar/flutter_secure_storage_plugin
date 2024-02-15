import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage_plugin/widgets/show_snackbar.dart';

import '../widgets/text_button_builder.dart';
import '../widgets/text_field_builder.dart';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'signup_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void getUserDetail() async {
    final uid = await storage.read(key: 'uid');
    final email = await storage.read(key: 'email');
    final password = await storage.read(key: 'password');
    debugPrint('READ => userId: $uid, userEmail: $email, password: $password');
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
    }
  }

  loginUser() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      debugPrint('uid: ${userCredential.user?.uid}');
      if (rememberMe) {
        await storage.write(key: 'uid', value: userCredential.user?.uid);
        await storage.write(key: 'email', value: userEmail);
        await storage.write(key: 'password', value: userPassword);
      }
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) => const Profile(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No User Found for that Email');
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('No User Found for that Email'),
        );
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong Password Provided by User');
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('Wrong Password Provided by User'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('User Login'),
        ),
        body: Form(
          key: formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  TextFieldBuilder(
                    emailController: emailController,
                    labelText: 'Enter your email address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please enter valid email';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) =>
                            setState(() => rememberMe = value!),
                        activeColor: Colors.blue,
                      ),
                      const Text("Remember Me")
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          userEmail = emailController.text;
                          userPassword = passwordController.text;
                        });
                        loginUser();
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: TextButtonBuilder(
                      ForgotPassword(),
                      text: 'Forgot Password?',
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButtonBuilder(Signup(), text: 'Signup'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
