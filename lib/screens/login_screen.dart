import 'package:flutter/material.dart';
import '../widgets/rounded_primary_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 14),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            RoundedPrimaryButton(
              label: 'Continue',
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                HomeScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
