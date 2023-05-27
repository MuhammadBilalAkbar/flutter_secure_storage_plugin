import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  final user = FirebaseAuth.instance.currentUser;

  final storage = const FlutterSecureStorage();

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      debugPrint('Verification Email has been sent.');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  void getUserDetail() async {
    final userId = await storage.read(key: 'uid');
    final email = await storage.read(key: 'email');
    final password = await storage.read(key: 'password');
    debugPrint('Profile => userId: $userId');
    debugPrint('Profile => email: $email');
    debugPrint('Profile => password: $password');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('User Profile'),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await storage.delete(key: 'uid');
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text('Logout'),
              )
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children: [
              Text(
                'User ID: $uid',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text('Email: $email'),
                  const SizedBox(width: 20),
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
                style: const TextStyle(fontSize: 24),
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
