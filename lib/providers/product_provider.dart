import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/models/product.dart';
import 'package:penya_business/services/product_service.dart';

final productServiceProvider = Provider((ref) => ProductService());
final productsProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  final ProductService = ref.read(productServiceProvider);
  return ProductNotifier(ProductService);
});

class ProductNotifier extends StateNotifier<List<Product>> {
  final ProductService _productService;
  ProductNotifier(this._productService) : super([]) {
    loadProducts();
  }

  void loadProducts() {
    state = _productService.fetchProducts();
  }

  void addProducts(Product product) {
    _productService.addProduct(product);
    loadProducts();
  }

  void updateProducts(String id, Product updatedProduct) {
    _productService.updateProduct(id, updatedProduct);
    loadProducts();
  }

  void deleteProduct(String id) {
    _productService.deleteProduct(id);
    loadProducts();
  }
}
