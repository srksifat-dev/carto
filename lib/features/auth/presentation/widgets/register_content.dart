import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit.dart';

class RegisterContent extends StatefulWidget {
  final void Function()? goLoginScreen;
  const RegisterContent({super.key,required this.goLoginScreen});

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeText(
                title: "Create Account",
                text: "Enter your Name, Email, Password and Avatar \nfor sign up.",
              ),

              // Sign Up Form
              SignUpForm(),
              const SizedBox(height: 16),

              // Already have account
              Center(
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    text: "Already have account? ",
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(color: Color(0xFF22A45D)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.goLoginScreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "By Signing up you agree to our Terms \nConditions & Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key,});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController avatarUrlController = TextEditingController();


  void register(){
    final authCubit =  context.read<AuthCubit>();
    authCubit.register(email: emailController.text.trim(), password: passwordController.text.trim(),name: nameController.text.trim(),avatarUrl: avatarUrlController.text.trim(),);
  }
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name Field
          TextFormField(
            controller: nameController,
            onSaved: (value) {},
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "Full Name",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF3F2F2)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF3F2F2)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: avatarUrlController,
            onSaved: (value) {},
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "Avatar Url",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF3F2F2)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF3F2F2)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Email Field
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
            textInputAction: TextInputAction.next,
            onChanged: (value) {},
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
                    ? const Icon(Icons.visibility_off, color: Color(0xFF868686))
                    : const Icon(Icons.visibility, color: Color(0xFF868686)),
              ),
            ),
          ),
          SizedBox(height: 16,),

          // Sign Up Button
          ElevatedButton(
            onPressed: (){
              register();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22A45D),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}
