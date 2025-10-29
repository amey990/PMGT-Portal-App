// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/gradient_button.dart';
// import 'login_screen.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   String? _selectedRole;
//   final List<String> _roles = const ['Admin', 'Project Manager', 'NOC', 'SCM'];

//   final _username = TextEditingController();
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   final _confirm = TextEditingController();

//   @override
//   void dispose() {
//     _username.dispose();
//     _email.dispose();
//     _password.dispose();
//     _confirm.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pad = responsivePadding(context);
//     final cs = Theme.of(context).colorScheme;
//     final viewInsets = MediaQuery.of(context).viewInsets.bottom;
//     final safeBottom = MediaQuery.of(context).padding.bottom;
//     final bottomGap = (viewInsets > 0 ? viewInsets : safeBottom);

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
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
//         title: const Text(' Add User'),
//       ),
//       body: SafeArea(
//         child: AntiOverflowScroll(
//           child: MaxWidth(
//             child: Padding(
//               padding: pad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 10),

//                   Center(
//                     child: Image.asset(
//                       'assets/Signup_img.png',
//                       height: context.w < 360 ? 180 : 230,
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Username & Role
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       final isNarrow = constraints.maxWidth < 380;
//                       const spacing = 16.0;

//                       final usernameField = _LabeledField(
//                         label: 'Username',
//                         controller: _username,
//                         decoration: dec('Username'),
//                       );

//                       final roleDropdown = _RoleDropdown(
//                         roles: _roles,
//                         value: _selectedRole,
//                         onChanged: (v) => setState(() => _selectedRole = v),
//                       );

//                       if (isNarrow) {
//                         return Column(
//                           children: [
//                             usernameField,
//                             SizedBox(height: spacing),
//                             roleDropdown,
//                           ],
//                         );
//                       }
//                       return Row(
//                         children: [
//                           Expanded(child: usernameField),
//                           SizedBox(width: spacing),
//                           Expanded(child: roleDropdown),
//                         ],
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 16),

//                   _LabeledField(label: 'Email', controller: _email, keyboardType: TextInputType.emailAddress, decoration: dec('Email')),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Password', controller: _password, decoration: dec('Password')),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Confirm Password', controller: _confirm, decoration: dec('Confirm Password')),
//                   const SizedBox(height: 24),

//                   GradientButton(
//                     text: 'Register',
//                     onPressed: () {
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
//                     },
//                   ),

//                   SizedBox(height: bottomGap + 16),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _RoleDropdown extends StatelessWidget {
//   final List<String> roles;
//   final String? value;
//   final ValueChanged<String?> onChanged;
//   const _RoleDropdown({required this.roles, required this.value, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     OutlineInputBorder b(Color c, [double w = 1]) =>
//         OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Role', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: value, // <-- changed from initialValue
//           isExpanded: true,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: cs.surfaceContainerHigh,
//             enabledBorder: b(cs.outline),
//             focusedBorder: b(AppTheme.accentColor, 1.4),
//             border: b(cs.outline),
//             hintText: 'Select Role',
//             hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           ),
//           iconEnabledColor: cs.onSurfaceVariant,
//           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//           items: roles
//               .map((role) => DropdownMenuItem(
//                     value: role,
//                     child: Text(role, style: TextStyle(color: cs.onSurface)),
//                   ))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }


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

//p2 complete functional //
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/gradient_button.dart';
// import '../../../services/auth_service.dart';
// import 'login_screen.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   String? _selectedRole;
//   final List<String> _roles = const ['Admin', 'Project Manager', 'NOC', 'SCM'];

//   final _username = TextEditingController();
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   final _confirm = TextEditingController();

//   bool busy = false;

//   @override
//   void dispose() {
//     _username.dispose();
//     _email.dispose();
//     _password.dispose();
//     _confirm.dispose();
//     super.dispose();
//   }

//   Future<void> _doSignup() async {
//     final auth = context.read<AuthService>();
//     if ((_selectedRole ?? '').isEmpty ||
//         _username.text.trim().isEmpty ||
//         _email.text.trim().isEmpty ||
//         _password.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all the fields')),
//       );
//       return;
//     }
//     if (_password.text != _confirm.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Passwords do not match')),
//       );
//       return;
//     }

//     setState(() => busy = true);
//     try {
//       await auth.signupUser(
//         username: _username.text.trim(),
//         email: _email.text.trim(),
//         password: _password.text,
//         role: _selectedRole!,
//       );

//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Account created! Please log in.')),
//       );
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const LoginScreen()));
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
//     final viewInsets = MediaQuery.of(context).viewInsets.bottom;
//     final safeBottom = MediaQuery.of(context).padding.bottom;
//     final bottomGap = (viewInsets > 0 ? viewInsets : safeBottom);

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
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
//         title: const Text(' Add User'),
//       ),
//       body: SafeArea(
//         child: AntiOverflowScroll(
//           child: MaxWidth(
//             child: Padding(
//               padding: pad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 10),

//                   Center(
//                     child: Image.asset(
//                       'assets/Signup_img.png',
//                       height: context.w < 360 ? 180 : 230,
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       final isNarrow = constraints.maxWidth < 380;
//                       const spacing = 16.0;

//                       final usernameField = _LabeledField(
//                         label: 'Username',
//                         controller: _username,
//                         decoration: dec('Username'),
//                       );

//                       final roleDropdown = _RoleDropdown(
//                         roles: _roles,
//                         value: _selectedRole,
//                         onChanged: (v) => setState(() => _selectedRole = v),
//                       );

//                       if (isNarrow) {
//                         return Column(
//                           children: [
//                             usernameField,
//                             SizedBox(height: spacing),
//                             roleDropdown,
//                           ],
//                         );
//                       }
//                       return Row(
//                         children: [
//                           Expanded(child: usernameField),
//                           SizedBox(width: spacing),
//                           Expanded(child: roleDropdown),
//                         ],
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 16),

//                   _LabeledField(
//                       label: 'Email',
//                       controller: _email,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: dec('Email')),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Password', controller: _password, decoration: dec('Password')),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Confirm Password', controller: _confirm, decoration: dec('Confirm Password')),
//                   const SizedBox(height: 24),

//                   /// IMPORTANT: always pass a non-null callback (no more `VoidCallback?` error)
//                   GradientButton(
//                     text: busy ? 'Please wait…' : 'Register',
//                     onPressed: () {
//                       if (busy) return;
//                       _doSignup();
//                     },
//                   ),

//                   SizedBox(height: bottomGap + 16),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _RoleDropdown extends StatelessWidget {
//   final List<String> roles;
//   final String? value;
//   final ValueChanged<String?> onChanged;
//   const _RoleDropdown({required this.roles, required this.value, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     OutlineInputBorder b(Color c, [double w = 1]) =>
//         OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Role', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: value,
//           isExpanded: true,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: cs.surfaceContainerHigh,
//             enabledBorder: b(cs.outline),
//             focusedBorder: b(AppTheme.accentColor, 1.4),
//             border: b(cs.outline),
//             hintText: 'Select Role',
//             hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           ),
//           iconEnabledColor: cs.onSurfaceVariant,
//           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//           items: roles
//               .map((role) => DropdownMenuItem(
//                     value: role,
//                     child: Text(role, style: TextStyle(color: cs.onSurface)),
//                   ))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }

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



//p3//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/gradient_button.dart';
import '../../../services/auth_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _selectedRole;
  final List<String> _roles = const ['Admin', 'Project Manager', 'NOC', 'SCM'];

  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool busy = false;
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  // helpers
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

  Future<void> _doSignup() async {
    if (busy) return;

    final name = _username.text.trim();
    final email = _email.text.trim();
    final pass = _password.text;
    final conf = _confirm.text;
    final role = _selectedRole?.trim() ?? '';

    // 1) Validations
    if (name.isEmpty || email.isEmpty || pass.isEmpty || conf.isEmpty || role.isEmpty) {
      _toast('Please fill all the fields.');
      return;
    }
    if (!_looksLikeEmail(email)) {
      _toast('Please enter a valid email address.');
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
      await auth.signupUser(
        username: name,
        email: email,
        password: pass,
        role: role,
      );

      if (!mounted) return;
      _toast('Account created! Please log in.', success: true);
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().toLowerCase();
      if (msg.contains('409') || msg.contains('already') || msg.contains('exists')) {
        _toast('User already exists.');
      } else {
        _toast('Could not create account. Please try again.');
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final cs = Theme.of(context).colorScheme;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).padding.bottom;
    final bottomGap = (viewInsets > 0 ? viewInsets : safeBottom);

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
        title: const Text(' Add User'),
      ),
      body: SafeArea(
        child: AntiOverflowScroll(
          child: MaxWidth(
            child: Padding(
              padding: pad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),

                  Center(
                    child: Image.asset(
                      'assets/Signup_img.png',
                      height: context.w < 360 ? 180 : 230,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 380;
                      const spacing = 16.0;

                      final usernameField = _LabeledField(
                        label: 'Username',
                        controller: _username,
                        decoration: dec('Username'),
                      );

                      final roleDropdown = _RoleDropdown(
                        roles: _roles,
                        value: _selectedRole,
                        onChanged: (v) => setState(() => _selectedRole = v),
                      );

                      if (isNarrow) {
                        return Column(
                          children: [
                            usernameField,
                            SizedBox(height: spacing),
                            roleDropdown,
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(child: usernameField),
                          SizedBox(width: spacing),
                          Expanded(child: roleDropdown),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  _LabeledField(
                      label: 'Email',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: dec('Email')),
                  const SizedBox(height: 16),

                  // Password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _password,
                        obscureText: _obscure1,
                        style: TextStyle(color: cs.onSurface),
                        decoration: dec('Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_obscure1 ? Icons.visibility : Icons.visibility_off,
                                color: cs.onSurfaceVariant),
                            onPressed: () => setState(() => _obscure1 = !_obscure1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirm Password',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _confirm,
                        obscureText: _obscure2,
                        style: TextStyle(color: cs.onSurface),
                        decoration: dec('Confirm Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_obscure2 ? Icons.visibility : Icons.visibility_off,
                                color: cs.onSurfaceVariant),
                            onPressed: () => setState(() => _obscure2 = !_obscure2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  GradientButton(
                    text: busy ? 'Please wait…' : 'Register',
                    onPressed: () {
                      if (busy) return;
                      _doSignup();
                    },
                  ),

                  SizedBox(height: bottomGap + 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  final List<String> roles;
  final String? value;
  final ValueChanged<String?> onChanged;
  const _RoleDropdown({required this.roles, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    OutlineInputBorder b(Color c, [double w = 1]) =>
        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Role', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: cs.surfaceContainerHigh,
            enabledBorder: b(cs.outline),
            focusedBorder: b(AppTheme.accentColor, 1.4),
            border: b(cs.outline),
            hintText: 'Select Role',
            hintStyle: TextStyle(color: cs.onSurfaceVariant),
          ),
          iconEnabledColor: cs.onSurfaceVariant,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          items: roles
              .map((role) => DropdownMenuItem(
                    value: role,
                    child: Text(role, style: TextStyle(color: cs.onSurface)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

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
