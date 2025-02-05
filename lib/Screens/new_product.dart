import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penya_business/providers/product_image_provider.dart';

// import '../providers/product_provider.dart';
import '../widgets/customComponents.dart';

class NewProduct extends ConsumerWidget {
  final String productId;
  const NewProduct({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImages = ref.watch(imageSelectionProvider);
    final imageNotifier = ref.read(imageSelectionProvider.notifier);

    TextEditingController nameEditingController = TextEditingController();
    TextEditingController descriptionEditingController =
        TextEditingController();
    TextEditingController categoryEditingController = TextEditingController();
    TextEditingController basePriceEditingController = TextEditingController();
    TextEditingController stockEditingController = TextEditingController();
    TextEditingController discountEditingController = TextEditingController();
    TextEditingController discountTypeEditingController =
        TextEditingController();

    if (productId.isNotEmpty) {
      // final productAsync = ref.watch(productsProvider);
      final product = [];
      // final product = productAsync.when(
      //   data: (products) =>
      //       products.where((product) => product.id == productId),
      //   error: (error, stackTrace) => [],
      //   loading: () => [],
      // );
      nameEditingController.text = product[0].title;
      descriptionEditingController.text = product.toList()[0].description;
      categoryEditingController.text = product.toList()[0].category;
      basePriceEditingController.text = product.toList()[0].price.toString();
      stockEditingController.text = product.toList()[0].stock.toString();
      discountEditingController.text =
          product.toList()[0].discountPercentage.toString();
      discountTypeEditingController.text = 'Holiday Offer';
    }

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(FontAwesomeIcons.store),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            productId.isNotEmpty
                                ? 'Edit Product'
                                : 'Add New Product',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: productId.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(FontAwesomeIcons.trashCan),
                                )
                              : null,
                        ),
                        Container(
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(FontAwesomeIcons.check),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(productId.isNotEmpty
                                    ? 'Edit Product'
                                    : 'Add Product'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => imageNotifier.pickImages(),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 260,
                        decoration: BoxDecoration(color: Colors.blueGrey),
                        child: selectedImages.isNotEmpty
                            ? Image.file(
                                selectedImages[0],
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.add_a_photo_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(3, (index) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  image: selectedImages.length > index
                                      ? DecorationImage(
                                          image:
                                              FileImage(selectedImages[index]),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: selectedImages.length <= index
                                    ? Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: 40,
                                      )
                                    : null,
                              );
                            })),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                // height: 200,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'General Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Product Name'),
                    ),
                    CustomTextFormField(
                      controller: nameEditingController,
                      hintText: '',
                      width: width,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Product Description'),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                        ),
                        child: TextField(
                            controller: descriptionEditingController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Product Category'),
                    ),
                    CustomTextFormField(
                      controller: categoryEditingController,
                      hintText: '',
                      width: width,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Pricing And Stock',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text('Base Price'),
                                    ),
                                    CustomTextFormField(
                                      controller: basePriceEditingController,
                                      hintText: '0',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text('Stock'),
                                    ),
                                    CustomTextFormField(
                                      controller: stockEditingController,
                                      hintText: '0',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text('Discount'),
                                    ),
                                    CustomTextFormField(
                                      controller: discountEditingController,
                                      hintText: 'e.g 10%',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text('Discount Type'),
                                    ),
                                    CustomTextFormField(
                                      controller: discountTypeEditingController,
                                      hintText: '',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
