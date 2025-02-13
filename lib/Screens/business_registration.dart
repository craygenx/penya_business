import 'package:flutter/material.dart';

class BusinessRegistration extends StatefulWidget {
  const BusinessRegistration({super.key});

  @override
  State<BusinessRegistration> createState() => _BusinessRegistrationState();
}

class _BusinessRegistrationState extends State<BusinessRegistration> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: width,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_2_outlined,
                      ),
                      SizedBox(
                        width: width * .9,
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
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
                  width: width,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_2_outlined,
                      ),
                      SizedBox(
                        width: width * .9,
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                    ),
                ),
              ]
            ),
          ),
        ],
      )
    );
  }
}