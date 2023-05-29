# flutter_secure_storage_plugin

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

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
- Video Title: Flutter secure storage - login autofill, save user credentials (username and
  password)

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

- Flutter Secure Storage provides API to store data in secure storage. Keychain is used in iOS,
  KeyStore based solution is used in Android.
- If the platform is Android, then flutter_secure_storage stores data in encryptedSharedPreference,
  which are shared preferences that encrypt keys and values. It handles AES encryption to generate a
  secret key encrypted with RSA and stored in KeyStore.
  For the iOS platform, flutter_secure_storage uses the KeyChain which is an iOS-specific secure
  storage used to store and access cryptographic keys only in your app.
  In the case of the web, flutter_secure_storage uses the Web Cryptography (Web Crypto) API.

**Problems from Videos**

- Question: I use flutter secure storage in flutter web, token was save in local storage browser but
  when I changed token in local storage browser ,token changed. Why my account can not log out when
  token was change?
  Answer: you need to write some logic for your requirement to be fulfilled. you have to logout on
  token change and make sure remove all user data from local while logout
- Question: Any reason you put the key in a variable? Usually when you access an array you just
  write the key each time and storing it as a variable doesn't help much? Just curious of the reason
  as it doesn't really matter if it is personal preference or something.
  Answer: Maybe because its using the same key in different places and if you want to change it you
  would need to change it in all different places
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

1. It uses AES (Advanced Encryption Standard) to storing data securely and encrypted. It read,
   write, and delete data from secure storage.
2. Main points of this video lesson
    - First is using firebase auto login
    - Second is flutter_secure_storage official example on github.
3. It is the best plugin to save data securely. We can use it to save the login credentials of a
   user to prevent from repeatedly login.

**The Structured Main Content**

1. Run `dart pub add flutter_secure_storage` to add this package to your project pubspec.yaml file.
2. Main Points
    - Configure Android version in `[project]/android/app/build.gradle` set `minSdkVersion` to >=
        18.
    - You can configure web, linux, windows and MacOS by visiting (
      pub.dev/packages/flutter_secure_storage)[https://pub.dev/packages/flutter_secure_storage]
    - For login purpose, I use firebase. So run `dart pub add firebase_core`
      and `dart pub add firebase_auth` in terminal to add these dependencies in `pubspec.yaml` file.
    - Always dispose `TextFields` or `TextFormFields` in every project.
3. For auto login using firebase, first configure and integrate your project with firebase and then
   make four screens login, signup, profile, and forgot_password. login screen has remember me check
   mark button for auto login purpose or to autofill email and password.

   In `login.dart`, `profile.dart`, and `check_status.dart`, initialize flutter secure storage.
    ```dart
      final storage = const FlutterSecureStorage();
    ```
4. In `main.dart`, MyApp returns FutureBuilder. `future` property of FutureBuilder accepts
   firebase initialization using `final initialization = Firebase.initializeApp();`.

   And `builder` property shows CircularProgress indicator if app is waiting for internet
   connection otherwise it return `MaterialApp`. MaterialApp has some theming properties of app
   and its `home` argument is calling `CheckStatus` widget from `check_status.dart` file.

    ```dart 
      FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            title: 'Flutter Firebase EMail Password Auth',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(fontSize: 16),
                titleMedium: TextStyle(fontSize: 24),
              ),
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            home: const CheckStatus(),
          );
        },
      );
    ```

5. `check_status.dart` contains `FutureBuilder` like in `main.dart`.

`Future` property of `FutureBuilder` returns a boolean method `checkLoginStatus()` to check the
user id `storage.read(key: 'uid')` of a user for auto login purpose.

 ```dart
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
```

If `future` of `check_status.dart` returns false . It means there is no uid stored in storage of
phone using flutter_secure_storage. Ultimately it will go to `Login` screen in `login.dart` file.

If `future` return true, it means uid is stored in phone storage and hence user will be logged in
automatically.

6. In `singup.dart`, initialize the following:

```dart

final formKey = GlobalKey<FormState>();
var email = '';
var password = '';
var confirmPassword = '';
final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();
```

It uses `registration()` method to register a new user.

 ```dart
 registerNewUser() async {
  if (password == confirmPassword) {
    try {
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      debugPrint('UserCredentials: $userCredentials');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Registered Successfully. Please Login...',
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

Code for SignUp button is here:

```dart 
               ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text;
                          password = passwordController.text;
                          confirmPassword = confirmPasswordController.text;
                        });
                        registerNewUser();
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
```

It uses `TextFormField` (for email, password, confirm password) and `Form` widgets to get
email, password and confirm password from user.

7. In `login.dart`, initialize the following:

```dart

final formKey = GlobalKey<FormState>();
String userEmail = '';
String userPassword = '';
final emailController = TextEditingController(text: '');
final passwordController = TextEditingController(text: '');

final storage = const FlutterSecureStorage();

bool rememberMe = false;
```

Remember me button of this screen saves the uid, email, and password of a user using
flutter_secure_storage.

After successful login, if user logout from profile screen then uid of that user is deleted using
flutter_secure_storage but email and password are kept to autofill the email and password fields
when user return to the login screen or whenever he opens the login screen.

If again, user checks the remember me button, then uid will be saved using package and will not be
deleted until user logout.

`loginUser()` and `getUserDetail()` methods with initState are blow.

- `loginUser()` method logins in the user in firebase and app using try-catch block to catch errors.

  By default, rememberMe is false. If it is true then uid, email, and password of user are saved
  using `storage.write` of flutter_secure_storage.

- `getUserDetail()` is being called in initState() method and checks if there is email and password
  saved in storage of phone using flutter_secure_storage. If they are saved then autofill the
  TextFormFields of email and password in login screen when it opens.

```dart
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
  final email = await storage.read(key: 'email');
  final password = await storage.read(key: 'password');
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
```

It uses `TextFormField` and `Form` widgets to accept the user email and password to validate and
login user.

8. `profile.dart` contains user id, email and date created of a user.

9. `forgot_password.dart` uses `FirebaseAuth.instance.sendPasswordResetEmail(email: email)` to
   reset password of a user by accepting his email address and sending link of reset password to
   user's registered email address.