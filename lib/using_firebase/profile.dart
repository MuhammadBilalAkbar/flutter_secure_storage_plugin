import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      debugPrint('Verification Email has been sent');
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
    debugPrint('userId: $userId');
    debugPrint('email: $email');
    debugPrint('password: $password');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Welcome User'),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await storage.delete(key: 'uid');
                  final userEmail = await storage.read(key: 'email');
                  final userPassword = await storage.read(key: 'password');
                  debugPrint('$userEmail $userPassword');
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(
                          email: userEmail!,
                          password: userPassword!,
                        ),
                      ),
                      (route) => false);
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                child: const Text('Logout'),
              )
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Text(
                'User ID: $uid',
                style: const TextStyle(fontSize: 18.0),
              ),
              Row(
                children: [
                  Text(
                    'Email: $email',
                    style: const TextStyle(fontSize: 10.0),
                  ),
                  user!.emailVerified
                      ? const Text(
                          'verified',
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )
                      : TextButton(
                          onPressed: () => {verifyEmail()},
                          child: const Text('Verify Email'),
                        ),
                ],
              ),
              Text(
                'Created: $creationTime',
                style: const TextStyle(fontSize: 18.0),
              ),
              ElevatedButton(
                onPressed: getUserDetail,
                child: const Text('Get User Detail'),
              ),
            ],
          ),
        ),
      );
}
