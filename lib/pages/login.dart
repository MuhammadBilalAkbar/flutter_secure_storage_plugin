import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forgot_password.dart';
import 'profile.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

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
    debugPrint('Login => userId: $uid');
    debugPrint('Login => userEmail: $email');
    debugPrint('Login => userPassword: $password');
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
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'No User Found for that Email',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong Password Provided by User');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Wrong Password Provided by User',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
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
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: [
                TextFormField(
                  controller: emailController,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Enter your email address',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: passwordController,
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter your password',
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                          debugPrint('rememberMe: $rememberMe');
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Text("Remember me")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) =>
                                const ForgotPassword(),
                          ),
                          (route) => false,
                        ),
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an Account? '),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => const Signup(),
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
      );
}
