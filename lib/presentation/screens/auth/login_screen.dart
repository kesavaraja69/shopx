// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopx/core/utils/size_config.dart';
import 'package:shopx/core/theme/app_colors.dart';
import 'package:shopx/presentation/screens/auth/signup_screen.dart';
import 'package:shopx/presentation/screens/home/home_screen.dart';
import 'package:shopx/presentation/widgets/custom_button.dart';
import 'package:shopx/presentation/widgets/custom_text.dart';
import 'package:shopx/presentation/widgets/custom_textfield.dart';

import '../../bloc/Auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Sizecf().init(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
                const SizedBox(height: 6),
                Customtext(
                  text: 'Please sign in to your account ',
                  size: Sizecf.blockSizeVertical! * 2,
                  fontWeight: FontWeight.w400,
                  textcolor: AppColors.lightgrey,
                ),
                const SizedBox(height: 25),
                Customtext(
                  text: 'Email Address ',
                  size: Sizecf.blockSizeVertical! * 1.8,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                Customtext(
                  text: 'Password ',
                  size: Sizecf.blockSizeVertical! * 1.8,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: AppColors.primarycolor),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    final bool isLoading = state is AuthLoading;
                    return isLoading
                        ? const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        )
                        : CustomElevatedButton(
                          text: 'Sign In',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              LoginEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          },
                          textColor: Colors.white,
                          borderRadius: 16.0,
                          size: Size(
                            Sizecf.scrnWidth!,
                            Sizecf.scrnHeight! * 0.06,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizecf.blockSizeVertical! * 1.7,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
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
                                              const SignupScreen(),
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
