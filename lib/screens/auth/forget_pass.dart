import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Circular Avatar (App Logo)
              SizedBox(height: screenHeight * 0.08),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/library_logo.png'), // Replace with your logo
              ),

              SizedBox(height: screenHeight * 0.08),

              // Card Box Container
              Center(
                child: Container(
                  width: screenWidth * 0.85,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Heading
                      Text(
                        "Forgot Your Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Instruction Text
                      Text(
                        "Please enter the email address you'd like your password reset information sent to.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      SizedBox(height: 24),

                      // Email Text Field
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Enter email address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Send Reset Link Button
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Handle reset link logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Reset link sent!")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Send Reset Link", style: TextStyle(fontSize: 16,
                        color: Colors.indigo[900]) ,),
                      ),

                      SizedBox(height: 16),

                      // Back to Login
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // or navigate to login
                          },
                          child: Text(
                            "Back To Login",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
