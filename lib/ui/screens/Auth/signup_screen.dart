import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import 'login_screen.dart'; // for CustomTextField & GradientButton

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _selectedRole;
  final List<String> _roles = ['Admin', 'Project Manager', 'NOC', 'SCM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
       appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text(' Add User'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              // Illustration
              Image.asset(
                'assets/Signup_img.png',
                height: 230,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              // Username & Role Row
              Row(
                children: [
                  // Username
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Username',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter Username',
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Role Dropdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Role',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedRole,
                              hint: const Text(
                                'Select Role',
                                style: TextStyle(color: Colors.white54),
                              ),
                              iconEnabledColor: Colors.white54,
                              dropdownColor: AppTheme.backgroundColor,
                              items: _roles.map((role) {
                                return DropdownMenuItem(
                                  value: role,
                                  child: Text(
                                    role,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Email
              const CustomTextField(
                label: 'Email',
                hint: 'Enter your registered email',
              ),

              const SizedBox(height: 16),

              // Password
              const CustomTextField(
                label: 'Password',
                hint: 'Enter password',
                isPassword: true,
              ),

              const SizedBox(height: 16),

              // Confirm Password
              const CustomTextField(
                label: 'Confirm Password',
                hint: 'Re-enter password',
                isPassword: true,
              ),

              const SizedBox(height: 24),

              // Register Button
              GradientButton(
                text: 'Register',
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
