import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/colors.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/providers/text_controller_notifier.dart';
import 'package:penya_business/widgets/customComponents.dart';
import 'package:penya_business/widgets/main_appbar.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  ConsumerState<Signin> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final emailEditingController = ref.watch(textEditingControllersFamily('name'));
    final passEditingController = ref.watch(textEditingControllersFamily('description'));

    return Scaffold(
      appBar: MainAppbar(),
      body: SizedBox(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Placeholder(
                      fallbackHeight: 50,
                      fallbackWidth: 50,
                    ),
                    CustomTextFormField(hintText: 'Enter your email', width: 1.0, controller: emailEditingController,
                     validator: emailValidator),
                    CustomTextFormField(hintText: 'Enter password', width: 1.0,controller: passEditingController, isPasswordField: true,),
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
                          onPressed: (){
                            authNotifier.signIn(emailEditingController.text.trim(), passEditingController.text.trim());
                            if(ref.read(authProvider).value != null){
                              context.go('/');
                            }
                          },
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
      ),
    );
  }
}
