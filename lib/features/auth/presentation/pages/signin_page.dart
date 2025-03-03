import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snakbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/app_text_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatefulWidget {
  static const signinPage = "/";
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailuer) {
                  showSnakbar(context, state.errorMessage);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  const Loader();
                }
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Sign In.",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppTextField(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AppTextField(
                        hintText: "Password",
                        controller: passwordController,
                        isObsureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthGradientButton(
                        text: "Sign In",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            _signin(context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, SignupPage.signupPage),
                        child: RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have a account?  ",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _signin(BuildContext context) {
    return context.read<AuthBloc>().add(
          AuthSignin(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }
}
