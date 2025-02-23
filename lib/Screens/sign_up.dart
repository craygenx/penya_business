import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/providers/text_controller_notifier.dart';
import 'package:penya_business/widgets/custom_components.dart';

import '../colors.dart';
import '../widgets/main_appbar.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);
    final TextEditingController fName = ref.watch(textEditingControllersFamily('signupFname'));
    final TextEditingController lName = ref.watch(textEditingControllersFamily('signupLname'));
    final TextEditingController email = ref.watch(textEditingControllersFamily('signupEmail'));
    final TextEditingController pass = ref.watch(textEditingControllersFamily('signupPass'));
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
                        CustomTextFormField(hintText: 'First name', controller: fName),
                        CustomTextFormField(hintText: 'Last Name', controller: lName),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: CustomTextFormField(hintText: 'Enter your email', controller: email, width: 0.95, validator: emailValidator,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CustomTextFormField(hintText: 'New password', controller: pass, isPasswordField: true, width: 0.95, validator: strongPasswordValidator,),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ElevatedButton(
                        onPressed: (){
                          authNotifier.signUp(email.text.trim(), pass.text.trim(), '${fName.text} ${lName.text}');
                            if(ref.read(authProvider).value != null){
                              context.go('/store');
                            }
                        },
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
