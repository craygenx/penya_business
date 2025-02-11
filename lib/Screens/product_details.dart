import 'package:flutter/material.dart';

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
