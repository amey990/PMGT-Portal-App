// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import 'login_screen.dart'; // for CustomTextField & GradientButton

// class ResetPasswordScreen extends StatelessWidget {
//   const ResetPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Colors.white),
//         title: const Text('Reset Password'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 30),

//               // Top illustration
//               Image.asset(
//                 'assets/Reset_pass.png',
//                 height: 220,
//                 fit: BoxFit.contain,
//               ),

//               const SizedBox(height: 20),

//               // Code field
//               const CustomTextField(
//                 label: 'Code',
//                 hint: 'Enter code',
//               ),
//               const SizedBox(height: 16),

//               // New Password
//               const CustomTextField(
//                 label: 'New Password',
//                 hint: 'Enter new password',
//                 isPassword: true,
//               ),
//               const SizedBox(height: 16),

//               // Confirm Password
//               const CustomTextField(
//                 label: 'Confirm Password',
//                 hint: 'Re-enter new password',
//                 isPassword: true,
//               ),
//               const SizedBox(height: 32),

//               // Save button
//               GradientButton(
//                 text: 'Save',
//                 onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => LoginScreen(),
//                       ),
//                     );
//                 },
//               ),

//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


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

//                   _LabeledField(label: 'Code', controller: _code),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'New Password', controller: _newPass),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Confirm Password', controller: _confirmPass),
//                   const SizedBox(height: 24),

//                   GradientButton(
//                     text: 'Save',
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginScreen()),
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

// /// Reuse small helpers from login
// class _LabeledField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _LabeledField({required this.label, required this.controller});

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
//           decoration: InputDecoration(
//             hintText: label,
//             hintStyle: TextStyle(color: cs.onSurfaceVariant),
//             filled: true,
//             fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _PasswordField extends StatefulWidget {
//   final String label;
//   final TextEditingController controller;
//   const _PasswordField({required this.label, required this.controller});

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
//           decoration: InputDecoration(
//             hintText: widget.label,
//             hintStyle: TextStyle(color: cs.onSurfaceVariant),
//             filled: true,
//             fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
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
import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/gradient_button.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _code = TextEditingController();
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    _newPass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final cs = Theme.of(context).colorScheme;

    OutlineInputBorder _b(Color c, [double w = 1]) =>
        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

    InputDecoration _dec(String label) => InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          filled: true,
          fillColor: cs.surfaceContainerHigh,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: _b(cs.outline),
          disabledBorder: _b(cs.outlineVariant),
          focusedBorder: _b(AppTheme.accentColor, 1.4),
          border: _b(cs.outline),
        );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
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

                  _LabeledField(label: 'Code', controller: _code, decoration: _dec('Code')),
                  const SizedBox(height: 16),

                  _PasswordField(label: 'New Password', controller: _newPass, decoration: _dec('New Password')),
                  const SizedBox(height: 16),

                  _PasswordField(label: 'Confirm Password', controller: _confirmPass, decoration: _dec('Confirm Password')),
                  const SizedBox(height: 24),

                  GradientButton(
                    text: 'Save',
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
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

class _PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final InputDecoration decoration;
  const _PasswordField({required this.label, required this.controller, required this.decoration});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: _obscure,
          style: TextStyle(color: cs.onSurface),
          decoration: widget.decoration.copyWith(
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: cs.onSurfaceVariant),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
        ),
      ],
    );
  }
}
