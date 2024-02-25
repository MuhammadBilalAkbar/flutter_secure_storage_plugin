import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/user_secure_storage.dart';
import '../widgets/show_snackbar.dart';
import '../pages/signin_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  Future<void> verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      debugPrint('Verification Email has been sent.');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBar('Verification Email has been sent'),
      );
    }
  }

  Future<void> getUserDetail() async {
    final userId = await UserSecureStorage.read('uid');
    final email = await UserSecureStorage.read('email');
    final password = await UserSecureStorage.read('password');
    debugPrint('Profile => userId: $userId');
    debugPrint('Profile => email: $email');
    debugPrint('Profile => password: $password');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await UserSecureStorage.delete('uid');
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          child: Column(
            children: [
              Text('User ID: $uid'),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'Email: $email',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 10),
                  user!.emailVerified
                      ? const Text('verified')
                      : TextButton(
                          onPressed: verifyEmail,
                          child: const Text('Verify Email'),
                        ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Created: $creationTime',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: getUserDetail,
                child: const Text('Get User Detail'),
              ),
            ],
          ),
        ),
      );
}
