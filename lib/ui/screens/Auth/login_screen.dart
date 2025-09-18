// import 'package:flutter/material.dart';
// import 'package:pmgt/ui/screens/AUth/signup_screen.dart';
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import '../../../core/theme.dart';
// import 'forgot_password_screen.dart';

// /// A reusable gradient button with larger white text
// class GradientButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   const GradientButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: double.infinity,
//         height: 55,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFFF8DF6C),
//               Color(0xFFEDD545),
//               Color(0xFFE4C303),
//               Color(0xFFCDB004),
//               Color(0xFFC8AC08),
//             ],
//             stops: [0.0, 0.24, 0.47, 0.67, 1.0],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,      // ← white text
//             fontSize: 18,             // ← larger font
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// A text field that can toggle password visibility
// class CustomTextField extends StatefulWidget {
//   final String label;
//   final String hint;
//   final bool isPassword;

//   const CustomTextField({
//     super.key,
//     required this.label,
//     required this.hint,
//     this.isPassword = false,
//   });

//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   late bool _obscure;

//   @override
//   void initState() {
//     super.initState();
//     _obscure = widget.isPassword;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: const TextStyle(
//             color: Colors.white70,
//             fontSize: 14,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           obscureText: widget.isPassword && _obscure,
//           style: const TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: widget.hint,
//             hintStyle: const TextStyle(color: Colors.white54),
//             filled: true,
//             fillColor: Colors.white12,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide.none,
//             ),
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//                     icon: Icon(
//                       _obscure ? Icons.visibility : Icons.visibility_off,
//                       color: Colors.white54,
//                     ),
//                     onPressed: () =>
//                         setState(() => _obscure = !_obscure),
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// The Login screen with scroll, dividers, and navigation
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 30),
//               Image.asset(
//                 'assets/login_img.png',
//                 height: 250,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 16),

//               // Email
//               const CustomTextField(
//                 label: 'Email',
//                 hint: 'Enter your email',
//               ),
//               const SizedBox(height: 16),

//               // Password with toggle
//               const CustomTextField(
//                 label: 'Password',
//                 hint: 'Enter your password',
//                 isPassword: true,
//               ),
//               const SizedBox(height: 8),

//               // Forgot Password navigation
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const ForgotPasswordScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Forgot Password',
//                     style: TextStyle(
//                       color: AppTheme.accentColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Log In button
//               GradientButton(
//                 text: 'Log In',
//                 onPressed: () {
                  
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => DashboardScreen(),
//                       ),
//                     );
//                 },
//               ),
//               const SizedBox(height: 24),

//               // Divider + “Or continue with” + Divider
//               Row(
//                 children: const [
//                   Expanded(child: Divider(color: Colors.white24)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8),
//                     child: Text(
//                       'Or continue with',
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                   ),
//                   Expanded(child: Divider(color: Colors.white24)),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Google Sign-In
//               GestureDetector(
//                 onTap: () {
//                   // TODO: Handle Google Sign-In
//                 },
//                 child: Container(
//                   width: 55,
//                   height: 55,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
                  
//                     child: Image.asset('assets/google_logo_new.png'),
                 
//                 ),
//               ),

//               const SizedBox(height: 30),

//               InkWell(
//                 onTap: ()
//                 {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => SignupScreen(),
//                       ),
//                     );
//                 },
//                 child: Center(child: Text("Temp Signup link")))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:pmgt/ui/screens/AUth/forgot_password_screen.dart';
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
//     _email..dispose();
//     _password..dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pad = responsivePadding(context);
//     final cs = Theme.of(context).colorScheme;

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
//                   ),
//                   const SizedBox(height: 16),

//                   // Password with toggle
//                   _PasswordField(
//                     label: 'Password',
//                     controller: _password,
//                   ),
//                   const SizedBox(height: 8),

//                   // Forgot Password
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                                       onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
//                     );
//                   },
//                                         child: Text(
//                         'Forgot Password',
//                         style: TextStyle(
//                           color: AppTheme.accentColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Log In button
//                   GradientButton(
//                     text: 'Log In',
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const DashboardScreen()),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 24),

//                   // Divider “Or continue with”
//                   Row(
//                     children: [
//                       Expanded(child: Divider(color: cs.outlineVariant)),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(
//                           'Or continue with',
//                           style: TextStyle(color: cs.onSurfaceVariant),
//                         ),
//                       ),
//                       Expanded(child: Divider(color: cs.outlineVariant)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Google Sign-In
//                   Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         // TODO: Handle Google Sign-In
//                       },
//                       child: Container(
//                         width: 55,
//                         height: 55,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).brightness == Brightness.dark
//                               ? Colors.white
//                               : Colors.white, // remains white for brand
//                           shape: BoxShape.circle,
//                         ),
//                         alignment: Alignment.center,
//                         child: Image.asset('assets/google_logo_new.png'),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const SignupScreen()),
//                       );
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

// /// Simple labeled text field that uses theme colors (email/username)
// class _LabeledField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   const _LabeledField({
//     required this.label,
//     required this.controller,
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

// /// Password field with visibility toggle that adapts to theme
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
import 'package:pmgt/ui/screens/Auth/forgot_password_screen.dart'; // fixed path casing
import 'package:pmgt/ui/screens/Auth/signup_screen.dart';
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
          focusedBorder: _b(AppTheme.accentColor, 1.4),
          border: _b(cs.outline),
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

                  // Email
                  _LabeledField(
                    label: 'Email',
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _dec('Email'),
                  ),
                  const SizedBox(height: 16),

                  // Password with toggle
                  _PasswordField(label: 'Password', controller: _password, decoration: _dec('Password')),
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
                    text: 'Log In',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
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
                      onTap: () {
                        // TODO: Handle Google Sign-In
                      },
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

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
                    },
                    child: const Center(child: Text("Temp Signup link")),
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

/// Password field with visibility toggle that uses injected decoration
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
