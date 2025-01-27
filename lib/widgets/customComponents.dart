import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final Color backgroundColor;
  final double width;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPasswordField;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.backgroundColor = Colors.grey,
    this.width = 0.45, // Default to half the screen width
    this.validator,
    this.controller,
    this.isPasswordField = false, // Default is not a password field
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
            borderSide: BorderSide.none,
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

class IncomeCards extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final double width;
  final double height;

  const IncomeCards({
    super.key,
    required this.text1,
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
                Icon(Icons.arrow_downward_outlined),
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
  const OrderCard({super.key});

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
                      Text('#7812657',
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
                        child: Text('On Delivery',
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
                        Text('Nairobi, KE'),
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
                        Text('Nakuru, KE'),
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
                      text: 'Kes 5, 765',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(
                            text: ' (6 items)',
                            style: TextStyle(
                              color: Colors.black12,
                            )
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                    child: Text('Details',
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
class LineChartImplementation extends StatelessWidget {
  const LineChartImplementation({super.key});


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: MediaQuery.of(context).size.width * .95,
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
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                  size: 16,
                                  FontAwesomeIcons.chartBar
                              ),
                            ),
                            Text('Revenue Breakdown'),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
                              child: Icon(size: 16, FontAwesomeIcons.filter),
                            ),
                            Text('Filter'),
                          ],
                        ),
                      ),
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
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black12
                              ),
                              children: [
                                TextSpan(
                                  text: '4,650,300',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Icon(
                            color: Colors.red,
                            size: 12.0,
                            FontAwesomeIcons.arrowDown,
                          ),
                        ),
                        Text.rich(
                            TextSpan(
                              text: '39%',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.red,
                              ),
                              children: [
                                TextSpan(
                                    text: ' decrease vs last month',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black12,
                                    )
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * .95,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    verticalInterval: 1,
                    drawHorizontalLine: false,
                    getDrawingVerticalLine: (value) => FlLine(
                      color: Colors.grey.withOpacity(0.5),
                      strokeWidth: 0.5 ,
                    )
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, interval: 500, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                          return Text(
                            months[value.toInt()],
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          );
                        },
                        interval: 1,
                      )
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      right: BorderSide.none,
                      top: BorderSide.none,
                    )
                ),
                lineBarsData: [
                  LineChartBarData(
                      spots: const [
                        FlSpot(0, 1800),
                        FlSpot(1, 2500),
                        FlSpot(3, 2200),
                        FlSpot(4, 3000),
                        FlSpot(5, 2700),
                        FlSpot(6, 3200),
                      ],
                      isCurved: false,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.4),
                        gradient: LinearGradient(
                            colors: [
                              Colors.blue.withOpacity(0.4),
                              Colors.blue.withOpacity(0.0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                        ),
                      )
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
class ProductStoreCard extends StatelessWidget {
  const ProductStoreCard({super.key});

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
                                child: Text('Abomination Perfume',
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
                              text: ' 500',
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
                  child: Text('This is products Description is long.',
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
                          child: Text('76'),
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