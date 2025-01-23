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
          ],
        ),
      ),
    );
  }
}
