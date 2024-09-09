import 'package:flutter/material.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/shimmers/home_grid_shimmer.dart';
import 'package:muztune/view/home/product_detail_screen.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class HomeGridProduct extends StatefulWidget {
  const HomeGridProduct({
    super.key,
  });

  @override
  State<HomeGridProduct> createState() => _HomeGridProductState();
}

class _HomeGridProductState extends State<HomeGridProduct> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<ProductViewModel>(
        builder: (BuildContext context, data, Widget? child) {
          switch (data.allProductResponse.status) {
            case Status.LOADING:
              return const HomeGridShimmer();
            case Status.COMPLETED:
              // Limit the number of items displayed
              final products = data.allProductResponse.data!.data!;
              final filteredProducts = products
                  .where((product) => product.type == 'product')
                  .toList();
              final displayedItems = filteredProducts.length > 4
                  ? filteredProducts.sublist(0, 4)
                  : filteredProducts;

              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  final product = displayedItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(
                          type: product.type,
                          productId: product.sId!,
                          images: product.images!,
                          title: product.title!,
                          description: product.description!,
                          category: product.category!,
                          tags: product.tags!,
                          price: product.price.toString(),
                          link: product.link,
                        );
                      }));
                    },
                    child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black87,
                        title: Text(
                          product.title!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            product.images![0],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Opacity(
                            opacity: 0.3, // Adjust the opacity as needed
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .3,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: displayedItems.length,
              );
            case Status.ERROR:
              return Center(
                  child: Text(data.allProductResponse.message.toString()));
          }
        },
      ),
    );
  }
}
