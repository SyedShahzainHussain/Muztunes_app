import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muztune/common/t_rounded_container.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/view/admin/viewmodel/create_product_view_model.dart';
import 'package:provider/provider.dart';

class GetAllAdminOrderScreen extends StatefulWidget {
  const GetAllAdminOrderScreen({super.key});

  @override
  State<GetAllAdminOrderScreen> createState() => _GetAllAdminOrderScreenState();
}

class _GetAllAdminOrderScreenState extends State<GetAllAdminOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CreateProductViewModel>().getAllAdminOrders();
    });
  }

  List<String> type = [
    "Not Processed",
    "Cash on Delivery",
    "Processing",
    "Dispatched",
    "Cancelled",
    "Delivered",
  ];

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "Orders",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<CreateProductViewModel>().getAllAdminOrders();
          },
          child: Consumer<CreateProductViewModel>(builder: (context, data, _) {
            switch (data.getOrderList.status) {
              case Status.LOADING:
                return const Center(
                  child: TRoundedContainer(
                    padding: EdgeInsets.all(12),
                    width: 50,
                    height: 50,
                    backgroundColor: AppColors.redColor,
                    showBorder: true,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 3.0,
                    ),
                  ),
                );
              case Status.COMPLETED:
                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: data.getOrderList.data!.isEmpty
                        ? const Center(child: Text("No Order Found"))
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 16.0,
                                ),
                            itemCount: data.getOrderList.data!.length,
                            itemBuilder: (context, index) {
                              final orders = data.getOrderList.data![index];
                              return TRoundedContainer(
                                showBorder: true,
                                backgroundColor: const Color(0xFFF6F6F6),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // ! Row -> 1
                                    Row(
                                      children: [
                                        // ! Icon
                                        const Icon(Iconsax.ship),
                                        const SizedBox(
                                          width: 16.0 / 2,
                                        ),
                                        // !  2 -  Status & Date
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                orders.orderStatus!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .apply(
                                                      color: AppColors.redColor,
                                                      fontWeightDelta: 1,
                                                    ),
                                              ),
                                              Text(
                                                orders.orderby!.name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                                maxLines: 1,
                                              )
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: const Text(
                                                        "Are you sure?"),
                                                    content: const Text(
                                                        "Do you really want to delete this order? This action cannot be undone."),
                                                    actions: [
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .black),
                                                        child: const Text(
                                                            "Cancel"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                      ),
                                                      Consumer<
                                                          CreateProductViewModel>(
                                                        builder: (context, data,
                                                                _) =>
                                                            TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .red),
                                                          child: data
                                                                  .orderDeleteLoading
                                                              ? const SpinKitFadingCircle(
                                                                  color: AppColors
                                                                      .redColor,
                                                                  size: 20)
                                                              : const Text(
                                                                  "Delete"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            // Schedule the deletion after the current frame is rendered
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              context
                                                                  .read<
                                                                      CreateProductViewModel>()
                                                                  .deleteOrderTypeApi(
                                                                      orders
                                                                          .sId!)
                                                                  .then((_) {
                                                                if (context
                                                                    .mounted) {
                                                                  context
                                                                      .read<
                                                                          CreateProductViewModel>()
                                                                      .getAllAdminOrders();
                                                                }
                                                              }).catchError(
                                                                      (error) {
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); // Close the dialog
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text("Failed to delete order: $error")),
                                                                  );
                                                                }
                                                              });
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red)),
                                        // ! 3 - Icon
                                        PopupMenuButton<String>(
                                          initialValue: selectedType ??
                                              orders.orderStatus,
                                          color: Colors.white,
                                          onSelected: (value) {
                                            print(orders.sId);
                                            // Handle menu item selection
                                            setState(() {
                                              selectedType = value;
                                              // Update the state or perform actions based on the selected value
                                            });
                                            final body = {
                                              "status": selectedType
                                            };
                                            context
                                                .read<CreateProductViewModel>()
                                                .putOrderTypeApi(
                                                    jsonEncode(body),
                                                    orders.sId!)
                                                .then((_) {
                                              setState(() {
                                                selectedType = null;
                                              });
                                              if (context.mounted) {
                                                context
                                                    .read<
                                                        CreateProductViewModel>()
                                                    .getAllAdminOrders();
                                              }
                                            });
                                          },
                                          itemBuilder: (context) =>
                                              type.map((e) {
                                            return PopupMenuItem<String>(
                                              value: e,
                                              child: Text(
                                                e,
                                              ),
                                            );
                                          }).toList(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down_circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    // ! Row -> 1
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              // ! Icon
                                              const Icon(Iconsax.tag),
                                              const SizedBox(
                                                width: 16.0 / 2,
                                              ),
                                              // !  2 -  Status & Date
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Order",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium),
                                                    Text(
                                                      "#${orders.sId!.substring(0, 6)}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              // ! Icon
                                              const Icon(Iconsax.calendar),
                                              const SizedBox(
                                                width: 16.0 / 2,
                                              ),
                                              // !  2 -  Status & Date
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Shopping Date",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium),
                                                    Text(
                                                      Utils().formatDate(
                                                          orders.createdAt!),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }));
              case Status.ERROR:
                return Center(
                  child: Text(data.getOrderList.message.toString()),
                );
            }
          }),
        ));
  }
}
