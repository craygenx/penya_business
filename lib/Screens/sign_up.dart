import 'package:flutter/material.dart';
import 'package:penya_business/widgets/customComponents.dart';

import '../colors.dart';
import '../widgets/main_appbar.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('Sign Up'),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    // height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextFormField(hintText: 'First name', controller: _fName),
                        CustomTextFormField(hintText: 'Last Name', controller: _lName),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: CustomTextFormField(hintText: 'Enter your email', controller: _email, width: 0.95),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CustomTextFormField(hintText: 'New password', controller: _pass, isPasswordField: true, width: 0.95),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('Continue'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
