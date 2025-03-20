import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopx/core/utils/size_config.dart';
import 'package:shopx/core/theme/app_colors.dart';
import 'package:shopx/presentation/bloc/Auth/auth_bloc.dart';
import 'package:shopx/presentation/screens/auth/login_screen.dart';
import 'package:shopx/presentation/screens/navigation/custom_navigation.dart';
import 'package:shopx/presentation/widgets/custom_button.dart';
import 'package:shopx/presentation/widgets/custom_text.dart';
import 'package:shopx/presentation/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Sizecf().init(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "SHOPX",
                    style: TextStyle(
                      fontSize: Sizecf.blockSizeHorizontal! * 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primarycolor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Customtext(
                  text: 'Create your new account',
                  size: Sizecf.scrnWidth! * 0.15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 6),
                Customtext(
                  text:
                      'Create an account to start looking for the product you like ',
                  size: Sizecf.blockSizeVertical! * 2,
                  fontWeight: FontWeight.w400,
                  textcolor: AppColors.lightgrey,
                ),
                const SizedBox(height: 25),
                Customtext(
                  text: 'Name ',
                  size: Sizecf.blockSizeVertical! * 2,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Enter Name',
                ),
                const SizedBox(height: 20),
                Customtext(
                  text: 'Email Address ',
                  size: Sizecf.blockSizeVertical! * 1.8,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter Email',
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
                  alignment: Alignment.center,
                  child: const Text(
                    'I Agree with Terms of Service and Privacy Policy ',
                    style: TextStyle(color: AppColors.primarycolor),
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const ShopXNavigation(),
                        ),
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
                          text: 'Register',
                          onPressed: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty) {
                              context.read<AuthBloc>().add(
                                RegisterEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                ),
                              );
                            } else {
                              var snackBar = SnackBar(
                                content: Text('Fill the Value correctly !'),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            }
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
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizecf.blockSizeVertical! * 1.7,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
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
                                              const LoginScreen(),
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
