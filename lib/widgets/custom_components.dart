import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:penya_business/main.dart';
import 'package:penya_business/providers/dashboard_provider.dart';
import 'package:penya_business/providers/order_provider.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String? validationKey;
  final Color backgroundColor;
  final bool border;
  final double width;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPasswordField;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.backgroundColor = Colors.grey,
    this.border = false,
    this.width = 0.45, // Default to half the screen width
    this.validator,
    this.controller,
    this.isPasswordField = false,
    this.validationKey, // Default is not a password field
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        key: widget.validationKey != null ? ValueKey(widget.validationKey) : null,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPasswordField ? _isObscured : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black54),
          filled: true,
          fillColor: widget.backgroundColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: widget.border ? const BorderSide(color: Colors.black, width: 2) : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff582ae8), width: 2),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              color: Colors.black54,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}

class BranchCard extends StatelessWidget {
  const BranchCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
      height: 150,
      width: width * .65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
            // Container(
            //   height: 150,
            //   width: 20,
            //   decoration: BoxDecoration(
            //     color: Colors.blueGrey,
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //   ),
            //   child: Center(
            //     child: Text('1',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 20.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
              SizedBox(
                width: width * .65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * .65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('B.id: sest'),
                          Text('Est. Jan 24, 2024'),
                        ],
                      ),
                      
                    ),
                    SizedBox(
                      width: width * .65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        SizedBox(
                          width: width * .4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text('Manager: John Doe'),
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          width: 50,
                        ),
                      ],),
                    ),
                    SizedBox(
                      child: Text('Business Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
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
class IncomeCards extends StatelessWidget {
  final String text1;
  final double currentValue;
  final double previousValue;
  final String text2;
  final String text3;
  final double width;
  final double height;

  const IncomeCards({
    super.key,
    required this.text1,
    required this.currentValue,
    required this.previousValue,
    required this.text2,
    required this.text3,
    this.width = 0.6,
    this.height = 200,
  });
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(currentValue > previousValue ?
                  Icons.arrow_upward_outlined : Icons.
                    arrow_downward_outlined,
                    color:currentValue > previousValue ? Colors.green : Colors.red,
                  ),
                // RichText(),
                Text(text2),
              ],
            ),
          ),
          SizedBox(
            child: Text(
              text3,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
class SocialAnalyticsCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final double width;
  final double height;

  const SocialAnalyticsCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    this.width = 0.7,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text2,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('vs. last month'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(text3,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.black12,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class OrderCard extends StatelessWidget{
  final String orderId;
  final String status;
  final String destination;
  final String siteLocation;
  final String amount;
  final String totalItems;

  const OrderCard({
    super.key, required this.orderId, required this.status, required this.destination, required this.siteLocation, required this.amount, required this.totalItems
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          SizedBox(
            width: width * .95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ID'),
                      Text(orderId,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * .6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text('28 May 2024 .'),
                          )
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Text(status,
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: SizedBox(
              width: width * .95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * .45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(FontAwesomeIcons.truckFast),
                        ),
                        Text(siteLocation),
                      ],
                    ),
                  ),
                  Container(
                    width: width * .45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(FontAwesomeIcons.locationDot),
                        ),
                        Text(destination),
                      ],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Kes $amount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(
                            text: ' ($totalItems items)',
                            style: TextStyle(
                              color: Colors.black12,
                            )
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()=> context.go('/orders/$orderId'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                    child: Text('Details btn',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class LineChartImplementation extends StatelessWidget {
//   final List<FlSpot> spots;
//   final String collectionUnit;
//   final String amount;
//   final String percentageDiff;
//   final double previousAmount;
//   final double currentAmount;
//   const LineChartImplementation({
//     super.key,
//     required this.spots,
//     required this.percentageDiff,
//     required this.currentAmount,
//     required this.previousAmount,
//     required this.collectionUnit,
//     required this.amount});


//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * .95,
//       height: 360,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: width * .45,
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 10.0),
//                               child: Icon(
//                                   size: 16,
//                                   FontAwesomeIcons.chartBar
//                               ),
//                             ),
//                             Text('$collectionUnit Breakdown'),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 0.5,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
//                               child: Icon(size: 16, FontAwesomeIcons.filter),
//                             ),
//                             Text('Filter'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
//                   child: SizedBox(
//                     width: width,
//                     child: Row(
//                       children: [
//                         Text.rich(
//                           TextSpan(
//                               text: 'Kes ',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black12
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: amount,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ]
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Icon(
//                             color:currentAmount > previousAmount ? Colors.green : Colors.red,
//                             size: 12.0,
//                             currentAmount > previousAmount ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
//                           ),
//                         ),
//                         Text.rich(
//                             TextSpan(
//                               text: percentageDiff,
//                               style: TextStyle(
//                                 fontSize: 12.0,
//                                 color: Colors.red,
//                               ),
//                               children: [
//                                 TextSpan(
//                                     text:currentAmount > previousAmount ? 'increase vs last month': ' decrease vs last month',
//                                     style: TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.black12,
//                                     )
//                                 )
//                               ],
//                             )
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 230,
//             width: MediaQuery.of(context).size.width * .95,
//             child: spots.isEmpty ? Center(child: Text('No data available')) : LineChart(
//               LineChartData(
//                 gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: true,
//                     verticalInterval: 1,
//                     drawHorizontalLine: false,
//                     getDrawingVerticalLine: (value) => FlLine(
//                       color: Colors.grey.withValues(alpha: .5),
//                       strokeWidth: 0.5 ,
//                     )
//                 ),
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: true, interval: 500, reservedSize: 40),
//                   ),
//                   bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//                           return Text(
//                             months[value.toInt()],
//                             style: TextStyle(
//                               fontSize: 12.0,
//                             ),
//                           );
//                         },
//                         interval: 1,
//                       )
//                   ),
//                   rightTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: false,
//                     ),
//                   ),
//                   topTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: false,
//                     ),
//                   ),
//                 ),
//                 borderData: FlBorderData(
//                     show: true,
//                     border: Border(
//                       left: BorderSide(
//                         color: Colors.black,
//                         width: 1,
//                       ),
//                       bottom: BorderSide(
//                         color: Colors.black,
//                         width: 1,
//                       ),
//                       right: BorderSide.none,
//                       top: BorderSide.none,
//                     )
//                 ),
//                 lineBarsData: [
//                   LineChartBarData(
//                       spots: spots,
//                       isCurved: false,
//                       color: Colors.blue,
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(
//                         show: true,
//                         color: Colors.blue.withValues(alpha: .4),
//                         gradient: LinearGradient(
//                             colors: [
//                               Colors.blue.withValues(alpha: .4),
//                               Colors.blue.withValues(alpha: .0),
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter
//                         ),
//                       )
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// }
class ProductStoreCard extends StatelessWidget {
  final String title;
  final String description;
  final int stock;
  final double price;
  const ProductStoreCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * .95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width *.7,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * .4,
                                child: Text(title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    Text(' 29.7%',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                    Icon(
                                      color: Colors.green,
                                      size: 12.0,
                                      FontAwesomeIcons.arrowUp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Kes',
                          style: TextStyle(
                            color: Colors.black12,
                            fontSize: 12.0,
                          ),
                          children: [
                            TextSpan(
                              text: price.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * .5,
                  child: Text(
                    description,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
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
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          ),
                          child: Text(stock.toString()),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                          child: Text('Out of Stock',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    color: Colors.black12,
                    width: 130,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter your email";
  }
  // Regular expression for email validation
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return "Enter a valid email address";
  }
  return null; // Valid email
}
String? strongPasswordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter your password";
  }
  if (value.length < 8) {
    return "Password must be at least 8 characters";
  }
  final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
  final hasDigit = RegExp(r'[0-9]').hasMatch(value);
  final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

  if (!hasUppercase || !hasDigit || !hasSpecialChar) {
    return "Password must include an uppercase letter, number, and special character";
  }

  return null; // Valid password
}

String formatDate(DateTime date){
  return DateFormat('MMM d,yyyy').format(date);
}

class LineChartImplementation extends ConsumerWidget {
  final List<FlSpot> spots;
  final String collectionUnit;
  final String amount;
  final String percentageDiff;
  final double previousAmount;
  final double currentAmount;
  final String timeFrame;
  final List<String> xLabels;

  const LineChartImplementation({
    super.key,
    required this.spots,
    required this.percentageDiff,
    required this.currentAmount,
    required this.previousAmount,
    required this.collectionUnit,
    required this.amount,
    required this.timeFrame,
    required this.xLabels,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final overlayEntry = ref.watch(overlayProvider);
    String currentFilter = ref.watch(orderFilterProvider).value;
    final GlobalKey dropdownKey = GlobalKey();

    // Determine min & max Y values
    double minY = spots.isNotEmpty ? spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) : 0;
    double maxY = spots.isNotEmpty ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) : 1;

    // Generate 6 Y-axis labels dynamically
    List<double> yAxisLabels = List.generate(
      6,
      (index) => minY + ((maxY - minY) / 5) * index,
    );

    void showDropdown(BuildContext context, GlobalKey key) {
      final overlayNotifier = ref.watch(overlayProvider.notifier);
      overlayNotifier.state?.remove();
      overlayNotifier.state = null;
      if (overlayEntry != null) {
        return;
      }
      final renderBox = key.currentContext?.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final screenWidth = MediaQuery.of(context).size.width;
      final overlayWidth = 150.0;
      double leftPosition = position.dx;
      if (position.dx + overlayWidth > screenWidth) {
        leftPosition = screenWidth - overlayWidth - 10.0;
      }
      final entry = OverlayEntry(
        builder: (context) => Positioned(
          left: leftPosition,
          top: position.dy + renderBox.size.height,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 150,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: DashboardFilter.values.map((filter) {
                  String passedFilter = filter.toString().split('.').last;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: 145,
                      color: currentFilter == passedFilter
                          ? Colors.lightBlueAccent
                          : Colors.black26,
                      child: TextButton(
                          onPressed: () {
                            ref.read(dashboardFilterProvider.notifier).state =
                                filter;
                          },
                          child: Text(filter.toString().split('.').last)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(entry);
      overlayNotifier.state = entry;
    }

    return SizedBox(
      width: width * .95,
      height: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * .45,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(size: 16, FontAwesomeIcons.chartBar),
                            ),
                            Text('$collectionUnit Breakdown'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>showDropdown(context, dropdownKey),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
                                child: Icon(size: 16, FontAwesomeIcons.filter),
                              ),
                              const Text('Filter'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: SizedBox(
                    width: width,
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Kes ',
                            style: const TextStyle(fontSize: 12, color: Colors.black12),
                            children: [
                              TextSpan(
                                text: amount,
                                style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Icon(
                            color: currentAmount > previousAmount ? Colors.green : Colors.red,
                            size: 12.0,
                            currentAmount > previousAmount ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: percentageDiff,
                            style: const TextStyle(fontSize: 12.0, color: Colors.red),
                            children: [
                              TextSpan(
                                text: currentAmount > previousAmount ? ' increase vs last month' : ' decrease vs last month',
                                style: const TextStyle(fontSize: 12.0, color: Colors.black12),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 230,
            width: width * .95,
            child: spots.isEmpty
                ? const Center(child: Text('No data available'))
                : LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true, drawVerticalLine: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (yAxisLabels.contains(value)) {
                                return Text(getFormattedValue(value), style: const TextStyle(fontSize: 12));
                              }
                              return const SizedBox.shrink();
                            },
                            reservedSize: 50,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 && index < xLabels.length) {
                                return Text(xLabels[index], style: const TextStyle(fontSize: 12));
                              }
                              return const SizedBox.shrink();
                            },
                            interval: (xLabels.length / 6).ceil().toDouble(), // Ensure max 6 labels
                          ),
                        ),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          left: BorderSide(color: Colors.black, width: 1),
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: false,
                          color: Colors.blue,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.blue.withValues(alpha: .4),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// Format numbers with K, M, B notation
  String getFormattedValue(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B'; // 1.2B
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M'; // 1.5M
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K'; // 2.4K
    } else {
      return value.toStringAsFixed(0); // 500
    }
  }
}
