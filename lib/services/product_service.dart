import 'package:penya_business/models/product.dart';

import '../models/data.dart';

class ProductService {
  final List<Product> _products = products;
  List<Product> fetchProducts() {
    return _products;
  }

  void addProduct(Product product) {
    _products.add(product);
  }

  void updateProduct(String id, Product updatedProduct) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) _products[index] = updatedProduct;
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
  }
}
