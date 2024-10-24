import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/components/my_button.dart';
import 'package:socialmedia/components/my_textfield.dart';
import 'package:socialmedia/cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    //auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure the fields are not empty
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      //ensure passwords match

      if (password == confirmPassword) {
        authCubit.register(name, email, password);
      }
      //passwords do not match
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Passwords do not match !')));
      }
    }

    //fields are empty => display error
    else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please Complete all fields')));
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(
            Icons.lock_open_rounded,
            size: 100,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          SizedBox(
            height: 25,
          ),

          //welcome msg
          Text(
            'Lets create an account for you',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //name
          MyTextField(
              controller: nameController,
              hintText: 'Enter the name',
              obscureText: false),
          SizedBox(
            height: 10,
          ),

          //email
          MyTextField(
              controller: emailController,
              hintText: 'Enter the email',
              obscureText: false),
          SizedBox(
            height: 10,
          ),

          //password
          MyTextField(
              controller: passwordController,
              hintText: 'Enter the password',
              obscureText: true),
          SizedBox(
            height: 10,
          ),
          //confirmPassword
          MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm password',
              obscureText: true),
          SizedBox(
            height: 15,
          ),

          //sign-up
          MyButton(onTap: () => register(), text: 'Sign-Up'),

          SizedBox(
            height: 25,
          ),

          //register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account ?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  'Login now ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
