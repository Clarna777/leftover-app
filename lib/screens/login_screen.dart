import 'package:flutter/material.dart';

import '../widgets/rounded_primary_button.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7E7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Leftover',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE9F0E6)),
                    ),
                    child: Column(
                      children: [
                        const TextField(
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 12),
                        const TextField(
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        const SizedBox(height: 18),
                        RoundedPrimaryButton(
                          label: 'Login',
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.routeName,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      RegisterScreen.routeName,
                    ),
                    child: const Text('No account? Register'),
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
