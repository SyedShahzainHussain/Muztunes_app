import 'package:flutter/material.dart';
import 'package:muztunes/common/product_tile.dart';
import 'package:muztunes/config/colors.dart';
import 'package:muztunes/data/response/status.dart';
import 'package:muztunes/repository/products/product_http_repository.dart';
import 'package:muztunes/repository/products/product_repository.dart';
import 'package:muztunes/shimmers/product_tile_shimmer.dart';
import 'package:muztunes/utils/shimmer/shimmer.dart';
import 'package:muztunes/view/search/search_screen.dart';
import 'package:muztunes/viewModel/category/category_view_model.dart';
import 'package:muztunes/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

import '../../common/filter_price_widget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ProductRepository productRepository = ProductHttpRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryViewModel>().getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1.0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()));
              },
              icon: const Icon(Icons.search)),
        ],
        title: Text("Shop",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white)),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: FilterPriceWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Consumer<CategoryViewModel>(builder: (context, data, _) {
              switch (data.categoryList.status) {
                case Status.LOADING:
                  return Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SizedBox(
                      height: 50,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 12, // Width of the separator
                          height: 50, // Height of the separator
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GestureDetector(
                              onTap: () {},
                              child: const ShimmerEffect(
                                width: 100, // Width of the item
                                height: 40, // Height of the item
                                radius: 20, // Radius for the item
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        itemCount: 5,
                      ),
                    ),
                  );

                case Status.COMPLETED:
                  return Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SizedBox(
                      height: 50,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const Padding(padding: EdgeInsets.only(right: 12)),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (data.category ==
                                  data.categoryList.data![index]) {
                                data.setCategory = null;
                              } else {
                                data.setCategory =
                                    data.categoryList.data![index];
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: data.category ==
                                          data.categoryList.data![index]
                                      ? AppColors.redColor
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Center(
                                    child: Text(
                                  data.categoryList.data![index].title!,
                                  style: TextStyle(
                                      color: data.category ==
                                              data.categoryList.data![index]
                                          ? Colors.white
                                          : Colors.white,
                                      fontSize: 13),
                                )),
                              ),
                            ),
                          );
                        },
                        itemCount: data.categoryList.data!.length,
                      ),
                    ),
                  );
                case Status.ERROR:
                  return Center(
                    child: Text(data.categoryList.message!),
                  );
              }
            }),
            const SizedBox(
              height: 10,
            ),
            Consumer<CategoryViewModel>(builder: (context, data, _) {
              return FutureBuilder(
                  future: context.read<ProductViewModel>().fetchAllProducts(
                      {"category": data.category?.title ?? "mobile"}),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                          childAspectRatio: 0.52,
                        ),
                        itemBuilder: (context, index) {
                          return const ProductTileShimmer();
                        },
                        itemCount: 6,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return snapshot.data!.data!.isEmpty
                          ? const Center(
                              child: Text("No Product Found"),
                            )
                          : GridView.builder(
                              itemCount: snapshot.data!.data!.length,
                              padding: const EdgeInsets.all(8.0),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 25,
                                mainAxisSpacing: 25,
                                childAspectRatio: 0.52,
                              ),
                              itemBuilder: (context, index) {
                                final product = snapshot.data!.data![index];
                                return ProductTile(
                                  productId: product.sId!,
                                  imageUrl: product.images![0].url.toString(),
                                  price: double.parse(product.price.toString()),
                                  subTitle: product.description.toString(),
                                  title: product.title.toString(),
                                  tags: product.tags!,
                                  category: product.category.toString(),
                                  images: product.images!,
                                );
                              },
                            );
                    } else {
                      return const Center(
                        child: Text("Error Occured"),
                      );
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
