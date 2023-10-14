import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_text_field.dart';
import '../components/my_button.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign up user
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password do not match!"),
        ),
      );
      return;
    }

    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  //logo
                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.grey[800],
                  ),

                  const SizedBox(height: 50),

                  //create account message
                  const Text(
                    "Create an Account Here!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 50),

                  //email textfield
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false),

                  const SizedBox(height: 10),

                  //password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true),

                  const SizedBox(height: 10),

                  //confirm password textfield
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true),

                  const SizedBox(height: 25),

                  //sign up button
                  MyButton(onTap: signUp, text: "Sign Up"),

                  const SizedBox(height: 50),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Sign In Now',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
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
