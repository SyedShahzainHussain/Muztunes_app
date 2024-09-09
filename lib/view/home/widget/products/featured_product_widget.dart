import 'package:flutter/material.dart';
import 'package:muztune/common/product_tile.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/shimmers/product_tile_shimmer.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class FeaturedProductWidget extends StatefulWidget {
  const FeaturedProductWidget({
    super.key,
  });

  @override
  State<FeaturedProductWidget> createState() => _FeaturedProductWidgetState();
}

class _FeaturedProductWidgetState extends State<FeaturedProductWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, data, _) {
      switch (data.allProductResponse.status) {
        case Status.LOADING:
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        case Status.COMPLETED:
          final products = data.allProductResponse.data!.data!;
          final filteredProducts =
              products.where((product) => product.type == 'product').toList();
          final displayedItems = filteredProducts.length > 6
              ? filteredProducts.sublist(0, 6)
              : filteredProducts;

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              childAspectRatio: 0.52,
            ),
            itemBuilder: (context, index) {
              final product = displayedItems[index];
              return ProductTile(
                type: product.type!,
                productId: product.sId!,
                imageUrl: product.images![0],
                price: double.parse(product.price.toString()),
                subTitle: product.description!,
                title: product.title!,
                category: product.category!,
                tags: product.tags!,
                images: product.images!,
                totalrating: product.totalrating ?? "0",
                link: product.link!,
                

              );
            },
            itemCount: displayedItems.length,
          );

        case Status.ERROR:
          return Center(
              child: Text(data.allProductResponse.message.toString()));
      }
    });
  }
}
