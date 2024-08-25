import 'package:flutter/material.dart';
import 'package:muztunes_app/common/product_tile.dart';

class FeaturedProductWidget extends StatelessWidget {
  const FeaturedProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            childAspectRatio: 0.52),
        itemBuilder: (context, index) {
          final product = data[index];
          return ProductTile(
            imageUrl: product["imageUrl"],
            price: product["price"],
            subTitle: product["subTitle"],
            title: product["title"],
          );
        });
  }
}

List<Map<String, dynamic>> data = [
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/Madonna-Black-300x300.jpg",
    "title": "HOPE & FAITH Unisex Madonna T-Shirt Short Sleeve Mens Womens",
    "subTitle": "MEN",
    "price": 19.99
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/nirvana-300x300.jpg",
    "title": "Nirvana Men’s Nevermind Album Play List Slim Fit T-Shirt Navy",
    "subTitle": "MEN",
    "price": 24.99,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/dream-on-1-300x300.jpg",
    "title": "Aerosmith – Dream On Portrait T-Shirt",
    "subTitle": "MEN",
    "price": 29.99,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/71nnt43KdKL._AC_UX679_-300x300.jpg",
    "title": "Gildan Men’s Crew T-Shirts, Multipack",
    "subTitle": "MEN",
    "price": 18.35,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/61EjyEFPGoL._AC_UX679_-300x300.jpg",
    "title": "Flexfit Men’s Athletic Baseball Fitted Cap",
    "subTitle": "MEN",
    "price": 6.99,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/61rTG-YE9AL._AC_UX679_-300x300.jpg",
    "title": "U2 Men’s Bullet The Blue Sky Slim Fit T-Shirt Black",
    "subTitle": "MEN",
    "price": 29.47,
  },
];
