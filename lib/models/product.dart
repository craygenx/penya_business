class Product {
  final String id;
  final String title;

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

  double get conversionRate => checkedOut / views;

  Product({
    required this.views,
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

  Product copyWith(
      {String? title, double? price, int? stock,
        String? category, String? description,
        double? discountPercentage, double? rating,
        int? views, int? addedToCart, int? checkedOut,
        String? brand, String? thumbnail, List<String>? images}) {
    return Product(
        title: title ?? this.title,
        views: views ?? this.views,
        addedToCart: addedToCart ?? this.addedToCart,
        checkedOut: checkedOut ?? this.checkedOut,
        price: price ?? this.price,
        stock: stock ?? this.stock,
        category: category ?? this.category,
        id: id,
        description: description ?? this.description,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        brand: brand ?? this.brand,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
    );
  }
}
