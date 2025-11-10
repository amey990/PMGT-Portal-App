// import 'package:flutter/material.dart';
// import 'package:pmgt/ui/screens/Auth/forgot_password_screen.dart'; // fixed path casing
// import 'package:pmgt/ui/screens/Auth/signup_screen.dart';
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/gradient_button.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _email = TextEditingController();
//   final _password = TextEditingController();

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
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
//           focusedBorder: b(AppTheme.accentColor, 1.4),
//           border: b(cs.outline),
//         );

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: AntiOverflowScroll(
//           child: MaxWidth(
//             child: Padding(
//               padding: pad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: context.w < 360 ? 20 : 30),

//                   Center(
//                     child: Image.asset(
//                       'assets/login_img.png',
//                       height: context.w < 360 ? 200 : 250,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Email
//                   _LabeledField(
//                     label: 'Email',
//                     controller: _email,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: dec('Email'),
//                   ),
//                   const SizedBox(height: 16),

//                   // Password with toggle
//                   _PasswordField(label: 'Password', controller: _password, decoration: dec('Password')),
//                   const SizedBox(height: 8),

//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
//                       },
//                       child: Text(
//                         'Forgot Password',
//                         style: TextStyle(color: AppTheme.accentColor, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   GradientButton(
//                     text: 'Log In',
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
//                     },
//                   ),

//                   const SizedBox(height: 24),

//                   Row(
//                     children: [
//                       Expanded(child: Divider(color: cs.outlineVariant)),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text('Or continue with', style: TextStyle(color: cs.onSurfaceVariant)),
//                       ),
//                       Expanded(child: Divider(color: cs.outlineVariant)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         // TODO: Handle Google Sign-In
//                       },
//                       child: Container(
//                         width: 55,
//                         height: 55,
//                         decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                         alignment: Alignment.center,
//                         child: Image.asset('assets/google_logo_new.png'),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   InkWell(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
//                     },
//                     child: const Center(child: Text("Temp Signup link")),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Simple labeled text field (now accepts decoration)
// class _LabeledField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final InputDecoration decoration;
//   const _LabeledField({
//     required this.label,
//     required this.controller,
//     required this.decoration,
//     this.keyboardType = TextInputType.text,
//   });

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
//           keyboardType: keyboardType,
//           style: TextStyle(color: cs.onSurface),
//           decoration: decoration,
//         ),
//       ],
//     );
//   }
// }

// /// Password field with visibility toggle that uses injected decoration
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



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/gradient_button.dart';
// import '../../screens/dashboard/dashboard_screen.dart';
// import '../../../services/auth_service.dart';
// import '../../../state/user_session.dart';
// import 'forgot_password_screen.dart';
// import 'signup_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   bool busy = false;

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }

//   Future<void> _doLogin() async {
//     final auth = context.read<AuthService>();
//     final session = context.read<UserSession>();

//     setState(() => busy = true);
//     try {
//       final resp = await auth.login(
//         email: _email.text.trim(),
//         password: _password.text,
//       );

//       final token = resp.token;
//       final user  = resp.user;

//       final uEmail = (user['email'] as String?) ?? _email.text.trim();
//       final uRole  = (user['role']  as String?) ?? '';

//       await session.setAuthenticated(
//         token: token,
//         email: uEmail,
//         role: uRole,
//       );

//       if (!mounted) return;
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => const DashboardScreen()),
//         (_) => false,
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     } finally {
//       if (mounted) setState(() => busy = false);
//     }
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
//           focusedBorder: b(AppTheme.accentColor, 1.4),
//           border: b(cs.outline),
//         );

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: AntiOverflowScroll(
//           child: MaxWidth(
//             child: Padding(
//               padding: pad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: context.w < 360 ? 20 : 30),

//                   Center(
//                     child: Image.asset(
//                       'assets/login_img.png',
//                       height: context.w < 360 ? 200 : 250,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   _LabeledField(
//                     label: 'Email',
//                     controller: _email,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: dec('Email'),
//                   ),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Password', controller: _password, decoration: dec('Password')),
//                   const SizedBox(height: 8),

//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
//                       },
//                       child: Text(
//                         'Forgot Password',
//                         style: TextStyle(color: AppTheme.accentColor, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   /// IMPORTANT: always pass a non-null callback (no more `VoidCallback?` error)
//                   GradientButton(
//                     text: busy ? 'Please wait…' : 'Log In',
//                     onPressed: () {
//                       if (busy) return;
//                       _doLogin();
//                     },
//                   ),

//                   const SizedBox(height: 24),

//                   Row(
//                     children: [
//                       Expanded(child: Divider(color: cs.outlineVariant)),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text('Or continue with', style: TextStyle(color: cs.onSurfaceVariant)),
//                       ),
//                       Expanded(child: Divider(color: cs.outlineVariant)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   Center(
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: 55,
//                         height: 55,
//                         decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                         alignment: Alignment.center,
//                         child: Image.asset('assets/google_logo_new.png'),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   InkWell(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
//                     },
//                     child: const Center(child: Text("Temp Signup link")),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Simple labeled text field (now accepts decoration)
// class _LabeledField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final InputDecoration decoration;
//   const _LabeledField({
//     required this.label,
//     required this.controller,
//     required this.decoration,
//     this.keyboardType = TextInputType.text,
//   });

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
//           keyboardType: keyboardType,
//           style: TextStyle(color: cs.onSurface),
//           decoration: decoration,
//         ),
//       ],
//     );
//   }
// }

// /// Password field with visibility toggle that uses injected decoration
// class _PasswordField extends StatefulWidget {
//   final String label;
//   final TextEditingController controller;
//   final InputDecoration decoration;
//   const _PasswordField({
//     required this.label,
//     required this.controller,
//     required this.decoration,
//   });

//   @override
//   State<_PasswordField> createState() => _PasswordFieldState(); // <-- FIXED
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



//p3//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/gradient_button.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../../services/auth_service.dart';
import '../../../state/user_session.dart';
import 'forgot_password_screen.dart';
// import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool busy = false;
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // ─────────────────── helpers ───────────────────
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

  bool _looksLikeEmail(String s) =>
      RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s);

  // ─────────────────── actions ───────────────────
  Future<void> _doLogin() async {
    if (busy) return;

    // 1) quick validations
    final email = _email.text.trim();
    final pwd = _password.text;

    if (email.isEmpty && pwd.isEmpty) {
      _toast('Please enter your email and password.');
      return;
    }
    if (email.isEmpty) {
      _toast('Please enter your email.');
      return;
    }
    if (!_looksLikeEmail(email)) {
      _toast('Please enter a valid email address.');
      return;
    }
    if (pwd.isEmpty) {
      _toast('Please enter your password.');
      return;
    }

    final auth = context.read<AuthService>();
    final session = context.read<UserSession>();

    setState(() => busy = true);
    try {
      final resp = await auth.login(email: email, password: pwd);

      final token = resp.token;
      final user  = resp.user;

      final uEmail = (user['email'] as String?) ?? email;
      final uRole  = (user['role']  as String?) ?? '';

      await session.setAuthenticated(token: token, email: uEmail, role: uRole);

      if (!mounted) return;
      _toast('Login successful', success: true);

      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().toLowerCase();
      if (msg.contains('401') ||
          msg.contains('invalid') ||
          msg.contains('unauthorized')) {
        _toast('Invalid login credentials.');
      } else {
        _toast('Unable to log in. Please try again.');
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
          focusedBorder: b(AppTheme.accentColor, 1.4),
          border: b(cs.outline),
        );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: AntiOverflowScroll(
          child: MaxWidth(
            child: Padding(
              padding: pad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: context.w < 360 ? 20 : 30),

                  Center(
                    child: Image.asset(
                      'assets/login_img.png',
                      height: context.w < 360 ? 200 : 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _LabeledField(
                    label: 'Email',
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: dec('Email'),
                  ),
                  const SizedBox(height: 16),

                  // Password (inline so we can toggle)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _password,
                        obscureText: _obscure,
                        style: TextStyle(color: cs.onSurface),
                        decoration: dec('Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off,
                                color: cs.onSurfaceVariant),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: AppTheme.accentColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  GradientButton(
                    text: busy ? 'Please wait…' : 'Log In',
                    onPressed: () {
                      if (busy) return;
                      _doLogin();
                    },
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(child: Divider(color: cs.outlineVariant)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Or continue with', style: TextStyle(color: cs.onSurfaceVariant)),
                      ),
                      Expanded(child: Divider(color: cs.outlineVariant)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Image.asset('assets/google_logo_new.png'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
                  //   },
                  //   child: const Center(child: Text("Temp Signup link")),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Simple labeled text field (now accepts decoration)
class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  const _LabeledField({
    required this.label,
    required this.controller,
    required this.decoration,
    this.keyboardType = TextInputType.text,
  });

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
          keyboardType: keyboardType,
          style: TextStyle(color: cs.onSurface),
          decoration: decoration,
        ),
      ],
    );
  }
}
