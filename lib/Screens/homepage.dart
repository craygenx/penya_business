import 'package:flutter/material.dart';

import '../widgets/customComponents.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('Nov 3, 2025')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined
                        ),
                        Text('Aug 16, 2024-Sep 16, 2024'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: IncomeCards(text1: 'Total Income', text2: 'Compared to last month.', text3: '994,373'),
                    ),
                    IncomeCards(text1: 'Profit', text2: 'Compared to last month.', text3: '765,573'),
                    IncomeCards(text1: 'Pending Orders', text2: 'Compared to last month.', text3: '420'),
                    IncomeCards(text1: 'Conversion Rate', text2: 'Compared to last month.', text3: '4,38%'),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SocialAnalyticsCard(text1: 'Product viewed 2.9%', text2: '411.2K', text3: '500K'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SocialAnalyticsCard(text1: 'Product shared 13.9%', text2: '230.4K', text3: '115K'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SocialAnalyticsCard(text1: 'Product added to cart 4.3%', text2: '34.6K', text3: '44K'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SocialAnalyticsCard(text1: 'Product checked out 32.2%', text2: '617.7K', text3: '560K'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('Platform view',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                              child: Text('Add platform'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Text('Tik tok'),
                                      Text('90.1k',
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
                            height: 150,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Text('Instagram'),
                                      Text('90.1k',
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
                            height: 150,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Text('Facebook'
                                          ''),
                                      Text('90.1k',
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
          ],
        ),
      ),
    );
  }
}
