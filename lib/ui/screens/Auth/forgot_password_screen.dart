// import 'package:flutter/material.dart';
// import 'package:pmgt/ui/screens/Auth/reset_password_screen.dart';
// import '../../../core/theme.dart';
// import 'login_screen.dart'; // for CustomTextField & GradientButton

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//        appBar: AppBar(
//         backgroundColor: AppTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Colors.white),
//         title: const Text('Recover Password'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 60),

//               // Top illustration
//               Image.asset(
//                 'assets/Forgot_pass.png',
//                 height: 250,
//                 fit: BoxFit.contain,
//               ),

//               const SizedBox(height: 40),

//               // Email field
//               const CustomTextField(
//                 label: 'Email',
//                 hint: 'Enter your registered email',
//               ),

//               const SizedBox(height: 24),

//               // Send Code button
//               GradientButton(
//                 text: 'Send Code',
//                 onPressed: () {
//                    Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ResetPasswordScreen(),
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
// import 'package:pmgt/ui/screens/Auth/reset_password_screen.dart';
// import '../../../core/theme.dart';
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

//                   // Top illustration (size adapts to width)
//                   Center(
//                     child: Image.asset(
//                       'assets/Forgot_pass.png',
//                       height: context.w < 360 ? 200 : 250,
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   SizedBox(height: context.w < 360 ? 24 : 40),

//                   // Email field (uses shared CustomTextField)
//                   CustomTextField(
//                     label: 'Email',
//                     controller: _email,
//                     keyboardType: TextInputType.emailAddress,
//                   ),

//                   const SizedBox(height: 24),

//                   // Send Code button
//                   GradientButton(
//                     text: 'Send Code',
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const ResetPasswordScreen(),
//                         ),
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
import 'package:pmgt/ui/screens/Auth/reset_password_screen.dart';
import '../../utils/responsive.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
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
        leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
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

                  // Email field (uses shared CustomTextField -> outlined by theme)
                  CustomTextField(
                    label: 'Email',
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 24),

                  GradientButton(
                    text: 'Send Code',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
                      );
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
