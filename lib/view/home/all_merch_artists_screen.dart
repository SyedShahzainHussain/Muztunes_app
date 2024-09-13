import 'package:flutter/material.dart';
import 'package:muztune/common/product_tile.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/shimmers/product_tile_shimmer.dart';
import 'package:muztune/viewModel/article/article_view_model.dart';
import 'package:provider/provider.dart';

class AllMerchArtistsScreen extends StatefulWidget {
  const AllMerchArtistsScreen({super.key});

  @override
  State<AllMerchArtistsScreen> createState() => _AllMerchArtistsScreenState();
}

class _AllMerchArtistsScreenState extends State<AllMerchArtistsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleViewModel>().getArticleList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 1.0,
          title: Text("All Merch Artists",
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
        body: Consumer<ArticleViewModel>(builder: (context, data, _) {
          if (data.articleList.status == Status.COMPLETED &&
              data.articleList.data != null &&
              data.articleList.data!.data != null) {
            return data.articleList.data!.data!.isEmpty
                ? const Center(
                    child: Text("No Article Found!"),
                  )
                : GridView.builder(
                    itemCount: data.articleList.data!.data!.length,
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      childAspectRatio: 0.52,
                    ),
                    itemBuilder: (context, index) {
                      final product = data.articleList.data!.data![index];
                      return ProductTile(
                        type: product.type!,
                        productId: product.sId!,
                        imageUrl: product.image!,
                        price: double.parse(product.price.toString()),
                        subTitle: product.description.toString(),
                        title: product.title.toString(),
                        tags: product.tags!,
                        category: product.category ?? "",
                        image: product.image,
                        isProduct: false,
                        totalrating: product.totalrating ?? "0",
                        link: product.link!,
                        color: const [],
                      );
                    },
                  );
          } else if (data.articleList.status == Status.ERROR) {
            return Center(
              child: Text(data.articleList.message.toString()),
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
