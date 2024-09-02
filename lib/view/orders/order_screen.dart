import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muztune/common/t_rounded_container.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/view/orders/order_preview_screen.dart';
import 'package:muztune/viewModel/order/order_view_model.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderViewModel>().getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          "Order",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<OrderViewModel>(builder: (context, data, _) {
        switch (data.allOrderList.status) {
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
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 16.0,
                        ),
                    itemCount: data.allOrderList.data!.length,
                    itemBuilder: (context, index) {
                      final orders = data.allOrderList.data![index];
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
                                // ! 3 - Icon
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                   OrderPreviewScreen(orderModel: orders,)));
                                    },
                                    icon: const Icon(
                                      Iconsax.arrow_right_34,
                                      size: 16.0,
                                    ))
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
                                          mainAxisSize: MainAxisSize.min,
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
                                          mainAxisSize: MainAxisSize.min,
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
              child: Text(data.allOrderList.message.toString()),
            );
        }
      }),
    );
  }
}
