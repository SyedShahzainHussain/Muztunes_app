import 'package:flutter/material.dart';
import 'package:muztunes_apps/common/filter_price_widget.dart';
import 'package:muztunes_apps/common/product_tile.dart';
import 'package:muztunes_apps/data/response/status.dart';
import 'package:muztunes_apps/shimmers/product_tile_shimmer.dart';
import 'package:muztunes_apps/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 1.0,
          title: Text("All Featured Prodcuts",
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
        body: Consumer<ProductViewModel>(builder: (context, data, _) {
          if (data.allProductResponse.status == Status.COMPLETED &&
              data.allProductResponse.data != null &&
              data.allProductResponse.data!.data != null) {
            return GridView.builder(
              itemCount: data.allProductResponse.data!.data!.length,
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: 0.52,
              ),
              itemBuilder: (context, index) {
                final product = data.allProductResponse.data!.data![index];
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
          } else if (data.allProductResponse.status == Status.ERROR) {
            return Center(
              child: Text(data.allProductResponse.message.toString()),
            );
          } else {
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
          }
        }));
  }
}
