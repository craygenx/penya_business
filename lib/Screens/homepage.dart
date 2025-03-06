import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/models/branch_model.dart';
// import 'package:penya_business/models/branch_model.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/providers/business_provider.dart';
import 'package:penya_business/providers/dashboard_provider.dart';
import 'package:penya_business/providers/orders_dash_provider.dart';
import 'package:penya_business/providers/social_auth_provider.dart';

import '../widgets/custom_components.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    bool switchValue = true;

    String today = formatDate(DateTime.now());
    final statsProvider = ref.watch(dashboardStatsProvider);
    final statsOrders = ref.watch(ordersStatsProvider);
    final socialAuthService = ref.read(socialAuthProvider);
    final authState = ref.watch(authProvider);
    final businessState = ref.watch(businessProvider);
    // final business = ref.read(businessProvider.notifier);
    TextEditingController ownerNameController = TextEditingController();
    TextEditingController ownerEmailController = TextEditingController();
    String uid = authState.value?.id ?? '';
    
    Future<List<Branch>> branches = businessState.value!.getBranches(businessState.value!.branches);

    ownerNameController.text = authState.value?.displayName ?? '';
    ownerEmailController.text = authState.value?.email ?? '';
    double width = MediaQuery.of(context).size.width;

    List<String> getXLabels(String timeFrame, List<FlSpot> spots) {
      if (timeFrame == "daily") {
        return spots.map((e) => "${(e.x).toInt()}:00 AM").toList();
      } else if (timeFrame == "weekly") {
        return List.generate(spots.length, (index) => "Wk${index + 1}");
      } else {
        return ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
      }
    }

    final stats = statsProvider.when(
      data: (data) => data,
      error: (error, stackTrace) => DashboardStats(
        totalIncome: 0.0,
        totalProfit: 0.0,
        incomeChartData: [],
        profitChartData: [],
        previousIncome: 0.0,
        previousProfit: 0.0,
        incomeChangePercentage: 0.0,
        profitChangePercentage: 0.0,
        timeFrameLabel: 'Today',
      ),
      loading: () => DashboardStats(
        totalIncome: 0.0,
        totalProfit: 0.0,
        incomeChartData: [],
        profitChartData: [],
        previousIncome: 0.0,
        previousProfit: 0.0,
        incomeChangePercentage: 0.0,
        profitChangePercentage: 0.0,
        timeFrameLabel: 'Today',
      ),
    );

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
                            onPressed: () {
                              socialAuthService.authenticateWithTiktok(uid);
                            },
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
                            onPressed: () {
                              context.go('/business_registration');
                            },
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
                            onPressed: () {
                              context.go('/');
                            },
                            child: Text('Add Platform'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }

    void showBottomSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: (BuildContext context) {
            return ListView(
              children: [
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * .95,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Branch name'),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            SizedBox(
                                width: width * .95,
                                child: CustomTextFormField(
                                  hintText: "Enter bussiness name",
                                  backgroundColor: Colors.white,
                                  border: true,
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            Text('Branch email'),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            SizedBox(
                                width: width * .95,
                                child: CustomTextFormField(
                                  hintText: "Enter bussiness name",
                                  backgroundColor: Colors.white,
                                  border: true,
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            Text('Branch phone number'),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            SizedBox(
                                width: width * .95,
                                child: CustomTextFormField(
                                  hintText: "Enter bussiness name",
                                  backgroundColor: Colors.white,
                                  border: true,
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Branch management'),
                                  Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.lightBlueAccent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Icon(Icons.web_outlined),
                                          ),
                                          SizedBox(
                                            width: width * .5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Manager'),
                                                Text('Assign branch manager'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            child: Switch(
                                              value: switchValue,
                                              onChanged: (bool newValue) {
                                                switchValue = newValue;
                                              },
                                              activeColor: Colors.blue,
                                              inactiveThumbColor: Colors.grey,
                                              inactiveTrackColor:
                                                  Colors.grey[300],
                                              activeTrackColor:
                                                  Colors.blue[200],
                                            ),
                                          )
                                        ],
                                      )),
                                  Visibility(
                                    visible: switchValue,
                                    child: SizedBox(
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Invite'),
                                          Container(
                                            width: width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all()),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons
                                                    .person_add_alt_1_outlined),
                                                SizedBox(
                                                    width: width * .59,
                                                    child: CustomTextFormField(
                                                      hintText:
                                                          "Enter bussiness name",
                                                      backgroundColor:
                                                          Colors.white,
                                                      border: false,
                                                    )),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.send),
                                                      Text(
                                                        ' Invite',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20)),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blueGrey,
                                                      shape: BoxShape.circle),
                                                ),
                                                SizedBox(
                                                  width: width * .5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('John Doe'),
                                                      Text('Johndoe@gmail.com'),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Text('Remove',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
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
                    ],
                  ),
                )
              ],
            );
          });
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ],
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            SizedBox(
              height: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  Hi, ${authState.value?.displayName ?? ''}',
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '  Dashboard',
                    style: TextStyle(fontSize: 13, color: Colors.black12),
                  )
                ],
              ),
            )
          ],
        ),
        actions: [
          SizedBox(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: IconButton(
                      onPressed: () => context.push('/orders'),
                      icon: Icon(Icons.shopping_basket)),
                ),
                IconButton(
                    onPressed: () => context.push('/business_registration'),
                    icon: Icon(Icons.notifications)),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width * .7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    width: width * .7,
                    height: 120,
                    decoration: BoxDecoration(
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
                            width: width * .7,
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
                                  width: width * .55,
                                  child: TextField(
                                    controller: ownerNameController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.5),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * .7,
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
                                  width: width * .55,
                                  child: TextField(
                                    controller: ownerEmailController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Visibility(
                    visible: authState.value?.roles.contains('owner') ?? false,
                    child: SizedBox(
                      width: width * .7,
                      child: Text(
                        'Registered Branches',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  // Visibility(
                  //   visible: authState.value?.roles.contains('owner') ?? false,
                  //   child: SizedBox(
                  //     width: width * .7,
                  //     height: 160,
                  //     child: businessState.value?.branches.isNotEmpty ?? false
                  //         ? Text('No registered branches')
                  //         : FutureBuilder<List<Branch>>(
                  //             future: branches,
                  //             builder: (context, snapshot) {
                  //               if (snapshot.connectionState ==
                  //                   ConnectionState.waiting) {
                  //                 return CircularProgressIndicator();
                  //               } else if (snapshot.hasError) {
                  //                 return Text('Error: ${snapshot.error}');
                  //               } else {
                  //                 return ListView.builder(
                  //                     scrollDirection: Axis.horizontal,
                  //                     itemCount: snapshot.data?.length ?? 0,
                  //                     itemBuilder: (context, index) {
                  //                       // final branch = snapshot.data?[index];
                  //                       return BranchCard();
                  //                     });
                  //               }
                  //             }),
                  //   ),
                  // ),
                  Visibility(
                    visible: authState.value?.roles.contains('owner') ?? false,
                    child: SizedBox(
                      width: width * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showBottomSheet(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.add),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text('Register Branch'),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        Text('  Settings'),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        Text(
                          '  Log out',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('App Version 1.0.0'),
          ],
        ),
      ),
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
                        Text(today)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/business_registration'),
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          Text(stats.timeFrameLabel == 'Today'
                              ? today
                              : stats.timeFrameLabel),
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
                        text3: stats.totalIncome.toStringAsFixed(2),
                        currentValue: 0.0,
                        previousValue: 0.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: IncomeCards(
                          text1: 'Profit',
                          text2: 'Compared to last month.',
                          currentValue: 0.0,
                          previousValue: 0.0,
                          text3: stats.totalProfit.toStringAsFixed(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: IncomeCards(
                          text1: 'Pending Orders',
                          text2: 'Compared to last month.',
                          currentValue: 0.0,
                          previousValue: 0.0,
                          text3: '${statsOrders.pendingOrders}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                      child: IncomeCards(
                          text1: 'Conversion Rate',
                          text2: 'Compared to last month.',
                          currentValue: 0.0,
                          previousValue: 0.0,
                          text3: '0.0%'),
                    ),
                  ],
                ),
              ),
            ),
            // LineChartImplementation(
            //   spots: stats.incomeChartData,
            //   collectionUnit: 'Revenue',
            //   currentAmount: stats.totalIncome,
            //   previousAmount: stats.previousIncome,
            //   percentageDiff: stats.incomeChangePercentage.toStringAsFixed(1),
            //   amount: stats.totalIncome.toStringAsFixed(2),),
            LineChartImplementation(
              spots: stats.incomeChartData,
              collectionUnit: 'Revenue',
              currentAmount: stats.totalIncome,
              previousAmount: stats.previousIncome,
              percentageDiff: stats.incomeChangePercentage.toStringAsFixed(1),
              amount: stats.totalIncome.toStringAsFixed(2),
              timeFrame: "daily", // Pass "weekly" or "monthly" as needed
              xLabels: getXLabels("daily", stats.incomeChartData),
            ),
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
            // LineChartImplementation(
            //   spots: [],
            //   currentAmount: 0.0,
            //   previousAmount: 0.0,
            //   percentageDiff: '0.0',
            //   collectionUnit: 'Socials',
            //   amount: '',),
            LineChartImplementation(
              spots: [],
              collectionUnit: 'Socials',
              currentAmount: 0.0,
              previousAmount: 0.0,
              percentageDiff: '0.0',
              amount: '0.0',
              timeFrame: "daily", // Pass "weekly" or "monthly" as needed
              xLabels: [],
            ),
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
