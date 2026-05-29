import 'package:flutter/material.dart';
import 'package:lms/screens/unimplemented_screen.dart';
import 'package:lms/screens/admin/admin_home_page.dart';
import 'package:lms/screens/registration_page.dart';
import 'forget_pass.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isUserLogin = true;

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isUserIdValid = true;
  bool _isPasswordValid = true;

  void _validateUserId(String value) {
    final bool isValid = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(value);
    setState(() {
      _isUserIdValid = isValid;
    });
  }

  void _isValidPassword(String password) {
    // Regular expression to check the password criteria
    final bool isValid = RegExp(
      r'^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{6,}$',
    ).hasMatch(password);
    setState(() {
      _isPasswordValid = isValid;
    });
  }

  void _login() {
    if (_isUserIdValid &&
        _userIdController.text.isNotEmpty &&
        _isPasswordValid &&
        _passwordController.text.isNotEmpty) {
      // Navigate to Welcome Screen
      if (isUserLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHomePage()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double appBarHeight = screenHeight / 9;
    double buttonWidth = screenWidth * 0.25; // Adjust button width
    double formWidth = screenWidth * 0.80; // Adjust form width

    return Scaffold(
      resizeToAvoidBottomInset:
      true, // Automatically resizes the body when keyboard appears
      backgroundColor: Colors.blue[400],

      body: Center(
        // Make the body scrollable
        child: SingleChildScrollView(
          child: Container(
            width: formWidth,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(12, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage('assets/library_logo.png'),
                ),
                SizedBox(height: 10),
                Text(
                  "Library Management",
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => isUserLogin = true),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8,
                              horizontal: 16),
                          decoration: BoxDecoration(
                            color: isUserLogin ? Colors.white : Colors
                                .transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isUserLogin ? Colors.blue : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "User Login",
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontWeight: isUserLogin
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isUserLogin ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.08),
                      GestureDetector(
                        onTap: () => setState(() => isUserLogin = false),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10,
                              horizontal: 20),
                          decoration: BoxDecoration(
                            color: !isUserLogin ? Colors.white : Colors
                                .transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: !isUserLogin ? Colors.blue : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "Admin Login",
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontWeight: !isUserLogin
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: !isUserLogin ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextField(
                  controller: _userIdController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: _validateUserId,
                  decoration: InputDecoration(
                    labelText: "User ID",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.person),
                    errorText: _isUserIdValid ? null : "Invalid User Id",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  onChanged: _isValidPassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons
                              .visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorText: _isPasswordValid ? null : "Invalid Password",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.015),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Login",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      const SizedBox(width: 4),
                      Transform.translate(
                        offset: Offset(0, 1),
                        child: const Icon(Icons.login, size: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (
                              context) => const RegistrationPage()),
                        );
                      },
                      child: const Text(
                          "New Registration", style: TextStyle(fontSize: 12)),
                    ),
                    const Text(" | ", style: TextStyle(fontSize: 16)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (
                              context) => const ForgetPasswordPage()),
                        );
                      },
                      child: const Text(
                          "Forgot Password?", style: TextStyle(fontSize: 12)),
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
}