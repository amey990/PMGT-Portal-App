import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import 'login_screen.dart'; // for CustomTextField & GradientButton

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),

              // Top illustration
              Image.asset(
                'assets/Reset_pass.png',
                height: 220,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              // Code field
              const CustomTextField(
                label: 'Code',
                hint: 'Enter code',
              ),
              const SizedBox(height: 16),

              // New Password
              const CustomTextField(
                label: 'New Password',
                hint: 'Enter new password',
                isPassword: true,
              ),
              const SizedBox(height: 16),

              // Confirm Password
              const CustomTextField(
                label: 'Confirm Password',
                hint: 'Re-enter new password',
                isPassword: true,
              ),
              const SizedBox(height: 32),

              // Save button
              GradientButton(
                text: 'Save',
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
