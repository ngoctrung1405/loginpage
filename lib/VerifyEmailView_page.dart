import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener, ReadContext;
import 'package:loginpage/service/auth/bloc/auth_bloc.dart';
import 'package:loginpage/service/auth/bloc/auth_event.dart';

class VerifiEmailView extends StatefulWidget {
  const VerifiEmailView({super.key});

  @override
  State<VerifiEmailView> createState() => _VerifiEmailViewState();
}

class _VerifiEmailViewState extends State<VerifiEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Column(
        children: [
          const Text(
              "We're sent you an email verification. Please open it to verify your account."),
          const Text(
              "If you haven't received a verification email yet, press the button below"),
          TextButton(
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmaiVerification());
              },
              child: const Text("Send email verification")),
          TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Restart")),
        ],
      ),
    );
  }
}
