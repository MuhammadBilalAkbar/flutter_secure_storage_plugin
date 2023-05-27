import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'pages/login.dart';
import 'pages/profile.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({Key? key}) : super(key: key);

  @override
  CheckStatusState createState() => CheckStatusState();
}

class CheckStatusState extends State<CheckStatus> {
  final storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    final uid = await storage.read(key: 'uid');
    debugPrint('CheckStatus => uid: $uid');
    if (uid == null) {
      debugPrint('CheckStatus => UID returned false');
      return false;
    }
    debugPrint('CheckStatus => UID returned true');
    return true;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return const Login();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Profile();
        },
      );
}
