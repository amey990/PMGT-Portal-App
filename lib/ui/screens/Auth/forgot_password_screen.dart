// import 'package:flutter/material.dart';
// import '../../core/theme.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//       appBar: AppBar(
//         title: const Text('Forgot Password'),
//       ),
//       body: const Center(
//         child: Text(
//           'Forgot Password Page',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:pmgt/ui/screens/Auth/reset_password_screen.dart';
import '../../../core/theme.dart';
import 'login_screen.dart'; // for CustomTextField & GradientButton

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
       appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text('Recover Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),

              // Top illustration
              Image.asset(
                'assets/Forgot_pass.png',
                height: 250,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              // Email field
              const CustomTextField(
                label: 'Email',
                hint: 'Enter your registered email',
              ),

              const SizedBox(height: 24),

              // Send Code button
              GradientButton(
                text: 'Send Code',
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResetPasswordScreen(),
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
