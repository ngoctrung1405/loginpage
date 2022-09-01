import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/main.dart';
import 'package:loginpage/utilities/show-error-dialog.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({super.key, required this.showLoginPage});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidepassword = true;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
  }

  Future signUp() async {
    try {
      if (passwordconfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        await showErrorDialog(
          context,
          "Weak password",
        );
      } else if (e.code == "email-already-in-use") {
        await showErrorDialog(
          context,
          "Email already in use",
        );
      } else {
        await showErrorDialog(
          context,
          "Error ${e.code}",
        );
      }
    } catch (e) {
      await showErrorDialog(
        context,
        e.toString(),
      );
    }
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }

  bool passwordconfirmed() {
    if (passwordcontroller.text.trim() ==
        confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

    var mybutton = ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 155)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.deepPurple))));
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: globalFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.android,
                    size: 100,
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Text("Hello There",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Register below with your details!",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: emailcontroller,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Email",
                        fillColor: Colors.grey[200],
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.deepPurple,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? "Enter a valid email"
                              : null,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: passwordcontroller,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "PassWord",
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidepassword = !hidepassword;
                              });
                            },
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            icon: Icon(hidepassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter min.6 characters'
                          : null,
                      obscureText: hidepassword,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: confirmpasswordcontroller,
                      //enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "ConfirmPassWord",
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidepassword = !hidepassword;
                              });
                            },
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            icon: Icon(hidepassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter min.6 characters'
                          : null,
                      obscureText: hidepassword,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: signUp,
                    icon: Icon(Icons.lock_open),
                    label: Text("Sign up"),
                    style: mybutton,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I am a remember!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          "Login now",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
