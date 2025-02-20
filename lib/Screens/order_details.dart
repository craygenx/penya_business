import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penya_business/models/orders_model.dart';
import 'package:penya_business/providers/order_provider.dart';

class OrderDetails extends ConsumerWidget {
  final String orderId;

  const OrderDetails({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestore = FirebaseFirestore.instance;

    final order = ref.watch(ordersProvider).firstWhere((order) => order.orderId == orderId);
    
    double width = MediaQuery.of(context).size.width;
    List<ProductWithQuantity> productsWithQuantity = [];

    Future<void> getProductsWithQuantity() async{
      // List<Product> products = await order.fetchProducts(firestore);
      // order.copyWith(products: products);
      productsWithQuantity = await order.fetchProducts(firestore);
      
      // for(var product in productWithQuantity){
      //   products.add(product.product);
      // }
    }
    getProductsWithQuantity();
    String totalPriceCalculator( List<ProductWithQuantity> productsWithQuantity){
      double total = 0.0;
      for(var productWithQuantity in productsWithQuantity){
        total += productWithQuantity.product.retailPrice * productWithQuantity.quantity;
      }
      return total.toString();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                          text: '. ${order.status}',
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
                          text: order.orderId,
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
                                child: Text('Nakuru, Ke',
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
              padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
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
                  Text(' (${order.products.length})',
                    style: TextStyle(
                      fontSize: 16.0,
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
              width: width * .95,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .4
              ),
              child: ListView.builder(
                itemCount: productsWithQuantity.length,
                itemBuilder: (context, index) {
                  final product = productsWithQuantity[index].product;
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
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
                                  Text(product.title),
                                  Text.rich(
                                    TextSpan(
                                        text: 'Kes ${product.retailPrice}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' ${productsWithQuantity[index].quantity}',
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
                  );
                },
              ),
            ),
            SizedBox(
              width: width * .95,
              height: 400,
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
                  Container(
                    width: width * .95,
                    constraints: BoxConstraints(
                      maxHeight: 200,
                    ),
                    child: ListView.builder(
                      itemCount: productsWithQuantity.length,
                        itemBuilder: (context, index) {
                          final product = productsWithQuantity[index].product;
                          return SizedBox(
                            width: width * .95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.title,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                Text('Kes ${product.retailPrice}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: width * .95,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('kes ${totalPriceCalculator(productsWithQuantity)}',
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
