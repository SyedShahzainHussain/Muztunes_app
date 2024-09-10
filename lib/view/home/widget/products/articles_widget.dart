import 'package:flutter/material.dart';
import 'package:muztune/common/product_tile.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/shimmers/product_tile_shimmer.dart';
import 'package:muztune/viewModel/article/article_view_model.dart';
import 'package:provider/provider.dart';

class ArticleListWidget extends StatefulWidget {
  const ArticleListWidget({
    super.key,
  });

  @override
  State<ArticleListWidget> createState() => _ArticleListWidgetState();
}

class _ArticleListWidgetState extends State<ArticleListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleViewModel>().getArticleList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(builder: (context, data, _) {
      switch (data.articleList.status) {
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
          final products = data.articleList.data!.data!;
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
                type: product.type!,
                productId: product.sId!,
                imageUrl: product.image!,
                price: double.parse(product.price.toString()),
                subTitle: product.description!,
                title: product.title!,
                category: product.category!,
                tags: product.tags!,
                image: product.image!,
                isProduct: false,
                totalrating: product.totalrating ?? "0",
                link: product.link!,
                color: const  [],
                
              );
            },
            itemCount: displayedItems.length,
          );

        case Status.ERROR:
          return Center(child: Text(data.articleList.message.toString()));
      }
    });
  }
}
