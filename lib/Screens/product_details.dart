import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> simulateFetch() async {
    await Future.delayed(Duration(seconds: 10));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>context.pop(), icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5, left: 5),
            child: IconButton(onPressed: () => context.push('/orders'), icon: Icon(Icons.shopping_basket)),
            ),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: Stack(
        children: [
          Visibility(
              visible: isLoading,
              replacement: Container(
                color: Colors.black.withValues(alpha: 100, red: 100, green: 100, blue: 100),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              child: Center(
                child: Text('Product details for ID: ${widget.productId}'),
              ),
          )
        ],
      ),
    );
  }
}
