## 1. Research: Flutter Secure Storage Package 

- Keywords: 
  - flutter secure storage
  - how to use flutter secure storage
  - flutter secure storage vs shared preferences
  - flutter secure storage alternative
  - flutter secure storage example
  - flutter secure storage vs hive
  - hive flutter
  - shared preferences flutter
  - local storage flutter
  - flutter localstorage example
  - flutter storage
  - flutter secure storage ios
  - flutter secure storage token
  - save token in sharedpreferences flutter
  - flutter secure storage tutorial
  - how to store login credentials
  - how to use shared preferences to keep users logged in flutter
  - how to save user sign in details in flutter
  - flutter autofill password
  - flutter save username and password
  - flutter sharedpreferences login example
  - flutter login autofill
  - shared preferences to keep user logged in android
  - login session in flutter
- Video Title: Flutter secure storage - login autofill, save user credentials (username and password)

## 2. Research: Competitors

**Flutter Videos/Articles**

- 22K: https://www.youtube.com/watch?v=Oqhrxk_f1RE
- 7.1K: https://www.youtube.com/watch?v=5M8EoLp4gJY
- 6.7K: https://www.youtube.com/watch?v=yP1Hq3x3WSM
- 6.6k: https://www.youtube.com/watch?v=tiLRXJX-DMY
- 1.1K: https://www.youtube.com/watch?v=jR81XSdNsW4
- 173: https://www.youtube.com/watch?v=ARsyjJkjSQU
- https://blog.logrocket.com/securing-local-storage-flutter/
- https://medium.com/@omer28gunaydin/flutter-secure-storage-f772186ac8d3
- https://morioh.com/p/da5a2c4aa2b5

**Android/Swift/React Videos**

- 11K: https://www.youtube.com/watch?v=ZVB3_ui6938
- 1.8K: https://www.youtube.com/watch?v=_fDjhdarct4
- 2.4K: https://www.youtube.com/watch?v=E_ETHwGvZW4
- 21K: https://www.youtube.com/watch?v=kEZEahTzuck
- 3.8K: https://www.youtube.com/watch?v=mAxBRkJaxLg
- 568: https://www.youtube.com/watch?v=LS7yFesLAYo
- 8.4K: https://www.youtube.com/watch?v=ndPXrcqDIZg
- 11K: https://www.youtube.com/watch?v=XivMMLBqH9E

**Great Features** 
- Flutter Secure Storage provides API to store data in secure storage. Keychain is used in iOS, KeyStore based solution is used in Android.
- If the platform is Android, then flutter_secure_storage stores data in encryptedSharedPreference, which are shared preferences that encrypt keys and values. It handles AES encryption to generate a secret key encrypted with RSA and stored in KeyStore.
  For the iOS platform, flutter_secure_storage uses the KeyChain which is an iOS-specific secure storage used to store and access cryptographic keys only in your app.
  In the case of the web, flutter_secure_storage uses the Web Cryptography (Web Crypto) API.

**Problems from Videos** 
- Question: I use flutter secure storage in flutter web, token was save in local storage browser but when I changed token in local storage browser ,token changed. Why my account can not log out when token was change?
  Answer: you need to write some logic for your requirement to be fulfilled. you have to logout on token change and make sure remove all user data from local while logout
- Question: Any reason you put the key in a variable?  Usually when you access an array you just write the key each time and storing it as a variable doesn't help much?  Just curious of the reason as it doesn't really matter if it is personal preference or something.
  Answer: Maybe because its using the same key in different places and if you want to change it you would need to change it in all different places
- Question: Hi, can i use tgist storage to store and encrypt pdfs or midi files?
  Answer:  Hey go with hive database. It provides a feature for securing files🚀
- Question: We can also use the authStateChange if the current user is logged in or not right?
  Answer: Yeah

**Problems from Flutter Stackoverflow**

- https://stackoverflow.com/questions/70014273/flutter-secure-storage-issues-unable-to-read-or-write-keys-and-values
- https://stackoverflow.com/questions/74849709/flutter-secure-storage-data-is-wiped-out-by-third-party-apps-like-mobile-optimiz
- https://stackoverflow.com/questions/75297942/flutter-secure-storage-in-my-application-reads-empty-value-when-exited-and-opene
- https://stackoverflow.com/questions/60840704/what-is-flutter-secure-storage-exactly-and-how-it-works
- https://stackoverflow.com/questions/74133927/i-cannot-keep-user-logged-in-while-using-flutter-secure-storage-dependency-in-fl

## 3. Video Structure

**Main Points / Purpose Of Lesson**

1. It uses AES (Advanced Encryption Standard) to storing data securely and encrypted. It read, write, and delete data from secure storage.
2. Main points of this video lesson
    - First is using firebase auto login
    - Second is flutter_secure_storage official example on github.
3. It is the best plugin to save data securely. We can use it to save the login credentials of a user to prevent from repeatedly login.

**The Structured Main Content**
1. Run `dart pub add flutter_secure_storage` to add this package to your project pubspec.yaml file.
2. Main Points
    - Configure Android version in `[project]/android/app/build.gradle` set `minSdkVersion` to >= 18.
    - You can configure web, linux, windows and MacOS by visiting (pub.dev/packages/flutter_secure_storage)[https://pub.dev/packages/flutter_secure_storage]
    - For login purpose, I use firebase. So run `dart pub add firebase_core` and `dart pub add firebase_auth` in terminal to add these dependencies in `pubspec.yaml` file.
3. For auto login using firebase, first configure and integrate your project with firebase and then make four screens login, signup, profile after login and forgot_password.
    - In `main.dart`, `login.dart`, `profile.dart`, and `secure_storage_official.dart`, initialize storage.
    ```dart
      final _storage = const FlutterSecureStorage();
    ```
    - `home` property of `MaterialApp` contains `FutureBuilder(...)` for auto login using firebase. For `SecureStorageOfficial()` example, it is also commented as `home` property in `main.dart` file.
    ```dart 
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
    ```
   `Future` property of `FutureBuilder` returns a boolean method `checkLoginStatus()` to check the user id `_storage.read(key: 'uid')` of a user for auto login purpose.
    ```dart  
   Future<bool> checkLoginStatus() async {
    final value = await _storage.read(key: 'uid');
    if (value == null) {
      return false;
       }
    return true;
    }
   ```
    - `singup.dart` uses `registration()` method to register a new user.
    ```dart  
   registration() async {
    if (password == confirmPassword) {
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        debugPrint(userCredential.toString());
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Registered Successfully. Please Login..',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('Password Provided is too Weak');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Password Provided is too Weak',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          debugPrint('Account Already exists');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Account Already exists',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    } else {
      debugPrint('Password and Confirm Password doesn\'t match');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Password and Confirm Password doesn\'t match',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
   }
    ```
    It also uses `TextFormField` (for email, password, confirm password) and `Form` widgets to get email and password of a user. Then it gets user to the login screen.
    - In `login.dart`, `userLogin()` contains `storage.write(key: "uid", value: userCredential.user?.uid)` to store the user id for auto login next time the user opens the app.
    ```dart
    userLogin() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint(userCredential.user?.uid);
      await _storage.write(key: 'uid', value: userCredential.user?.uid);
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
   ```
   It also uses `TextFormField` and `Form` widgets to accept the user email and password to login and save the credentials.
    - `forgot_password.dart` uses `FirebaseAuth.instance.sendPasswordResetEmail(email: email)` to reset password of a user by accepting his email address.
    ```dart
    Future<bool> checkLoginStatus() async {
    String? value = await _storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
    }
    ```
   - `profile.dart` contains user id, email and date created of a user.
5. `secure_storage_official.dart` covers all properties of Flutter Secure Storage Plugin like read, write, delete, read all, and delete all.