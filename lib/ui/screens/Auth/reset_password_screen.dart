// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/gradient_button.dart';
// import 'login_screen.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   const ResetPasswordScreen({super.key});

//   @override
//   State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final _code = TextEditingController();
//   final _newPass = TextEditingController();
//   final _confirmPass = TextEditingController();

//   @override
//   void dispose() {
//     _code.dispose();
//     _newPass.dispose();
//     _confirmPass.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pad = responsivePadding(context);
//     final cs = Theme.of(context).colorScheme;

//     OutlineInputBorder b(Color c, [double w = 1]) =>
//         OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

//     InputDecoration dec(String label) => InputDecoration(
//           hintText: label,
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           filled: true,
//           fillColor: cs.surfaceContainerHigh,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           enabledBorder: b(cs.outline),
//           disabledBorder: b(cs.outlineVariant),
//           focusedBorder: b(AppTheme.accentColor, 1.4),
//           border: b(cs.outline),
//         );

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
//         title: const Text('Reset Password'),
//       ),
//       body: SafeArea(
//         child: AntiOverflowScroll(
//           child: MaxWidth(
//             child: Padding(
//               padding: pad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: context.w < 360 ? 16 : 30),

//                   Center(
//                     child: Image.asset(
//                       'assets/Reset_pass.png',
//                       height: context.w < 360 ? 180 : 220,
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   _LabeledField(label: 'Code', controller: _code, decoration: dec('Code')),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'New Password', controller: _newPass, decoration: dec('New Password')),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Confirm Password', controller: _confirmPass, decoration: dec('Confirm Password')),
//                   const SizedBox(height: 24),

//                   GradientButton(
//                     text: 'Save',
//                     onPressed: () {
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
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

// class _LabeledField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final InputDecoration decoration;
//   const _LabeledField({required this.label, required this.controller, required this.decoration});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           style: TextStyle(color: cs.onSurface),
//           decoration: decoration,
//         ),
//       ],
//     );
//   }
// }

// class _PasswordField extends StatefulWidget {
//   final String label;
//   final TextEditingController controller;
//   final InputDecoration decoration;
//   const _PasswordField({required this.label, required this.controller, required this.decoration});

//   @override
//   State<_PasswordField> createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<_PasswordField> {
//   bool _obscure = true;

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         TextField(
//           controller: widget.controller,
//           obscureText: _obscure,
//           style: TextStyle(color: cs.onSurface),
//           decoration: widget.decoration.copyWith(
//             suffixIcon: IconButton(
//               icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: cs.onSurfaceVariant),
//               onPressed: () => setState(() => _obscure = !_obscure),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme.dart';
import '../../../services/auth_service.dart';
import '../../utils/responsive.dart';
import '../../widgets/gradient_button.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email; // ← we carry the email from Forgot step
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _code = TextEditingController();
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();
  bool busy = false;
  bool _hide1 = true;
  bool _hide2 = true;

  @override
  void dispose() {
    _code.dispose();
    _newPass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

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

  Future<void> _reset() async {
    if (busy) return;

    final code = _code.text.trim();
    final pass = _newPass.text;
    final conf = _confirmPass.text;

    // Validations
    if (code.isEmpty || pass.isEmpty || conf.isEmpty) {
      _toast('Please fill all the fields.');
      return;
    }
    if (pass.length < 6) {
      _toast('Password must be at least 6 characters.');
      return;
    }
    if (pass != conf) {
      _toast('Passwords do not match.');
      return;
    }

    setState(() => busy = true);
    try {
      final auth = context.read<AuthService>();
      await auth.resetPassword(
        email: widget.email,
        otpCode: code,
        newPassword: pass,
      ); // POST /api/auth/reset

      if (!mounted) return;
      _toast('Password reset successful! Please log in.', success: true);

      await Future.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().toLowerCase();
      if (msg.contains('invalid') || msg.contains('otp')) {
        _toast('Invalid code. Please try again.');
      } else {
        _toast('Could not reset password. Please try again.');
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final cs = Theme.of(context).colorScheme;

    OutlineInputBorder b(Color c, [double w = 1]) =>
        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

    InputDecoration dec(String label) => InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          filled: true,
          fillColor: cs.surfaceContainerHigh,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: b(cs.outline),
          disabledBorder: b(cs.outlineVariant),
          focusedBorder: b(AppTheme.accentColor, 1.4),
          border: b(cs.outline),
        );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading:
            BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: AntiOverflowScroll(
          child: MaxWidth(
            child: Padding(
              padding: pad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: context.w < 360 ? 16 : 30),

                  Center(
                    child: Image.asset(
                      'assets/Reset_pass.png',
                      height: context.w < 360 ? 180 : 220,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Email (read-only to remind which inbox)
                  Text(
                    'Resetting for: ${widget.email}',
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                  ),
                  const SizedBox(height: 8),

                  _LabeledField(label: 'Code', controller: _code, decoration: dec('Enter code from email')),
                  const SizedBox(height: 16),

                  // New password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Password',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _newPass,
                        obscureText: _hide1,
                        style: TextStyle(color: cs.onSurface),
                        decoration: dec('New Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_hide1 ? Icons.visibility : Icons.visibility_off,
                                color: cs.onSurfaceVariant),
                            onPressed: () => setState(() => _hide1 = !_hide1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Confirm password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirm Password',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _confirmPass,
                        obscureText: _hide2,
                        style: TextStyle(color: cs.onSurface),
                        decoration: dec('Confirm Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_hide2 ? Icons.visibility : Icons.visibility_off,
                                color: cs.onSurfaceVariant),
                            onPressed: () => setState(() => _hide2 = !_hide2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  GradientButton(
                    text: busy ? 'Saving…' : 'Save',
                    onPressed: _reset,
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

class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final InputDecoration decoration;
  const _LabeledField({required this.label, required this.controller, required this.decoration});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(color: cs.onSurface),
          decoration: decoration,
        ),
      ],
    );
  }
}
