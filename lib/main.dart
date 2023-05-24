import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'using_firebase/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'using_firebase/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _initialization = Firebase.initializeApp();
  final _storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    final value = await _storage.read(key: 'uid');
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            title: 'Flutter Firebase EMail Password Auth',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            debugShowCheckedModeBanner: false,

            /// secure_storage_official
            // home: const SecureStorageOfficial(),
            home: FutureBuilder(
              future: checkLoginStatus(),
              builder: (context, snapshot) {
                if (snapshot.data == false) {
                  return const Login();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const Profile();
              },
            ),
          );
        },
      );
}
