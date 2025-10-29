
// import 'package:flutter/material.dart';
// import 'package:pmgt/ui/screens/Auth/reset_password_screen.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/gradient_button.dart';
// import '../../widgets/custom_text_field.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final _email = TextEditingController();

//   @override
//   void dispose() {
//     _email.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pad = responsivePadding(context);
//     final cs = Theme.of(context).colorScheme;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
//         title: const Text('Recover Password'),
//       ),
//       body: SafeArea(
//         child: AntiOverflowScroll(
//           child: MaxWidth(
//             child: Padding(
//               padding: pad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: context.w < 360 ? 32 : 60),

//                   Center(
//                     child: Image.asset(
//                       'assets/Forgot_pass.png',
//                       height: context.w < 360 ? 200 : 250,
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   SizedBox(height: context.w < 360 ? 24 : 40),

//                   // Email field (uses shared CustomTextField -> outlined by theme)
//                   CustomTextField(
//                     label: 'Email',
//                     controller: _email,
//                     keyboardType: TextInputType.emailAddress,
//                   ),

//                   const SizedBox(height: 24),

//                   GradientButton(
//                     text: 'Send Code',
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';
import '../../utils/responsive.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/custom_text_field.dart';
import 'reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();
  bool busy = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  bool _looksLikeEmail(String s) =>
      RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s);

  void _toast(String msg, {bool success = false}) {
    final cs = Theme.of(context).colorScheme;
    final bg = success
        ? const Color(0xFF2E7D32)
        : (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF5E2A2A)
            : const Color(0xFFFFE9E9));
    final fg = success ? Colors.white : cs.onSurface;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(color: fg)),
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _sendCode() async {
    if (busy) return;

    final email = _email.text.trim();
    if (email.isEmpty) {
      _toast('Please enter your email.');
      return;
    }
    if (!_looksLikeEmail(email)) {
      _toast('Please enter a valid email address.');
      return;
    }

    setState(() => busy = true);
    try {
      final auth = context.read<AuthService>();
      await auth.sendResetCode(email: email); // POST /api/auth/forgot

      if (!mounted) return;
      _toast('Code sent! Check your email.', success: true);

      // Go to reset screen with the email we used
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResetPasswordScreen(email: email)),
      );
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().toLowerCase();
      if (msg.contains('404') || msg.contains('not registered')) {
        _toast('User not registered.');
      } else {
        _toast('Could not send code. Please try again.');
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading:
            BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
        title: const Text('Recover Password'),
      ),
      body: SafeArea(
        child: AntiOverflowScroll(
          child: MaxWidth(
            child: Padding(
              padding: pad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: context.w < 360 ? 32 : 60),

                  Center(
                    child: Image.asset(
                      'assets/Forgot_pass.png',
                      height: context.w < 360 ? 200 : 250,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: context.w < 360 ? 24 : 40),

                  CustomTextField(
                    label: 'Email',
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 24),

                  GradientButton(
                    text: busy ? 'Sending…' : 'Send Code',
                    onPressed: _sendCode,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
