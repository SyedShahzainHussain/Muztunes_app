import 'package:flutter/material.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/common/t_rounded_container.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/model/cart_model.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/view/home/product_rating.dart';
import 'package:muztune/view/home/widget/products/product_image_slider_widget.dart';
import 'package:muztune/view/shop/shop_screen.dart';
import 'package:muztune/viewModel/cart/cart_view_model.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final List<String>? images;
  final String title;
  final String description;
  final List<String> category;
  final List<String> colors;
  final String price;
  final List<String> tags;
  final String? image;
  final bool? isProduct;
  final String? type;
  final String? link;
  final String? information;
  const ProductDetailScreen({
    super.key,
    this.images,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.price,
    required this.productId,
    required this.type,
    required this.link,
    required this.information,
    this.isProduct = true,
    required this.colors,
    this.image,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CartViewModel>()
          .updateAlreadyAddedProductCount(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Process the category data
    List<String> categories = _processCategoryString(widget.category);
    print(widget.colors);
    List<String> colors = _processCategoryString(widget.colors);
    // final testData = [
    //   "Solid colors: 100% Cotton; Heather Grey: 90% Cotton, 10% Polyester; All Other Heathers: 50% Cotton, 50% Polyester",
    //   "Imported",
    //   "Pull On closure",
    //   "Machine Wash",
    //   "Part of the Official Aerosmith Collection by Aerosmith",
    //   "Lightweight, Classic fit, Double-needle sleeve and bottom hem",
    // ];
    // final markDownData = testData.map((x) => "- $x\n").reduce((x, y) => "$x$y");
    return Scaffold(
      // backgroundColor: const Color(0xffF7F3F5),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImageSlider(
              images: widget.images ?? [],
              image: widget.image ?? "",
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                bottom: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TRoundedContainer(
                    radius: 8.0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    backgroundColor: AppColors.redColor,
                    child: Text(
                      "Sale",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    widget.title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "\$22.99",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.lineThrough),
                    ),
                    TextSpan(
                      text: " \$${widget.price}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ])),
                  const SizedBox(
                    height: 10,
                  ),
                  // Markdown(
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         data: markDownData,
                  //         padding: EdgeInsets.zero,
                  //       )
                  (widget.isProduct == true)
                      ? ReadMoreText(
                          widget.description,
                          trimLines: 5,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: " Show more",
                          trimExpandedText: " Less",
                          textAlign: TextAlign.start,
                          moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                          lessStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        )
                      : ReadMoreText(
                          widget.description,
                          trimLines: 5,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: " Show more",
                          trimExpandedText: " Less",
                          textAlign: TextAlign.start,
                          moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                          lessStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: context.screenWidth * .25,
                      child: Button(
                        onTap: () async {
                          final cartItemModel = CartItemModel(
                              type: widget.type!,
                              productId: widget.productId,
                              description: widget.description,
                              title: widget.title,
                              category: widget.category,
                              price: double.parse(widget.price),
                              quantity:
                                  context.read<CartViewModel>().noOfCartItem,
                              image: context
                                  .read<ProductViewModel>()
                                  .selectedImage,
                              tags: widget.tags,
                              images: widget.images ?? [],
                              link: widget.link!);
                          context
                              .read<CartViewModel>()
                              .addToCart(cartItemModel, context);
                          await Utils().launchUrls(widget.link!);
                        },
                        showRadius: true,
                        title: "Buy Now",
                        color: AppColors.redColor,
                        borderColor: AppColors.redColor,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (categories.isNotEmpty)
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: const Color(0xffEEEEED),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Categories: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: const Color(0xff453E3E)),
                              ),
                              ...categories.expand((e) =>
                                  e.split(" ").map((word) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => ShopScreen(
                                                        category: word,
                                                      )));
                                        },
                                        child: Text(
                                          "$word, ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color:
                                                      const Color(0xff2B161B),
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ))),
                            ],
                          )),
                    ),
                  const SizedBox(
                    height: 10,
                  ),

                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffEEEEED),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Tags: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: const Color(0xff453E3E)),
                            ),
                            // Map over the tags list and create a Text widget for each tag
                            ...widget.tags.map((tag) => Padding(
                                  padding: const EdgeInsets.only(
                                      right:
                                          4.0), // Add some spacing between tags
                                  child: Text(
                                    "$tag,",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          color: const Color(0xff2B161B),
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                )),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (colors.isNotEmpty || widget.information != null)
                      ? Text(
                          "Additional information",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      : SizedBox(),
                  if (colors.isNotEmpty)
                    const SizedBox(
                      height: 5,
                    ),
                  if (colors.isNotEmpty)
                    Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Colors",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontWeight: FontWeight.w700)),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: SizedBox(
                                height: 30,
                                width: 3,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: Colors.grey,
                                  endIndent: 1,
                                ),
                              ),
                            ),
                            ...colors.expand((e) =>
                                e.split(" ").map((word) => GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "$word, ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: const Color(0xff2B161B),
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ))),
                          ],
                        )),

                  const SizedBox(
                    height: 10,
                  ),

                 widget.information != null?
                    Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Size",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontWeight: FontWeight.w700)),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: SizedBox(
                                height: 30,
                                width: 3,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: Colors.grey,
                                  endIndent: 1,
                                ),
                              ),
                            ),
                            Text(
                              widget.information ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: const Color(0xff2B161B),
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        )):SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Reviews",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductRating(
                                          type: widget.type!,
                                          productId: widget.productId,
                                        )));
                          },
                          icon: const Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.black))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24 / 2),
        decoration: const BoxDecoration(
          color: Color(0xFF4F4F4F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Button(
          onTap: () async {
            final cartItemModel = CartItemModel(
                type: widget.type!,
                productId: widget.productId,
                description: widget.description,
                title: widget.title,
                category: widget.category,
                price: double.parse(widget.price),
                quantity: context.read<CartViewModel>().noOfCartItem,
                image: context.read<ProductViewModel>().selectedImage,
                tags: widget.tags,
                images: widget.images ?? [],
                link: widget.link!,
                colors: widget.colors);
            context.read<CartViewModel>().addToCart(cartItemModel, context);
            await Utils().launchUrls(widget.link!);
          },
          showRadius: true,
          title: "Buy Now",
          color: AppColors.redColor,
          borderColor: AppColors.redColor,
        ),
      ),
    );
  }

  List<String> _processCategoryString(List<String> categoryList) {
    // Check if there's any data
    if (categoryList.isEmpty) return [];

    // The category data is a single item list with a JSON array string
    final String jsonString = categoryList.first;

    // Remove outer brackets and parse
    final String cleanedString =
        jsonString.replaceAll('[', '').replaceAll(']', '').trim();

    // Split by comma and return as a list
    List<String> categories =
        cleanedString.split(',').map((e) => e.trim()).toList();
    return categories;
  }
}
