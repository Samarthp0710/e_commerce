import 'package:e_commerce/mainpage.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  bool _isValidPassword(String password) {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  void _validateEmail(String value) {
    setState(() {
      _emailError = _isValidEmail(value) ? null : 'Invalid email format';
    });
  }

  void _validatePhone(String value) {
    setState(() {
      _phoneError = _isValidPhone(value) ? null : 'Phone must be 10 digits';
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _passwordError = _isValidPassword(value)
          ? null
          : 'Password must be 8+ chars, include upper, lower, number, & symbol';
    });
  }

  void _showSnackbar(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: isError ? Colors.white : Colors.black),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Validation Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> signUpUser() async {
    _validateEmail(_emailController.text.trim());
    _validatePhone(_phoneController.text.trim());
    _validatePassword(_passwordController.text.trim());

    if (_emailError != null) {
      _showValidationDialog(_emailError!);
      return;
    }
    if (_phoneError != null) {
      _showValidationDialog(_phoneError!);
      return;
    }
    if (_passwordError != null) {
      _showValidationDialog(_passwordError!);
      return;
    }

    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showSnackbar("Please fill in all fields", isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      print('Attempting to create user with email: ${_emailController.text.trim()}');
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Authentication timed out. Please check your internet connection.');
      });

      final user = userCredential.user;

      if (user != null) {
        print('User created with UID: ${user.uid}. Saving to Firestore...');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
              'uid': user.uid,
              'full_name': _nameController.text.trim(),
              'phone': _phoneController.text.trim(),
              'email': _emailController.text.trim(),
              'created_at': Timestamp.now(),
              'family_emergency_no': '0000000000',
            })
            .timeout(const Duration(seconds: 10), onTimeout: () {
              throw Exception('Firestore operation timed out. Please check your internet connection.');
            });

        print('Firestore data saved. Showing SnackBar...');
        _showSnackbar("Account created successfully");

        // Delay navigation to allow SnackBar to be displayed
        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) {
          print('Widget not mounted. Skipping navigation.');
          return;
        }

        print('Navigating to Mainpage...');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        print('User creation failed: User is null.');
        _showSnackbar("User creation failed", isError: true);
      }
    } catch (e) {
      print('Error during signup: $e');
      _showSnackbar("Error: ${e.toString()}", isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
        print('Loader dismissed.');
      }
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/sahayak_logo.png', height: 200),
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(_nameController, "Full Name", Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(
                        _phoneController,
                        "Phone Number",
                        Icons.phone,
                        onChanged: _validatePhone,
                        errorText: _phoneError,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        _emailController,
                        "Email",
                        Icons.email,
                        onChanged: _validateEmail,
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        _passwordController,
                        "Password",
                        Icons.lock,
                        isObscure: true,
                        onChanged: _validatePassword,
                        errorText: _passwordError,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: signUpUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: navigateToLogin,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              child: Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isObscure = false,
    Function(String)? onChanged,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        prefixIcon: Icon(icon, color: Colors.black),
        errorText: errorText,
      ),
    );
  }
}