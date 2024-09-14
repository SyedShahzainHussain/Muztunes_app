import 'package:flutter/material.dart';
import 'package:muztune/common/product_tile.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/model/category_model.dart';
import 'package:muztune/repository/products/product_http_repository.dart';
import 'package:muztune/repository/products/product_repository.dart';
import 'package:muztune/shimmers/product_tile_shimmer.dart';
import 'package:muztune/utils/shimmer/shimmer.dart';
import 'package:muztune/view/search/search_screen.dart';
import 'package:muztune/viewModel/category/category_view_model.dart';
import 'package:muztune/viewModel/filter/filter_view_model.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

import '../../common/filter_price_widget.dart';

class ShopScreen extends StatefulWidget {
  final String? category;
  const ShopScreen({super.key, this.category});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ProductRepository productRepository = ProductHttpRepository();

  @override
  void initState() {
    super.initState();
    if (widget.category == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final categoryViewModel = context.read<CategoryViewModel>();
        categoryViewModel.getCategory();
        // If there's a category parameter, set it in the view model
      });
    }
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
            if (widget.category == null)
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
                          separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.only(right: 12)),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
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
            if (widget.category != null)
              Center(
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                        child: Text(
                      widget.category!,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    )),
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            Consumer<FilterViewModel>(
              builder: (context, data1, _) =>
                  Consumer<CategoryViewModel>(builder: (context, data, _) {
                // Construct query parameters
                final Map<String, String> queryParams = {
                  "category": widget.category != null
                      ? widget.category!
                      : data.category?.title ?? ""
                };
                if (data1.sortOption.isNotEmpty) {
                  queryParams["sort"] = data1.sortOption;
                }

                if (data1.saveCategory.isNotEmpty) {
                  queryParams["category"] = data1.saveCategory;
                }
                // Add price range to query parameters if both are non-default
                if (data1.saveminPrice != 0.0 && data1.savemaxPrice != 0.0) {
                  queryParams["minPrice"] = data1.saveminPrice.toString();
                  queryParams["maxPrice"] = data1.savemaxPrice.toString();
                }

                return FutureBuilder(
                    future: context
                        .read<ProductViewModel>()
                        .fetchAllProducts(queryParams),
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
                        return snapshot.data?.data?.isEmpty ?? true
                            ? const SizedBox(
                                height: 100,
                                child: Column(
                                  children: [
                                    Text("No Product Found"),
                                  ],
                                ),
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
                                    image: product.image,
                                    type: product.type!,
                                    productId: product.sId!,
                                    imageUrl:
                                        product.images?[0] ?? product.image!,
                                    price:
                                        double.parse(product.price.toString()),
                                    subTitle: product.description.toString(),
                                    title: product.title.toString(),
                                    tags: product.tags!,
                                    category: product.category??"",
                                    images: product.images ?? [],
                                    totalrating: product.totalrating ?? "0",
                                    link: product.link!,
                                    color: product.colors ?? [],
                                  );
                                },
                              );
                      } else {
                        return const Center(
                          child: Text("Error Occured"),
                        );
                      }
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
