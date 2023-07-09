import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const splashDuration = Duration(seconds: 2);

    Future<void> navigateToHome() async {
      await Future.delayed(splashDuration);
      if(context.mounted) Navigator.pushReplacementNamed(context, '/movies');
    }
    
    navigateToHome();

    return const Scaffold(
      body: Center(
        child: Text("Seja bem-vindo !"),
      ),
    );
  }
}
