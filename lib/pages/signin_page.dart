import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage_plugin/utils/user_secure_storage.dart';

import '../widgets/show_snackbar.dart';
import '../widgets/text_button_builder.dart';
import '../widgets/text_field_builder.dart';
import '../pages/forgot_password_page.dart';
import '../pages/profile_page.dart';
import '../pages/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    final uid = await UserSecureStorage.read('uid');
    final email = await UserSecureStorage.read('email');
    final password = await UserSecureStorage.read('password');
    debugPrint('READ => uid: $uid userEmail: $email, password: $password');
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
    }
  }

  loginUser() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final userId = userCredential.user?.uid;
      debugPrint('uid: $userId');
      if (rememberMe) {
        await UserSecureStorage.write('uid', value: userId!);
        await UserSecureStorage.write('email', value: emailController.text);
        await UserSecureStorage.write('password',
            value: passwordController.text);
      }
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) => const ProfilePage(),
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
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFieldBuilder(
                  controller: passwordController,
                  labelText: 'Enter your password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: TextButtonBuilder(
                    ForgotPasswordPage(),
                    text: 'Forgot Password?',
                  ),
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
                    if (formKey.currentState!.validate()) loginUser();
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
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
      );
}
