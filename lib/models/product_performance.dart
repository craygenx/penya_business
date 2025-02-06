import 'package:penya_business/models/product.dart';

class ProductPerformance {
  final String id;
  final String title;
  final int views;
  final int addedToCart;
  final int checkedOut;
  final double price;
  final double score;
  final String description;
  final double discountPercentage;
  final double rating;
  final String brand;
  final String thumbnail;
  final List<String> images;
  final int stock;
  final String category;

  double get conversionRate => checkedOut / views;

  ProductPerformance({
    required this.id,
    required this.title,
    required this.views,
    required this.addedToCart,
    required this.checkedOut,
    required this.price,
    required this.score,
    required this.description,
    required this.discountPercentage,
    required this.rating,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.stock,
    required this.category,
  });

  factory ProductPerformance.fromProduct(Product product, double score) {
    return ProductPerformance(
        id: product.id,
        title: product.title,
        views: product.views,
        addedToCart: product.addedToCart,
        checkedOut: product.checkedOut,
        price: product.price,
        score: score,
        description: product.description,
        discountPercentage: product.discountPercentage,
        rating: product.rating,
        brand: product.brand,
        thumbnail: product.thumbnail,
        images: product.images,
        stock: product.stock,
        category: product.category);
  }
  Product toProduct() {
    return Product(
        id: id,
        title: title,
        views: views,
        addedToCart: addedToCart,
        checkedOut: checkedOut,
        price: price,
        description: description,
        discountPercentage: discountPercentage,
        rating: rating,
        brand: brand,
        thumbnail: thumbnail,
        images: images,
        stock: stock,
        category: category);
  }
}
