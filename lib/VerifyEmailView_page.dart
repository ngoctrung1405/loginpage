import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/home_page.dart';

class VerifiEmailView extends StatefulWidget {
  @override
  State<VerifiEmailView> createState() => _VerifiEmailViewState();
}

class _VerifiEmailViewState extends State<VerifiEmailView> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      FirebaseAuth.instance.currentUser!.emailVerified;
      if (isEmailVerified) timer?.cancel();
    });
  }

  Future sendVerificationEmail() async {
    final User = FirebaseAuth.instance.currentUser!;
    await User.sendEmailVerification();
    setState(() => canResendEmail = false);
    await Future.delayed(Duration(seconds: 5));
    setState(() => canResendEmail = true);
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          appBar: AppBar(
            title: Text("Verify Email"),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A verification email has been sent to your email",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                  child: Text("Resent Email"),
                  color: Colors.deepPurple[200],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: Text("CanCel")),
              ],
            ),
          ),
        );
}
