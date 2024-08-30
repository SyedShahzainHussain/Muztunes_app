import 'package:flutter/material.dart';
import 'package:muztunes_apps/common/product_tile.dart';
import 'package:muztunes_apps/data/response/status.dart';
import 'package:muztunes_apps/shimmers/product_tile_shimmer.dart';
import 'package:muztunes_apps/viewModel/products/product_view_model.dart';
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
          final displayedItems =
              products.length > 6 ? products.sublist(0, 6) : products;
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
                productId: product.sId!,
                imageUrl: product.images![0].url!,
                price: double.parse(product.price.toString()),
                subTitle: product.description!,
                title: product.title!,
                category: product.category!,
                tags: product.tags!,
                images: product.images!,
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
