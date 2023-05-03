import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginpage/VerifyEmailView_page.dart';
import 'package:loginpage/auth.dart';
import 'package:loginpage/create_update_note_view.dart';
import 'package:loginpage/helpers/loading/loading_screen.dart';
import 'package:loginpage/home_page.dart';
import 'package:loginpage/login_page.dart';
import 'package:loginpage/main_page.dart';
import 'package:loginpage/service/auth/bloc/auth_bloc.dart';
import 'package:loginpage/service/auth/bloc/auth_event.dart';
import 'package:loginpage/service/auth/bloc/auth_state.dart';
import 'package:loginpage/service/auth/firebase_auth_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const MainPage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
          context: context,
          text: state.loadingText ?? "Please wait a moment",
        );
      } else {
        LoadingScreen().hide();
      }
    }, builder: ((context, state) {
      if (state is AuthStateLoggedIn) {
        return const HomePage();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifiEmailView();
      } else if (state is AuthStateLoggedOut) {
        return const AuthPage();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    }));
  }
}
