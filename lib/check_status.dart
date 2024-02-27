import 'package:flutter/material.dart';
import 'package:flutter_secure_storage_plugin/utils/user_secure_storage.dart';

import '../pages/sign_in_page.dart';
import '../pages/profile_page.dart';

class CheckStatus extends StatelessWidget {
  const CheckStatus({Key? key}) : super(key: key);

  Future<bool> checkLoginStatus() async {
    final uid = await UserSecureStorage.read('uid');
    debugPrint('uid: $uid');
    if (uid == null) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return const SignInPage();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const ProfilePage();
        },
      );
}
