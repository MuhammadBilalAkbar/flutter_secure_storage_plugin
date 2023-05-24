import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'forgot_password.dart';
import 'signup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.email = '', this.password = ''})
      : super(key: key);

  final String email;
  final String password;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  final _storage = const FlutterSecureStorage();

  static bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    debugPrint('userEmail: $userEmail');
    debugPrint('userPassword: $userPassword');
    debugPrint('userEmail: ${widget.email}');
    debugPrint('userPassword: ${widget.password}');
  }

  userLogin() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      debugPrint(userCredential.user?.uid);
      if (_isChecked) {
        await _storage.write(key: 'uid', value: userCredential.user?.uid);
        await _storage.write(key: 'email', value: userEmail);
        await _storage.write(key: 'password', value: userPassword);
      }
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Profile(),
        ),
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('User Login'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: emailController,
                    // initialValue: widget.email,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Email: ',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
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
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: passwordController,
                    // initialValue: widget.password,
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password: ',
                      labelStyle: TextStyle(fontSize: 20.0),
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
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                          debugPrint("Handle Remember Me");
                          debugPrint('isChecked: $_isChecked');
                        },
                      )),
                  const SizedBox(width: 10.0),
                  const Text("Remember Me")
                ]),
                Container(
                  margin: const EdgeInsets.only(left: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              userEmail = emailController.text;
                              userPassword = passwordController.text;
                            });
                            userLogin();
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          )
                        },
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
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
                              pageBuilder: (context, a, b) => const Signup(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                            (route) => false)
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
