import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/main.dart';
import 'package:penya_business/providers/product_provider.dart';
import 'package:penya_business/widgets/customComponents.dart';

import '../providers/store_dash_provider.dart';

class Store extends ConsumerWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider.notifier).getFilteredProducts();
    final stats = ref.watch(storeStatsProvider);
    final searchController = TextEditingController();
    final overlayEntry = ref.watch(storeOverlayProvider);
    String currentProductsStatus = ref.watch(storeFilterProvider).value;

    FocusNode focusNode = ref.read(searchFocusNodeProvider);
    final isFocused = ref.read(isSearchFocusedProvider);

    final GlobalKey key1 = GlobalKey();


    void showDropdown(BuildContext context, GlobalKey key) {
      final overlayNotifier = ref.watch(storeOverlayProvider.notifier);
      overlayNotifier.state?.remove();
      overlayNotifier.state = null;
      if(overlayEntry != null){
        return;
      }
      final renderBox = key.currentContext?.findRenderObject()
      as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final screenWidth = MediaQuery.of(context).size.width;
      final overlayWidth = 150.0;
      double leftPosition = position.dx;
      if(position.dx + overlayWidth > screenWidth){
        leftPosition = screenWidth - overlayWidth - 10.0;
      }
      final entry =OverlayEntry(
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
                children:
                StoreProductsStatus.values.map((status){
                  String passedStatus = status.toString().split('.').last;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: 145,
                      color: currentProductsStatus == passedStatus ? Colors.lightBlueAccent : Colors.black26,
                      child: TextButton(
                          onPressed: (){
                            ref.watch(storeFilterProvider.notifier).state = status;
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

    double width = MediaQuery.of(context).size.width;
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
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  FontAwesomeIcons.store,
                                  size: 22.0,
                                ),
                              ),
                              Text(
                                'Store',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('200 Items',
                          style: TextStyle(
                            color: Colors.black12
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    width: 240,
                    child: TextField(
                        controller: searchController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: isFocused ? null : Icon(Icons.search),
                          suffixIcon: isFocused ? IconButton(
                            onPressed: (){
                              searchController.clear();
                              ref.read(searchQueryProvider.notifier).state = '';
                            },
                            icon: Icon(Icons.clear),
                          ) : null,
                        ),
                        onChanged: (value){
                          ref.read(searchQueryProvider.notifier).state = value;
                        },
                        onEditingComplete: (){
                          ref.read(isSearchFocusedProvider.notifier).state = false;
                          focusNode.unfocus();
                        }
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: SizedBox(
                width: width * .95,
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SocialAnalyticsCard(text1: 'Total products 2.9%', text2: '${stats.totalProducts}', text3: '0'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SocialAnalyticsCard(text1: 'Best performing 2.9%', text2: '${stats.bestPerforming}', text3: '0'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SocialAnalyticsCard(text1: 'Least performing 2.9%', text2: '${stats.leastPerforming}', text3: '0'),
                      ),
                    ],
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
                    width: width * .6,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                ref.read(storeFilterProvider.notifier).state = StoreProductsStatus.all;
                              },
                              child: Container(
                                decoration: currentProductsStatus == 'all' ? BoxDecoration(
                                  color: Colors.black26,
                                  border: Border.all(
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ) : null,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                                  child: Text('All'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                ref.read(storeFilterProvider.notifier).state = StoreProductsStatus.groceries;
                              },
                              child: Container(
                                  decoration: currentProductsStatus == 'groceries' ? BoxDecoration(
                                    color: Colors.black26,
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ) : null,
                                child: Text('Groceries'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                ref.read(storeFilterProvider.notifier).state = StoreProductsStatus.electronics;
                              },
                              child: Container(
                                decoration: currentProductsStatus == 'electronics' ? BoxDecoration(
                                    color: Colors.black26,
                                    border: Border.all(
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ) : null,
                                child: Text('Electronics'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                ref.read(storeFilterProvider.notifier).state = StoreProductsStatus.all;
                              },
                              child: Container(
                                decoration: currentProductsStatus == 'drinks' ? BoxDecoration(
                                    color: Colors.black26,
                                    border: Border.all(
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ) : null,
                                child: Text('Drinks'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    key: key1,
                    onTap: () {
                      showDropdown(context, key1);
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * .95,
              height: MediaQuery.of(context).size.height * .8,
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                    child: GestureDetector(
                      onTap: ()=> context.go('/product/${product.id}'),
                        child: ProductStoreCard(title: product.title, description: product.description, price: product.price, stock: product.stock,)),
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
