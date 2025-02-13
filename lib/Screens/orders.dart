import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/main.dart';
import 'package:penya_business/providers/order_provider.dart';

import '../providers/orders_dash_provider.dart';
import '../providers/text_controller_notifier.dart';
import '../widgets/customComponents.dart';

class OrdersDash extends ConsumerStatefulWidget {
  const OrdersDash({super.key});

  @override
  ConsumerState<OrdersDash> createState() => _OrdersDashState();
}

class _OrdersDashState extends ConsumerState<OrdersDash> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final orders = ref.watch(ordersProvider.notifier).getFilteredOrders();
    final stats = ref.watch(ordersStatsProvider);
    final overlayEntry = ref.watch(overlayProvider);
    final textEditingController =
        ref.watch(textEditingControllersFamily('orderSearch'));
    // final searchController = TextEditingController();
    // final multiController = ref.read(multiTextControllerProvider.notifier);
    // final searchController = multiController.getController('orderSearch');
    // final filterState = ref.watch(orderFilterProvider);
    // final sortOrderState = ref.watch(sortOrderProvider);

    String currentOrderStatus = ref.watch(orderFilterProvider).value;

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
                children: OrderStatus.values.map((status) {
                  String passedStatus = status.toString().split('.').last;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: 145,
                      color: currentOrderStatus == passedStatus
                          ? Colors.lightBlueAccent
                          : Colors.black26,
                      child: TextButton(
                          onPressed: () {
                            ref.read(orderFilterProvider.notifier).state =
                                status;
                          },
                          child: Text(status.toString().split('.').last)),
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

    final GlobalKey key1 = GlobalKey();
    // final GlobalKey key2 = GlobalKey();

    FocusNode focusNode = ref.watch(searchFocusNodeProvider);
    final isFocused = ref.watch(isSearchFocusedProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>context.pop(), icon: Icon(Icons.arrow_back)),
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
                        Text(
                          'Orders',
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
                          )),
                      child: Text(
                        'view store',
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
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 10.0, bottom: 15.0),
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
                        child: SocialAnalyticsCard(
                          text1: 'Total Orders',
                          text2: '${stats.totalOrders}',
                          text3: '30.5K',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: SocialAnalyticsCard(
                          text1: 'Pending Orders',
                          text2: '${stats.pendingOrders}',
                          text3: '3K',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: SocialAnalyticsCard(
                          text1: 'Cancelled Orders',
                          text2: '${stats.canceledOrders}',
                          text3: '3K',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: SocialAnalyticsCard(
                          text1: 'Delivered Orders',
                          text2: '${stats.deliveredOrders}',
                          text3: '400.4K',
                        ),
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
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        width: width * .5,
                        child: TextField(
                            key: ValueKey('orderSearch'),
                            controller: textEditingController,
                            // multiController.getController('orderSearch'),
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: isFocused ? null : Icon(Icons.search),
                              suffixIcon: isFocused
                                  ? IconButton(
                                      onPressed: () {
                                        textEditingController.clear();
                                        // multiController
                                        //     .getController('orderSearch')
                                        //     .clear();
                                        ref
                                            .read(searchQueryProvider.notifier)
                                            .state = '';
                                      },
                                      icon: Icon(Icons.clear),
                                    )
                                  : Icon(Icons.home),
                            ),
                            onChanged: (value) {
                              ref.watch(searchQueryProvider.notifier).state =
                                  value;
                            },
                            onEditingComplete: () {
                              ref.read(isSearchFocusedProvider.notifier).state =
                                  false;
                              focusNode.unfocus();
                            })
                        // CustomTextFormField(hintText: 'Search...'),
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
                                color: currentOrderStatus == 'all'
                                    ? Colors.blueGrey
                                    : Colors.transparent,
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              'All',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            key: key1,
                            onTap: () {
                              showDropdown(context, key1);
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Icon(FontAwesomeIcons.filter),
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: IconButton(
                              onPressed: () {},
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
                  maxHeight: MediaQuery.of(context).size.height * .6),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: GestureDetector(
                        onTap: () {
                          context.go('/orders/${order.orderId}');
                        },
                        child: OrderCard(
                          orderId: order.orderId,
                          status: order.status,
                          destination: 'Nakuru, KE',
                          siteLocation: 'Nakuru, KE',
                          amount: order.totalAmount,
                          totalItems: order.products.length.toString(),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
