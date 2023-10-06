import 'package:amazone_clone/common/widgets/cumstom_button.dart';
import 'package:amazone_clone/common/widgets/custom_textfield.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = 'auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariable.greyBackgroundCOlor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              RadioListTile(
                activeColor: GlobalVariable.primaryColor,
                tileColor: _auth == Auth.signUp
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                value: Auth.signUp.toString(),
                groupValue: _auth.toString(),
                onChanged: (String? value) {
                  setState(() {
                    _auth = Auth.values
                        .firstWhere((element) => element.toString() == value);
                  });
                },
              ),
              // RadioListTile<Auth>(
              //   activeColor: GlobalVariable.primaryColor,
              //   tileColor: _auth == Auth.signUp
              //       ? GlobalVariable.backgroundColor
              //       : GlobalVariable.greyBackgroundCOlor,
              //   title: const Text(
              //     'Create Account',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              //   value: Auth.signUp,
              //   groupValue: _auth,
              //   onChanged: (Auth? value) {
              //     setState(() {
              //       _auth = value!;
              //     });
              //   },
              // ),

              // ListTile(
              //   tileColor: _auth == Auth.signUp
              //       ? GlobalVariable.backgroundColor
              //       : GlobalVariable.greyBackgroundCOlor,
              //   title: const Text(
              //     'Create Account',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              //   leading: Radio(
              //     activeColor: GlobalVariable.secondaryColor,
              //     value: Auth.signUp,
              //     groupValue: _auth,
              //     onChanged: (Auth? value) {
              //       setState(() {
              //         _auth = value!;
              //       });
              //     },
              //   ),
              // ),
              if (_auth == Auth.signUp)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Name',
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      CustomButton(
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          text: "Sign Up")
                    ]),
                  ),
                ),
              RadioListTile<Auth>(
                activeColor: GlobalVariable.primaryColor,
                title: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                tileColor: _auth == Auth.signIn
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundCOlor,
                value: Auth.signIn,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
              if (_auth == Auth.signIn)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(children: [
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      CustomButton(
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                          text: "Sign In")
                    ]),
                  ),
                ),
            ],
          ),
        )));
  }
}
