import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/providers/order_provider.dart';

import '../providers/orders_dash_provider.dart';
import '../widgets/customComponents.dart';

class OrdersDash extends ConsumerWidget {
  const OrdersDash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final orders = ref.watch(ordersProvider);
    final stats = ref.watch(ordersStatsProvider);
    return Scaffold(
      appBar: AppBar(),
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
                        Text('Orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () => context.go('/store'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                        child: Text('view store',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                    ),
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 15.0),
                        child: Icon(FontAwesomeIcons.calendar),
                      ),
                      Text('Jan 1 - Jan 30, 2024')
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: SizedBox(
                width: width * .95,
                // height: MediaQuery.of(context).size.height * .3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: SocialAnalyticsCard(text1: 'Total Orders', text2: '${stats.totalOrders}', text3: '30.5K',),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: SocialAnalyticsCard(text1: 'Pending Orders', text2: '${stats.pendingOrders}', text3: '3K',),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: SocialAnalyticsCard(text1: 'Cancelled Orders', text2: '${stats.canceledOrders}', text3: '3K',),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: SocialAnalyticsCard(text1: 'Delivered Orders', text2: '${stats.deliveredOrders}', text3: '400.4K',),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: width * .95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * .5,
                      child: CustomTextFormField(hintText: 'Search...'),
                    ),
                    SizedBox(
                      width: width * .4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: Text('All',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: IconButton(
                              onPressed: (){},
                              icon: Icon(FontAwesomeIcons.filter),
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: IconButton(
                              onPressed: (){},
                              icon: Icon(FontAwesomeIcons.arrowUpWideShort),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .6
              ),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index){
                  final order = orders[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: GestureDetector(
                      onTap: (){
                        print(order.orderId);
                        context.go('/orders/${order.orderId}');
                        },
                        child: OrderCard(orderId: order.orderId, status: order.status, destination: 'Nakuru, KE', siteLocation: 'Nakuru, KE', amount: order.totalAmount, totalItems: order.products.length.toString(),)),
                  );
                },
              ),
            ),
            // SingleChildScrollView(
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            //         child: OrderCard(),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            //         child: OrderCard(),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            //         child: OrderCard(),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            //         child: OrderCard(),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
