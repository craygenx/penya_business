import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String businessId;
  final String title;
  final int views;
  final int addedToCart;
  final int checkedOut;
  final double basePrice;
  final double retailPrice;
  final String description;
  final double discountPercentage;
  final double rating;
  final String brand;
  final String thumbnail;
  final List<String> images;
  final int stock;
  final String category;

  double get conversionRate => checkedOut / views;

  Product({
    required this.id,
    required this.businessId,
    required this.title,
    required this.views,
    required this.addedToCart,
    required this.checkedOut,
    required this.basePrice,
    required this.retailPrice,
    required this.description,
    required this.discountPercentage,
    required this.rating,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.stock,
    required this.category,
  });

  // Convert a Product object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'title': title,
      'views': views,
      'addedToCart': addedToCart,
      'checkedOut': checkedOut,
      'price': basePrice,
      'description': description,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'brand': brand,
      'thumbnail': thumbnail,
      'images': images,
      'stock': stock,
      'category': category,
    };
  }

  // Create a Product object from Firestore data
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Product(
      id: doc.id,
      businessId: data['businessId'] ?? '',
      title: data['title'] ?? '',
      views: data['views'] ?? 0,
      addedToCart: data['addedToCart'] ?? 0,
      checkedOut: data['checkedOut'] ?? 0,
      basePrice: data['price']?.toDouble() ?? 0.0,
      retailPrice: data['retailPrice']?.toDouble() ?? 0.0,
      description: data['description'] ?? '',
      discountPercentage: data['discountPercentage']?.toDouble() ?? 0.0,
      rating: data['rating']?.toDouble() ?? 0.0,
      brand: data['brand'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      stock: data['stock'] ?? 0,
      category: data['category'] ?? '',
    );
  }

  // CopyWith method
  Product copyWith({
    String? id,
    String? businessId,
    String? title,
    int? views,
    int? addedToCart,
    int? checkedOut,
    double? basePrice,
    double? retailPrice,
    String? description,
    double? discountPercentage,
    double? rating,
    String? brand,
    String? thumbnail,
    List<String>? images,
    int? stock,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      title: title ?? this.title,
      views: views ?? this.views,
      addedToCart: addedToCart ?? this.addedToCart,
      checkedOut: checkedOut ?? this.checkedOut,
      basePrice: basePrice ?? this.basePrice,
      retailPrice: retailPrice ?? this.retailPrice,
      description: description ?? this.description,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      brand: brand ?? this.brand,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      stock: stock ?? this.stock,
      category: category ?? this.category,
    );
  }
}
