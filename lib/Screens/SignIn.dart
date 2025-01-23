import 'package:flutter/material.dart';
import 'package:penya_business/colors.dart';
import 'package:penya_business/widgets/customComponents.dart';
import 'package:penya_business/widgets/main_appbar.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Placeholder(),
                    CustomTextFormField(hintText: 'Enter your email', width: 1.0, controller: _email,),
                    CustomTextFormField(hintText: 'Enter password', width: 1.0,controller: _pass, isPasswordField: true,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Text('Forgot password?'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text('Log In'),
                      ),
                    ),
                  ],
                ),
              ),
              Text('App Version 0.1.37'),
            ],
          ),
        ),
      ),
    );
  }
}
