import 'package:carto/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginContent extends StatelessWidget {
  final void Function()? goRegisterScreen;

  const LoginContent({
    super.key,
    required this.goRegisterScreen,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeText(
              title: "Welcome Back",
              text: "Enter your Phone number or Email \naddress for sign in.",
            ),
            SignInForm(),
            const SizedBox(height: 16),
            Center(
                child: Text("Or",
                    style:
                        TextStyle(color: Color(0xFF010F07).withOpacity(0.7)))),
            const SizedBox(height: 16 * 1.5),
            Center(
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                  text: "Don’t have account? ",
                  children: <TextSpan>[
                    TextSpan(
                      text: "Create new account.",
                      style: const TextStyle(color: Color(0xFF22A45D)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = goRegisterScreen,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  final String title, text;

  const WelcomeText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16 / 2),
        Text(text, style: TextStyle(color: Color(0xFF868686))),
        const SizedBox(height: 24),
      ],
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  void login(){
    final authCubit =  context.read<AuthCubit>();
    authCubit.login(email: emailController.text.trim(), password: passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Email Address",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF3F2F2)),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF3F2F2)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                onSaved: (value) {},
                decoration: InputDecoration(
                  hintText: "Password",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF3F2F2)),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF3F2F2)),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: _obscureText
                        ? const Icon(Icons.visibility_off,
                            color: Color(0xFF868686))
                        : const Icon(Icons.visibility,
                            color: Color(0xFF868686)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Forget Password
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forget Password?",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 16),

              // Sign In Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // _formKey.currentState!.save();
                    login();
                    // context.pushNamed(Routes.shop);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22A45D),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Sign in"),
              ),
            ],
          ),
        );
  }
}
