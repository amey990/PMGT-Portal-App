// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import 'login_screen.dart'; // for CustomTextField & GradientButton

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   String? _selectedRole;
//   final List<String> _roles = ['Admin', 'Project Manager', 'NOC', 'SCM'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//        appBar: AppBar(
//         backgroundColor: AppTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Colors.white),
//         title: const Text(' Add User'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 10),

//               // Illustration
//               Image.asset(
//                 'assets/Signup_img.png',
//                 height: 230,
//                 fit: BoxFit.contain,
//               ),

//               const SizedBox(height: 20),

//               // Username & Role Row
//               Row(
//                 children: [
//                   // Username
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           'Username',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         TextField(
//                           style: TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             hintText: 'Enter Username',
//                             hintStyle: TextStyle(color: Colors.white54),
//                             filled: true,
//                             fillColor: Colors.white12,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(width: 16),

//                   // Role Dropdown
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Role',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           decoration: BoxDecoration(
//                             color: Colors.white12,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               isExpanded: true,
//                               value: _selectedRole,
//                               hint: const Text(
//                                 'Select Role',
//                                 style: TextStyle(color: Colors.white54),
//                               ),
//                               iconEnabledColor: Colors.white54,
//                               dropdownColor: AppTheme.backgroundColor,
//                               items: _roles.map((role) {
//                                 return DropdownMenuItem(
//                                   value: role,
//                                   child: Text(
//                                     role,
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedRole = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // Email
//               const CustomTextField(
//                 label: 'Email',
//                 hint: 'Enter your registered email',
//               ),

//               const SizedBox(height: 16),

//               // Password
//               const CustomTextField(
//                 label: 'Password',
//                 hint: 'Enter password',
//                 isPassword: true,
//               ),

//               const SizedBox(height: 16),

//               // Confirm Password
//               const CustomTextField(
//                 label: 'Confirm Password',
//                 hint: 'Re-enter password',
//                 isPassword: true,
//               ),

//               const SizedBox(height: 24),

//               // Register Button
//               GradientButton(
//                 text: 'Register',
//                 onPressed: () {
//                    Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => LoginScreen(),
//                       ),
//                     );
//                 },
//               ),

//               const SizedBox(height: 32),
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
//     final viewInsets = MediaQuery.of(context).viewInsets.bottom;   // keyboard
//     final safeBottom = MediaQuery.of(context).padding.bottom;      // gesture/nav area
//     final bottomGap  = (viewInsets > 0 ? viewInsets : safeBottom); // whichever is active


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

//                   // Username & Role — stack on small, row on larger
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       final isNarrow = constraints.maxWidth < 380;
//                       final spacing = 16.0;

//                       final usernameField = _LabeledField(
//                         label: 'Username',
//                         controller: _username,
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

//                   _LabeledField(label: 'Email', controller: _email, keyboardType: TextInputType.emailAddress),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Password', controller: _password),
//                   const SizedBox(height: 16),

//                   _PasswordField(label: 'Confirm Password', controller: _confirm),
//                   const SizedBox(height: 24),

//                   GradientButton(
//                     text: 'Register',
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginScreen()),
//                       );
//                     },
//                   ),
//                   // const SizedBox(height: 24),
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
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Role', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               isExpanded: true,
//               value: value,
//               hint: Text('Select Role', style: TextStyle(color: cs.onSurfaceVariant)),
//               iconEnabledColor: cs.onSurfaceVariant,
//               dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//               items: roles
//                   .map((role) => DropdownMenuItem(
//                         value: role,
//                         child: Text(role, style: TextStyle(color: cs.onSurface)),
//                       ))
//                   .toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

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

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
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

                  // Username & Role
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

                  _LabeledField(label: 'Email', controller: _email, keyboardType: TextInputType.emailAddress, decoration: dec('Email')),
                  const SizedBox(height: 16),

                  _PasswordField(label: 'Password', controller: _password, decoration: dec('Password')),
                  const SizedBox(height: 16),

                  _PasswordField(label: 'Confirm Password', controller: _confirm, decoration: dec('Confirm Password')),
                  const SizedBox(height: 24),

                  GradientButton(
                    text: 'Register',
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
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
          initialValue: value,
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
          items: roles.map((role) => DropdownMenuItem(value: role, child: Text(role, style: TextStyle(color: cs.onSurface)))).toList(),
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
