// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:penya_business/models/product.dart';
// import 'package:penya_business/providers/store_dash_provider.dart';
// import 'package:penya_business/services/product_service.dart';

// enum StoreProductsStatus {
//   outOfStock,
//   leastPerforming,
//   bestPerforming,
//   groceries,
//   electronics,
//   drinks,
//   all
// }

// extension StoreProductsStatusExtension on StoreProductsStatus {
//   String get value {
//     switch (this) {
//       case StoreProductsStatus.outOfStock:
//         return 'Out of stock';
//       case StoreProductsStatus.leastPerforming:
//         return 'Least performing';
//       case StoreProductsStatus.bestPerforming:
//         return 'Best performing';
//       case StoreProductsStatus.groceries:
//         return 'groceries';
//       case StoreProductsStatus.electronics:
//         return 'electronics';
//       case StoreProductsStatus.drinks:
//         return 'drinks';
//       case StoreProductsStatus.all:
//         return 'all';
//     }
//   }
// }

// final storeFilterProvider =
//     StateProvider<StoreProductsStatus>((ref) => StoreProductsStatus.all);
// final productServiceProvider = Provider((ref) => ProductService());
// final searchQueryProvider = StateProvider<String>((ref) => '');

// final searchFocusNodeProvider = Provider<FocusNode>((ref) {
//   final focusNode = FocusNode();
//   ref.onDispose(focusNode.dispose);
//   return focusNode;
// });
// final isSearchFocusedProvider = StateProvider<bool>((ref) => false);

// final productsProvider =
//     StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
//   final ProductService = ref.read(productServiceProvider);
//   return ProductNotifier(ProductService, ref.read);
// });

// class ProductNotifier extends StateNotifier<List<Product>> {
//   final ProductService _productService;
//   final read;
//   ProductNotifier(this._productService, this.read) : super([]) {
//     loadProducts();
//   }

//   void loadProducts() {
//     state = _productService.fetchProducts();
//   }

//   void addProducts(Product product) {
//     _productService.addProduct(product);
//     loadProducts();
//   }

//   void updateProducts(String id, Product updatedProduct) {
//     _productService.updateProduct(id, updatedProduct);
//     loadProducts();
//   }

//   void deleteProduct(String id) {
//     _productService.deleteProduct(id);
//     loadProducts();
//   }

//   List<Product> getFilteredProducts() {
//     final productsStatus = read(storeFilterProvider);
//     List<Product> filteredProducts = state;
//     final totalProducts = filteredProducts.length;

//     final searchQuery = read(searchQueryProvider)
//         .toString()
//         .split('.')
//         .last
//         .trim()
//         .toLowerCase();
//     // final sortOrder = read(sortOrderProvider);

//     List<ProductPerformance> productz = filteredProducts.map((product) {
//       final views = product.views;
//       final addToCart = product.addedToCart;
//       final checkOuts = product.checkedOut;
//       final score = (views * 2) + (addToCart * 0.3) + (checkOuts * 0.5);

//       return ProductPerformance(
//           views: views,
//           score: score,
//           addedToCart: product.addedToCart,
//           checkedOut: product.checkedOut,
//           description: product.description,
//           discountPercentage: product.discountPercentage,
//           rating: product.rating,
//           brand: product.brand,
//           thumbnail: product.thumbnail,
//           images: product.images,
//           title: product.title,
//           price: product.price,
//           stock: product.stock,
//           category: product.category,
//           id: product.id);
//     }).toList();
//     productz.sort((a, b) => b.score.compareTo(a.score));
//     int bestCutoff = (0.2 * totalProducts).round();
//     int leastCutoff = (0.8 * totalProducts).round();
//     // int bestCount =bestCutoff;
//     // int leastCount = totalProducts - leastCutoff;
//     // int averageCount = totalProducts - (bestCount + leastCount);

//     List<ProductPerformance> bestPerformingProducts =
//         productz.take(bestCutoff).toList();
//     List<ProductPerformance> leastPerformingProducts =
//         productz.skip(leastCutoff).toList();

//     if (productsStatus != StoreProductsStatus.all) {
//       if (productsStatus == StoreProductsStatus.leastPerforming) {
//         filteredProducts = leastPerformingProducts
//             .map((product) => Product(
//                 views: product.views,
//                 addedToCart: product.addedToCart,
//                 checkedOut: product.checkedOut,
//                 description: product.description,
//                 discountPercentage: product.discountPercentage,
//                 rating: product.rating,
//                 brand: product.brand,
//                 thumbnail: product.thumbnail,
//                 images: product.images,
//                 title: product.title,
//                 price: product.price,
//                 stock: product.stock,
//                 category: product.category,
//                 id: product.id))
//             .toList();
//       } else if (productsStatus == StoreProductsStatus.bestPerforming) {
//         filteredProducts = bestPerformingProducts
//             .map((product) => Product(
//                 views: product.views,
//                 addedToCart: product.addedToCart,
//                 checkedOut: product.checkedOut,
//                 description: product.description,
//                 discountPercentage: product.discountPercentage,
//                 rating: product.rating,
//                 brand: product.brand,
//                 thumbnail: product.thumbnail,
//                 images: product.images,
//                 title: product.title,
//                 price: product.price,
//                 stock: product.stock,
//                 category: product.category,
//                 id: product.id))
//             .toList();
//       } else {
//         filteredProducts = filteredProducts
//             .where((product) =>
//                 product.category == productsStatus.toString().split('.').last)
//             .toList();
//       }
//       // filteredProducts = filteredProducts.where((product)=> product.category == productsStatus.toString().split('.').last).toList();
//     }

//     if (searchQuery.isNotEmpty) {
//       List<String> searchTerms =
//           searchQuery.split('&').map((term) => term.trim()).toList();
//       filteredProducts = filteredProducts.where((product) {
//         bool matches = true;
//         for (String term in searchTerms) {
//           if (term.startsWith('<')) {
//             double? amount = double.tryParse(term.substring(1));
//             if (amount != null) {
//               matches &= product.price < amount;
//             }
//           } else if (term.startsWith('>')) {
//             double? amount = double.tryParse(term.substring(1));
//             if (amount != null) {
//               matches &= product.price > amount;
//             }
//           } else if (product.id.toLowerCase().contains(term) ||
//               product.id.toString() == term ||
//               product.price.toString().contains(term)) {
//             matches &= true;
//           } else {
//             matches = false;
//           }
//         }
//         return matches;
//       }).toList();
//     }
//     return filteredProducts;
//   }
// }

// Future<void> addProduct(Product product, WidgetRef ref) async {
//     final firestore = FirebaseFirestore.instance;
//     final imageNotifier = ref.read(imageSelectionProvider.notifier);

//     // Upload images and get URLs
//     List<String> imageUrls = await imageNotifier.uploadImages();

//     // Add product to Firestore with image URLs
//     await firestore.collection('products').doc(product.id).set({
//       ...product.toMap(),
//       'images': imageUrls, // Store image URLs
//     });

//     // Clear selected images after upload
//     ref.read(imageSelectionProvider.notifier).state = [];
//   }

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penya_business/models/product.dart';
import 'package:penya_business/models/product_performance.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/providers/loading_overlay_provider.dart';
import 'package:penya_business/providers/product_image_provider.dart';
import 'package:penya_business/providers/toast_provider.dart';

enum StoreProductsStatus {
  outOfStock,
  leastPerforming,
  bestPerforming,
  groceries,
  electronics,
  drinks,
  all
}

extension StoreProductsStatusExtension on StoreProductsStatus {
  String get value {
    switch (this) {
      case StoreProductsStatus.outOfStock:
        return 'Out of stock';
      case StoreProductsStatus.leastPerforming:
        return 'Least performing';
      case StoreProductsStatus.bestPerforming:
        return 'Best performing';
      case StoreProductsStatus.groceries:
        return 'groceries';
      case StoreProductsStatus.electronics:
        return 'electronics';
      case StoreProductsStatus.drinks:
        return 'drinks';
      case StoreProductsStatus.all:
        return 'all';
    }
  }
}

// Firestore reference for products collection
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final storeFilterProvider =
    StateProvider<StoreProductsStatus>((ref) => StoreProductsStatus.all);

final searchQueryProvider = StateProvider<String>((ref) => '');
final searchFocusNodeProvider = Provider((ref) {
  final focusNode = FocusNode();
  ref.onDispose(focusNode.dispose);
  return focusNode;
});
final isSearchFocusedProvider = StateProvider<bool>((ref) => false);

// Firestore StreamProvider for real-time product updates
final productsProvider = StreamProvider<List<Product>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('products').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  });
});

// Notifier for handling Firestore CRUD operations
class ProductNotifier extends StateNotifier<List<Product>> {
  final FirebaseFirestore _firestore;
  final Ref ref;
  ProductNotifier(this._firestore, this.ref) : super([]) {
    loadProducts();
  }

  void loadProducts() {
    final businessId = ref.watch(businessIdProvider);
    if(businessId.isNotEmpty){
      _firestore.collection('products').where('businessId', isEqualTo: businessId).snapshots().listen((snapshot) {
      state = snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    });
    }else{
      state = [];
    }
  }

  Future<void> addProduct(Product product, WidgetRef ref) async {
    final firestore = FirebaseFirestore.instance;
    ref.read(loadingOverlayProvider.notifier).show();
    // final imageNotifier = ref.read(imageSelectionProvider.notifier);

    // Upload images and get URLs
    // List<String> imageUrls = await imageNotifier.uploadImages();

    // Add product to Firestore with image URLs
    await firestore.collection('products').doc(product.id).set({
      ...product.toMap(),
      'images': [], // Store image URLs
    });
    await firestore.collection('businesses').doc(product.businessId).update({
      'products': FieldValue.arrayUnion([product.id])
    });

    //replace hapo juu
    // 'images': imageUrls,

    // Clear selected images after upload
    ref.read(imageSelectionProvider.notifier).state = [];
    ref.read(toastProvider.notifier).showToast(
        message: 'Product added successfully',
        icon: CupertinoIcons.check_mark_circled_solid);
    ref.read(loadingOverlayProvider.notifier).hide();
  }

  Future<void> updateProduct(String id, Product updatedProduct) async {
    await _firestore
        .collection('products')
        .doc(id)
        .update(updatedProduct.toMap());

  }

  Future<void> deleteProduct(String id) async {
    
    await _firestore.collection('products').doc(id).delete();
  }

  List<Product> getFilteredProducts(WidgetRef ref) {
    final productsStatus = ref.watch(storeFilterProvider);
    List<Product> filteredProducts = state;
    final searchQuery = ref.watch(searchQueryProvider).trim().toLowerCase();

    final totalProducts = filteredProducts.length;
    List<ProductPerformance> productPerformanceList =
        filteredProducts.map((product) {
      final score = (product.views * 2) +
          (product.addedToCart * 0.3) +
          (product.checkedOut * 0.5);
      return ProductPerformance.fromProduct(product, score);
    }).toList();

    productPerformanceList.sort((a, b) => b.score.compareTo(a.score));
    int bestCutoff = (0.2 * totalProducts).round();
    int leastCutoff = (0.8 * totalProducts).round();

    List<Product> bestPerforming = productPerformanceList
        .take(bestCutoff)
        .map((e) => e.toProduct())
        .toList();
    List<Product> leastPerforming = productPerformanceList
        .skip(leastCutoff)
        .map((e) => e.toProduct())
        .toList();

    if (productsStatus != StoreProductsStatus.all) {
      if (productsStatus == StoreProductsStatus.leastPerforming) {
        filteredProducts = leastPerforming;
      } else if (productsStatus == StoreProductsStatus.bestPerforming) {
        filteredProducts = bestPerforming;
      } else {
        filteredProducts = filteredProducts
            .where((product) => product.category == productsStatus.value)
            .toList();
      }
    }

    if (searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts.where((product) {
        return product.title.toLowerCase().contains(searchQuery) ||
            product.category.toLowerCase().contains(searchQuery);
      }).toList();
    }

    return filteredProducts;
  }
}

// Provider for handling product operations
final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ProductNotifier(firestore, ref);
});
