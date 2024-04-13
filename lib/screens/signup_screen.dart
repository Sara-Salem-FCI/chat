import 'package:chat/constans/colors.dart';
import 'package:chat/cubit/signup_cubit/signup_cubit.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/widgests/material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/signup_cubit/signup_state.dart';
import '../helper/show_snack_bar.dart';
import '../widgests/text_form_field.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({
    super.key,
  });

  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (BuildContext context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        }
        else if (state is SignupSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(email: email!)));
          isLoading = false;
        }
        else if (state is SignupFailed) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: kBackgroundColor,
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Image(
                      image: AssetImage('assets/images/chatting.png'),
                      width: 250,
                      height: 250,
                    ),
                    const Center(
                      child: Text(
                        'Chatting',
                        style: TextStyle(
                          height: .5,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Email is required';
                        } else if (value!.length < 3) {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      hintText: 'email',
                      keyboard: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      pass: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Password is required';
                        } else if (value!.length < 6) {
                          return 'Password must be at least 6 letters';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      hintText: 'password',
                      keyboard: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      text: 'Sign Up',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignupCubit>(context).registerUser(email: email, password: password);
                        } else {}
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xffD6F7E7),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
