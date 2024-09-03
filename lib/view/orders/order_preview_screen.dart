import 'package:flutter/material.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/model/order_model.dart';

class OrderPreviewScreen extends StatelessWidget {
  final OrderModel orderModel;
  const OrderPreviewScreen({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          Button(
            onTap: () {
              Navigator.pop(context);
            },
            title: "Ok, got it.",
            color: AppColors.redColor,
            titleColor: Colors.white,
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: context.screenHeight * 0.2,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:
                                  const Icon(Icons.close, color: Colors.black)),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(orderModel.orderStatus!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: Colors.black))),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                  "Order By: ${orderModel.orderby!.name}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black))),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SelectableText(
                                  "Order Id: ${orderModel.sId}",
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey))),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = orderModel.products![index];
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    product.product?.images?[0] ??
                                        product.article!.image!,
                                    width: 70,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            product.product?.title ??
                                                product.article!.title!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Text(
                                            "\$${product.product?.price?.toStringAsFixed(2) ?? product.article!.price!.toStringAsFixed(2)}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            product.product?.category ??
                                                product.article!.category!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                        Text(
                                            "X ${product.product?.quantity ?? product.article!.quantity!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                      ],
                                    ),
                                    Text(
                                        product.product?.description ??
                                            product.article!.description!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w700))
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: orderModel.products!.length,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                          Text(
                              "\$${orderModel.paymentIntent?.amount.toString()}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
