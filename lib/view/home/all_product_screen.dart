import 'package:flutter/material.dart';
import 'package:muztune/common/product_tile.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/shimmers/product_tile_shimmer.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
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
          // bottom: const PreferredSize(
          //   preferredSize: Size.fromHeight(kToolbarHeight),
          //   child: FilterPriceWidget(),
          // ),
        ),
        body: Consumer<ProductViewModel>(builder: (context, data, _) {
          if (data.allProductResponse.status == Status.COMPLETED &&
              data.allProductResponse.data != null &&
              data.allProductResponse.data!.data != null) {
            // Filter products by type 'product'
            final filteredProducts = data.allProductResponse.data!.data!
                .where((product) => product.type == 'product')
                .toList();
            return GridView.builder(
              itemCount: filteredProducts.length,
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: 0.52,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductTile(
                  type: product.type!,
                  productId: product.sId!,
                  imageUrl: product.images![0].toString(),
                  price: double.parse(product.price.toString()),
                  subTitle: product.description.toString(),
                  title: product.title.toString(),
                  tags: product.tags!,
                  category: product.category.toString(),
                  images: product.images!,
                  totalrating: product.totalrating??"0",
                  link: product.link!
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
