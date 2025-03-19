// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:shopx/core/size_config.dart';
import 'package:shopx/core/theme/app_colors.dart';
import 'package:shopx/presentation/screens/auth/signup_screen.dart';
import 'package:shopx/presentation/widgets/custom_button.dart';
import 'package:shopx/presentation/widgets/custom_text.dart';
import 'package:shopx/presentation/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Sizecf().init(context);
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Customtext(
                  text: 'Login to your account',
                  size: Sizecf.blockSizeVertical! * 4,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 6),
                Customtext(
                  text: 'Please sign in to your account ',
                  size: Sizecf.blockSizeVertical! * 2,
                  fontWeight: FontWeight.w400,
                  textcolor: AppColors.lightgrey,
                ),
                SizedBox(height: 25),
                Customtext(
                  text: 'Email Address ',
                  size: Sizecf.blockSizeVertical! * 1.8,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                Customtext(
                  text: 'Password ',
                  size: Sizecf.blockSizeVertical! * 1.8,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  isPassword: true,
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add forgot password functionality
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: AppColors.primarycolor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Sign In',
                  onPressed: () {},
                  textColor: Colors.white,
                  borderRadius: 16.0,
                  size: Size(Sizecf.scrnWidth!, Sizecf.scrnHeight! * 0.06),
                ),

                SizedBox(height: 20),

                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizecf.blockSizeVertical! * 1.7,
                      ), // Default text style
                      children: [
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            color: AppColors.primarycolor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder:
                                          (BuildContext context) =>
                                              SignupScreen(),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
