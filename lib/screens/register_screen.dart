import 'package:flutter/material.dart';
import '../widgets/rounded_primary_button.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 14),
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
              label: 'Create account',
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
