import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * .95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * .45,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            FontAwesomeIcons.basketShopping,
                          ),
                        ),
                        Text('Order Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '24 Jan, 2024',
                      children: [
                        TextSpan(
                          text: '. On delivery',
                          style: TextStyle(
                            color: Colors.green,
                          )
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: width * .95,
                child: SizedBox(
                  width: width * .45,
                  child: Text.rich(
                    TextSpan(
                      text: 'Order ID .',
                      style: TextStyle(
                        color: Colors.black12,
                      ),
                      children: [
                        TextSpan(
                          text: '#7568934',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: width * .95,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SizedBox(
            //         width: 100,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text('Order ID'),
            //             Text('#7812657',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         width: width * .6,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Container(
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.all(Radius.circular(10.0))
            //                 ),
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(right: 10.0),
            //                   child: Text('28 May 2024 .'),
            //                 )
            //             ),
            //             Container(
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.all(Radius.circular(10.0))
            //               ),
            //               child: Text('On Delivery',
            //                 style: TextStyle(
            //                   color: Colors.green,
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0),
            //   child: SizedBox(
            //     width: width * .95,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Container(
            //           width: width * .45,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(10.0))
            //           ),
            //           child: Row(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.only(right: 10.0),
            //                 child: Icon(FontAwesomeIcons.truckFast),
            //               ),
            //               Text('Nairobi, KE'),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           width: width * .45,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(10.0))
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.only(right: 10.0),
            //                 child: Icon(FontAwesomeIcons.locationDot),
            //               ),
            //               Text('Nakuru, KE'),
            //             ],
            //           ),
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              width: width * .95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recipient',
                          style: TextStyle(
                            color: Colors.black12,
                          ),
                        ),
                        Text('John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * .45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery Address',
                          style: TextStyle(
                            color: Colors.black12,
                          ),
                        ),
                        SizedBox(
                          width: width * .45,
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.locationDot),
                              SizedBox(
                                width: 150,
                                child: Text('Nakuru, 564 Kenyatta lane',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('Cart Items',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('2',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              )
              // Text.rich(
              //   TextSpan(
              //     text: 'Items',
              //     style: TextStyle(
              //       fontSize: 18,
              //     ),
              //     children: [
              //       TextSpan(
              //         text: '2',
              //         style: TextStyle(
              //           fontSize: 14,
              //           fontFeatures: [FontFeature.enable('subs')],
              //         )
              //       )
              //     ]
              //   )
              // ),
            ),
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .6
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: SizedBox(
                        width: width * .95,
                        child: Row(
                          children: [
                            Container(
                              color: Colors.black12,
                              width: 80,
                              height: 70,
                              child: Text('hello'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nike Air Rift'),
                                    Text.rich(
                                      TextSpan(
                                        text: 'Kes 3, 500',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' x2',
                                            style: TextStyle(
                                              color: Colors.black12,
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: SizedBox(
                        width: width * .95,
                        child: Row(
                          children: [
                            Container(
                              color: Colors.black12,
                              width: 80,
                              height: 70,
                              child: Text('hello'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nike Air Rift'),
                                    Text.rich(
                                      TextSpan(
                                          text: 'Kes 3, 500',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' x4',
                                              style: TextStyle(
                                                color: Colors.black12,
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: SizedBox(
                        width: width * .95,
                        child: Row(
                          children: [
                            Container(
                              color: Colors.black12,
                              width: 80,
                              height: 70,
                              child: Text('hello'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nike Air Rift'),
                                    Text.rich(
                                      TextSpan(
                                          text: 'Kes 3, 500',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' x1',
                                              style: TextStyle(
                                                color: Colors.black12,
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * .95,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: SizedBox(
                      width: width * .95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * .6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order Summary',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text('Summary of the order breakdown',
                                  style: TextStyle(
                                    color: Colors.black12
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Text('Payment Success',
                              style: TextStyle(
                                color: Colors.green
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * .95,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * .95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Nike Air Rift',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                              Text('Kes 3, 500',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * .95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Adidas Samba',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text('Kes 1, 350',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * .95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Valencia',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text('Kes 800',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * .95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Groceries',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text('Kes 1, 600',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: width * .95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('Kes 3, 500',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
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
