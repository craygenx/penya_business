import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/providers/product_provider.dart';

final storeStatsProvider = Provider<StoreStats>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final totalProducts = productsAsync.value?.length ?? 0;
  List<ProductPerformance> productz = productsAsync.when(
      data: (products) => products.map((product) {
            final views = product.views;
            final addToCart = product.addedToCart;
            final checkOuts = product.checkedOut;
            final score = (views * 2) + (addToCart * 0.3) + (checkOuts * 0.5);

            return ProductPerformance(
                views: views,
                score: score,
                addedToCart: product.addedToCart,
                checkedOut: product.checkedOut,
                description: product.description,
                discountPercentage: product.discountPercentage,
                rating: product.rating,
                brand: product.brand,
                thumbnail: product.thumbnail,
                images: product.images,
                title: product.title,
                price: product.basePrice,
                stock: product.stock,
                category: product.category,
                id: product.id);
          }).toList(),
      error: (error, stackTrace) => [],
      loading: () => []);
  productz.sort((a, b) => b.score.compareTo(a.score));
  int bestCutoff = (0.2 * totalProducts).round();
  int leastCutoff = (0.8 * totalProducts).round();
  int bestCount = bestCutoff;
  int leastCount = totalProducts - leastCutoff;
  int averageCount = totalProducts - (bestCount + leastCount);
  return StoreStats(
      totalProducts: totalProducts,
      leastPerforming: leastCount,
      bestPerforming: bestCount,
      bestPerformingProducts: productz.take(bestCutoff).toList(),
      leastPerformingProducts: productz.skip(leastCutoff).toList(),
      averagePerforming: averageCount);
});

class StoreStats {
  final int totalProducts;
  final int leastPerforming;
  final int bestPerforming;
  final int averagePerforming;
  final List<ProductPerformance> bestPerformingProducts;
  final List<ProductPerformance> leastPerformingProducts;
  StoreStats({
    required this.totalProducts,
    required this.leastPerforming,
    required this.bestPerforming,
    required this.averagePerforming,
    required this.bestPerformingProducts,
    required this.leastPerformingProducts,
  });
}

class ProductPerformance {
  final String id;
  final String title;
  final double score;

  final int views;
  final int addedToCart;
  final int checkedOut;

  final double price;
  final String description;
  final double discountPercentage;
  final double rating;
  final String brand;
  final String thumbnail;
  final List<String> images;
  final int stock;
  final String category;

  ProductPerformance({
    required this.views,
    required this.score,
    required this.addedToCart,
    required this.checkedOut,
    required this.description,
    required this.discountPercentage,
    required this.rating,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.title,
    required this.price,
    required this.stock,
    required this.category,
    required this.id,
  });
}
