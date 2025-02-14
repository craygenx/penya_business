import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/providers/dashboard_provider.dart';

import '../widgets/customComponents.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardStatsProvider);
    void showCustomDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Row(
                      children: [
                        Text('Tick Tock'),
                        ElevatedButton(
                            onPressed: (){},
                            child: Text('Add Platform'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Row(
                      children: [
                        Text('Instagram'),
                        ElevatedButton(
                          onPressed: (){},
                          child: Text('Add Platform'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Row(
                      children: [
                        Text('Facebook'),
                        ElevatedButton(
                          onPressed: (){},
                          child: Text('Add Platform'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => context.go('/orders'),
                          child: Text(
                            'Dashboard',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('Nov 3, 2025')
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/business_registration'),
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          Text('Aug 16, 2024-Sep 16, 2024'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 110,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: IncomeCards(
                          text1: 'Total Income',
                          text2: 'Compared to last month.',
                          text3: stats.totalIncome.toStringAsFixed(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: IncomeCards(
                          text1: 'Profit',
                          text2: 'Compared to last month.',
                          text3: '765,573'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: IncomeCards(
                          text1: 'Pending Orders',
                          text2: 'Compared to last month.',
                          text3: '${stats.pendingOrders}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: IncomeCards(
                          text1: 'Conversion Rate',
                          text2: 'Compared to last month.',
                          text3: '${stats.conversionRate.toStringAsFixed(2)}%'),
                    ),
                  ],
                ),
              ),
            ),
            LineChartImplementation(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Platform view',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () => showCustomDialog(context),
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Add platform',
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Icon(FontAwesomeIcons.tiktok),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Tik tok'),
                                      Text(
                                        '90.1k',
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            height: 70,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Icon(FontAwesomeIcons.instagram),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Instagram'),
                                      Text(
                                        '90.1k',
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            height: 70,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Icon(FontAwesomeIcons.facebook),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Facebook'),
                                      Text(
                                        '90.1k',
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            LineChartImplementation(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SocialAnalyticsCard(
                            text1: 'Product viewed 2.9%',
                            text2: '411.2K',
                            text3: '500K'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SocialAnalyticsCard(
                            text1: 'Product shared 13.9%',
                            text2: '230.4K',
                            text3: '115K'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SocialAnalyticsCard(
                            text1: 'Product added to cart 4.3%',
                            text2: '34.6K',
                            text3: '44K'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SocialAnalyticsCard(
                            text1: 'Product checked out 32.2%',
                            text2: '617.7K',
                            text3: '560K'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
