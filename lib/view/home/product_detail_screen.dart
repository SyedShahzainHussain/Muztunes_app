import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muztunes_apps/common/button.dart';
import 'package:muztunes_apps/common/t_circular_icon.dart';
import 'package:muztunes_apps/common/t_rounded_container.dart';
import 'package:muztunes_apps/config/colors.dart';
import 'package:muztunes_apps/extension/flushbar_extension.dart';
import 'package:muztunes_apps/extension/media_query_extension.dart';
import 'package:muztunes_apps/model/cart_model.dart';
import 'package:muztunes_apps/model/product_model.dart';
import 'package:muztunes_apps/view/home/product_rating.dart';
import 'package:muztunes_apps/view/home/widget/products/product_image_slider_widget.dart';
import 'package:muztunes_apps/viewModel/cart/cart_view_model.dart';
import 'package:muztunes_apps/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final List<Images> images;
  final String title;
  final String description;
  final String category;
  final String price;
  final List<String> tags;
  const ProductDetailScreen({
    super.key,
    required this.images,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.price,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final testData = [
      "Solid colors: 100% Cotton; Heather Grey: 90% Cotton, 10% Polyester; All Other Heathers: 50% Cotton, 50% Polyester",
      "Imported",
      "Pull On closure",
      "Machine Wash",
      "Part of the Official Aerosmith Collection by Aerosmith",
      "Lightweight, Classic fit, Double-needle sleeve and bottom hem",
    ];
    final markDownData = testData.map((x) => "- $x\n").reduce((x, y) => "$x$y");
    return Scaffold(
      // backgroundColor: const Color(0xffF7F3F5),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImageSlider(
              images: images,
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
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
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
                      text: " \$$price",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ])),
                  const SizedBox(
                    height: 10,
                  ),
                  Markdown(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    data: markDownData,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: context.screenWidth * .25,
                      child: Button(
                        onTap: () {
                          if (context.read<CartViewModel>().noOfCartItem == 0) {
                            context.flushBarSuccessMessage(
                                message: "Selected the quantity");
                          } else {
                            final cartItemModel = CartItemModel(
                              productId: productId,
                              description: description,
                              title: title,
                              category: category,
                              price: double.parse(price),
                              quantity:
                                  context.read<CartViewModel>().noOfCartItem,
                              image: context
                                  .read<ProductViewModel>()
                                  .selectedImage,
                              tags: tags,
                            );
                            context
                                .read<CartViewModel>()
                                .addToCart(cartItemModel, context);
                          }
                        },
                        showRadius: true,
                        title: "Add To Cart",
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
                            Text(
                              category,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: const Color(0xff2B161B),
                                      fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   " T-Shirts,",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .labelSmall!
                            //       .copyWith(
                            //           color: const Color(0xff2B161B),
                            //           fontWeight: FontWeight.bold),
                            // ),
                            // Text(
                            //   " Shoes",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .labelSmall!
                            //       .copyWith(
                            //           color: const Color(0xff2B161B),
                            //           fontWeight: FontWeight.bold),
                            // ),
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
                            ...tags.map((tag) => Padding(
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
                  Text("Additional information",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(
                    height: 5,
                  ),
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
                        Text("size",
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
                        const Text("L, M, XL, S"),
                      ],
                    ),
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
                      Text("Reviews (12)",
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
                                    builder: (_) => const ProductRating()));
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularIcons(
                  icon: Iconsax.minus,
                  backgroundColor: AppColors.redColor,
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  onPressed: () {
                    context.read<CartViewModel>().decreaseCount();
                  },
                ),
                const SizedBox(
                  width: 12,
                ),
                Consumer<CartViewModel>(
                  builder: (context, data, _) => Text(
                    data.noOfCartItem.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                TCircularIcons(
                    icon: Iconsax.add,
                    backgroundColor: AppColors.redColor,
                    width: 40,
                    height: 40,
                    color: Colors.white,
                    onPressed: () {
                      context.read<CartViewModel>().increaseCount();
                    }),
              ],
            ),
            Button(
              onTap: () {
                if (context.read<CartViewModel>().noOfCartItem == 0) {
                  context.flushBarSuccessMessage(
                      message: "Selected the quantity");
                } else {
                  final cartItemModel = CartItemModel(
                    productId: productId,
                    description: description,
                    quantity: context.read<CartViewModel>().noOfCartItem,
                    image: context.read<ProductViewModel>().selectedImage,
                    tags: tags,
                    title: title,
                    category: category,
                    price: double.parse(price),
                  );
                  context
                      .read<CartViewModel>()
                      .addToCart(cartItemModel, context);
                }
              },
              showRadius: true,
              title: "Add To Cart",
              color: AppColors.redColor,
              borderColor: AppColors.redColor,
            ),
          ],
        ),
      ),
    );
  }
}
