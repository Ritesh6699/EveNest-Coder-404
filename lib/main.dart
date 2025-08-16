import 'package:flutter/material.dart';
import 'vrole.dart'; // Import your VrolePage from vrole.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedRole = "Customer";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // responsive width
    if (containerWidth > 400) containerWidth = 400;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset("assets/bg.png", fit: BoxFit.cover),

          // Semi-transparent Overlay
          Container(color: Colors.black.withOpacity(0.2)),

          // Centered Form
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: containerWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset('assets/logo.png', height: 100),
                      const SizedBox(height: 30),

                      // Role Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildRoleBox("Customer"),
                          const SizedBox(width: 20),
                          buildRoleBox("Vendor"),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Email
                      buildInputBox("Email"),
                      const SizedBox(height: 20),

                      // Password
                      buildInputBox("Password", obscureText: true),
                      const SizedBox(height: 20),

                      // Confirm Password
                      buildInputBox("Confirm Password", obscureText: true),
                      const SizedBox(height: 30),

                      // Login Button with navigation
                      SizedBox(
                        width: containerWidth * 0.5,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (selectedRole == "Vendor") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VrolePage(),
                                ),
                              );
                            } else {
                              // You can handle Customer login or show a message here
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Customer login not implemented yet',
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 102, 20, 79),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Optional: Forgot Password
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Role Box with Animated Transition
  Widget buildRoleBox(String role) {
    bool isSelected = selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 140,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Center(
          child: Text(
            role,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Input Box Widget
  Widget buildInputBox(String label, {bool obscureText = false}) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.amber, width: 2),
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
