
 /* // Simulated login action (replace with actual API call)
  import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  bool isvisible = true;
  bool _isLoading = false; // To show loading state


Future<void> performLogin(String email, String password) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Simulate a delay (e.g., waiting for API response)
      await Future.delayed(const Duration(seconds: 2));

      // Here, you'd normally perform your API call to login the user
      // If login succeeds, navigate to a different screen or show success message
      if (email == "user@example.com" && password == "password123") {
        //ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
       // );

        // Navigate to the home page or desired screen after successful login
        // Get.offAll(() => const CustomBottomNavigationBar());
      } else {
        // Show error if login fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    } catch (error) {
      // Handle errors, such as network issues or server problems
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }*/