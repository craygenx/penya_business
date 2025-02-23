import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/colors.dart';
import 'package:penya_business/models/business_model.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/providers/business_provider.dart';
import 'package:penya_business/providers/text_controller_notifier.dart';
import 'package:penya_business/widgets/custom_components.dart';
import 'package:uuid/uuid.dart';

class BusinessRegistration extends ConsumerStatefulWidget {
  const BusinessRegistration({super.key});

  @override
  ConsumerState<BusinessRegistration> createState() => _BusinessRegistrationState();
}

class _BusinessRegistrationState extends ConsumerState<BusinessRegistration> {
  @override
  Widget build(BuildContext context) {
    final businessNotifier = ref.read(businessProvider.notifier);
    final ownerNameController = ref.watch(textEditingControllersFamily('businessOwnerName'));
    final ownerEmailController = ref.watch(textEditingControllersFamily('businessOwnerEmail'));
    final businessNameController = ref.watch(textEditingControllersFamily('businessName'));
    final businessEmailController = ref.watch(textEditingControllersFamily('businessEmail'));
    final businessLocationController = ref.watch(textEditingControllersFamily('businessLocation'));
    final businessPhoneController = ref.watch(textEditingControllersFamily('businessPhone'));

    final authState = ref.watch(authProvider);

    ownerNameController.text = authState.value?.displayName ?? '';
    ownerEmailController.text = authState.value?.email ?? '';

    var uuid = Uuid();
    
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>context.go('/'), icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5, left: 5),
            child: IconButton(onPressed: () => context.push('/orders'), icon: Icon(Icons.shopping_basket)),
            ),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width *.95,
              child: Text('owner\'s info',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Container(
              width: width *.95,
              height: 120,
              decoration: BoxDecoration(
  // Suggested code may be subject to a license. Learn more: ~LicenseLog:111305327.
                border: Border.all(
                  color: Colors.black,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width *.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                              Icons.person_2_outlined,
                            ),
                          ),
                        SizedBox(
                          width: width * .8,
                          child: TextField(
                            controller: ownerNameController,
                            readOnly: true,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.5),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                  ),
                              )
                            ),
                          ),
                        ),
                      ],
                      ),
                  ),
                  SizedBox(
                    width: width *.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                              Icons.mail_outlined,
                            ),
                          ),
                        SizedBox(
                          width: width * .8,
                          child: TextField(
                            controller: ownerEmailController,
                            readOnly: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none
                              )
                            ),
                          ),
                        ),
                      ],
                      ),
                  ),
                ]
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            SizedBox(
              width: width *.95,
              child: Text('Bussiness info',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Container(
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width *.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bussiness name'),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        SizedBox(
                          width: width * .95,
                          child: CustomTextFormField(hintText: "Enter bussiness name",
                          backgroundColor: Colors.white, border: true, controller: businessNameController,)
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width *.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bussiness email'),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        SizedBox(
                          width: width *.95,
                          child: CustomTextFormField(hintText: "bussiness@gmail.com",
                          backgroundColor: Colors.white, border: true, controller: businessEmailController,)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width *.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bussiness location'),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        SizedBox(
                          width: width,
                          child: CustomTextFormField(hintText: "Eg Kahawa west, Nairobi",
                          backgroundColor: Colors.white, border: true, controller: businessLocationController,)
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width *.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bussiness phone number'),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        SizedBox(
                          width: width,
                          child: CustomTextFormField(hintText: "+254712345678",
                          controller: businessPhoneController, backgroundColor: Colors.white, border: true,)
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(onPressed: (){
                      Business business = Business(id: uuid.v4(), name: businessNameController.text, ownerId: authState.value?.id ?? '', isSingleEntity: true,
                      marketplaceEnabled: true, totalIncome: 0.0, businessEmail: businessEmailController.text, businessPhone: businessPhoneController.text,
                      totalProfit: 0.0);
                      businessNotifier.createBusiness(business);
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Register'),
                      ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}