import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/models/product.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/providers/product_image_provider.dart';
import 'package:penya_business/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

// import '../providers/product_provider.dart';
import '../providers/text_controller_notifier.dart';
import '../widgets/custom_components.dart';

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
    final nameEditingController = ref.watch(textEditingControllersFamily('name'));
    final descriptionEditingController = ref.watch(textEditingControllersFamily('description'));
    final categoryEditingController = ref.watch(textEditingControllersFamily('category'));
    final basePriceEditingController = ref.watch(textEditingControllersFamily('basePrice'));
    final stockEditingController = ref.watch(textEditingControllersFamily('stock'));
    final discountEditingController = ref.watch(textEditingControllersFamily('discount'));
    final discountTypeEditingController = ref.watch(textEditingControllersFamily('discountType'));
    final authState = ref.watch(authProvider);
    if (widget.productId.isNotEmpty) {
      final productAsync = ref.watch(productsProvider);
      
      // final String userId = authState.value?.id ?? '';

      final productList = productAsync.when(
        data: (products) => products.where((product) => product.id == widget.productId).toList(), // Convert to List<Product>
        error: (error, stackTrace) => [],
        loading: () => [],
      );

      if (productList.isNotEmpty) {
        final product = productList.first; // Get the first element safely

        nameEditingController.text = product.title;
        descriptionEditingController.text = product.description;
        categoryEditingController.text = product.category;
        basePriceEditingController.text = product.price.toString();
        stockEditingController.text = product.stock.toString();
        discountEditingController.text = product.discountPercentage.toString();
        discountTypeEditingController.text = 'Holiday Offer';
      }
    }


    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> context.pop(),
         icon: Icon(FontAwesomeIcons.arrowLeft),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5, left: 5),
            child: IconButton(onPressed: () => context.push('/orders'), icon: Icon(Icons.shopping_basket)),
            ),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
        ],
      ),
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
                        Visibility(
                          visible: widget.productId.isNotEmpty,
                          child: GestureDetector(
                            onTap: (){
                              ref
                                  .read(productNotifierProvider.notifier)
                                  .deleteProduct(widget.productId);
                              context.pop();
                            },
                              child: Container(
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
                            )
                          ),
                        
                        GestureDetector(
                          onTap: () {
                            final productNew = Product(
                              id: widget.productId.isNotEmpty
                                  ? widget.productId
                                  : uuid.v4(),
                              businessId: authState.value?.businessId ?? '',
                              title: nameEditingController.text,
                              views: 0,
                              addedToCart: 0,
                              checkedOut: 0,
                              basePrice: double.tryParse(
                                  basePriceEditingController.text) ??
                                  0.0,
                              retailPrice: 0.0,
                              description: descriptionEditingController.text,
                              discountPercentage: double.tryParse(
                                  discountEditingController.text) ??
                                  0.0,
                              rating: 0,
                              brand: 'Johny walker',
                              thumbnail: '',
                              images: [],
                              stock:
                              int.tryParse(stockEditingController.text) ??
                                  0,
                              category: categoryEditingController.text,);
                            if (widget.productId.isNotEmpty) {
                              ref
                                  .read(productNotifierProvider.notifier)
                                  .updateProduct(widget.productId, productNew);
                              context.pop();
                            } else{
                              ref
                                  .read(productNotifierProvider.notifier)
                                  .addProduct(productNew, ref);
                              context.pop();
                            }
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
                      validationKey: 'name',
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
                            key: ValueKey('description'),
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
                      validationKey: 'category',
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
                                    validationKey: 'basePrice',
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
                                    validationKey: 'stock',
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
                                    validationKey: 'discount',
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
                                    validationKey: 'discountType',
                                    controller: discountTypeEditingController,
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
