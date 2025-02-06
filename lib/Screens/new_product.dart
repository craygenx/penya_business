import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penya_business/models/product.dart';
import 'package:penya_business/providers/product_image_provider.dart';
import 'package:penya_business/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

// import '../providers/product_provider.dart';
import '../providers/text_controller_notifier.dart';
import '../widgets/customComponents.dart';

class NewProduct extends ConsumerStatefulWidget {
  final String productId;
  const NewProduct({super.key, required this.productId});

  @override
  ConsumerState<NewProduct> createState() => _NewProductState();

}

class _NewProductState extends ConsumerState<NewProduct> {
  @override
  void initState(){
    super.initState();
    Future.microtask((){
      final multiController = ref.read(multiTextControllerProvider.notifier);
      multiController.initController('name');
      multiController.initController('description');
      multiController.initController('category');
      multiController.initController('basePrice');
      multiController.initController('stock');
      multiController.initController('discount');
      multiController.initController('discountType');
    });
  }
  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    final selectedImages = ref.watch(imageSelectionProvider);
    final imageNotifier = ref.read(imageSelectionProvider.notifier);
    final multiController = ref.read(multiTextControllerProvider.notifier);
    if (widget.productId.isNotEmpty) {
      // final productAsync = ref.watch(productsProvider);
      final product = [];
      // final product = productAsync.when(
      //   data: (products) =>
      //       products.where((product) => product.id == productId),
      //   error: (error, stackTrace) => [],
      //   loading: () => [],
      // );

      multiController.updateText('name', product[0].title);
      multiController.updateText('description', product.toList()[0].description);
      multiController.updateText('category', product.toList()[0].category);
      multiController.updateText('basePrice', product.toList()[0].price.toString());
      multiController.updateText('stock', product.toList()[0].stock.toString());
      multiController.updateText('discount', product.toList()[0].discountPercentage.toString());
      multiController.updateText('discountType', 'Holiday Offer');
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
                            widget.productId.isNotEmpty
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
                          child: widget.productId.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(FontAwesomeIcons.trashCan),
                          )
                              : null,
                        ),
                        GestureDetector(
                          onTap: () {
                            final productNew = Product(
                              id: uuid.v1(),
                              title: multiController.getController('name').text,
                              views: 0,
                              addedToCart: 0,
                              checkedOut: 0,
                              price: double.tryParse(
                                  multiController.getController('basePrice').text) ??
                                  0.0,
                              description: multiController.getController('description').text,
                              discountPercentage: double.tryParse(
                                  multiController.getController('discount').text) ??
                                  0.0,
                              rating: 0,
                              brand: 'Johny walker',
                              thumbnail: '',
                              images: [],
                              stock:
                              int.tryParse(multiController.getController('stock').text) ??
                                  0,
                              category: multiController.getController('category').text,);
                            ref
                                .read(productNotifierProvider.notifier)
                                .addProduct(productNew, ref);
                            Navigator.pop(context);
                          },
                          child: Container(
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
                                  child: Text(widget.productId.isNotEmpty
                                      ? 'Edit Product'
                                      : 'Add Product'),
                                ),
                              ],
                            ),
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
                      controller: multiController.getController('name'),
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
                            controller: multiController.getController('description'),
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
                      controller: multiController.getController('category'),
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
                                    controller: multiController.getController('basePrice'),
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
                                    controller: multiController.getController('stock'),
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
                                    controller: multiController.getController('discount'),
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
                                    controller: multiController.getController('discountType'),
                                    hintText: '',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
