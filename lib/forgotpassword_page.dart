import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPassWordPage extends StatefulWidget {
  @override
  State<ForgotPassWordPage> createState() => _ForgotPassWordPageState();
}

class _ForgotPassWordPageState extends State<ForgotPassWordPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset link sent! Check your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text(
          "Resset PassWord",
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Receive an email to\nreset your password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(130),
                    ),
                    child: TextFormField(
                      controller: emailcontroller,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Your Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.deepPurple,
                        ),
                        fillColor: Colors.deepPurple[250],
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? "Enter a valid email"
                              : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: passwordReset,
                  child: Text("Reset Password"),
                  color: Colors.deepPurple[200],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
