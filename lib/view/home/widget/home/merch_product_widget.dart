import 'package:flutter/material.dart';
import 'package:muztunes_app/common/product_tile.dart';

class MerchProductWidget extends StatelessWidget {
  const MerchProductWidget({
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
        "https://shop.muztunes.co/wp-content/uploads/2023/01/E_CC2_CD-01-300x300.png",
    "title": "Autographed Test Pressing Vinyl",
    "subTitle": "Merch",
    "price": 500.00
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/E_CC2_CD-01-300x300.png",
    "title": "Curtain Call 2 2CD",
    "subTitle": "Merch",
    "price": 20.00,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/8_EMINEMPRESENTSLP-blackvinyl-300x300.png",
    "title": "Eminem Presents The Re-Up LP",
    "subTitle": "Merch",
    "price": 26.98,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/E_CC2_CD-01-300x300.png",
    "title": "Kendrick Lamar 2022 Concert Hoodie + DAMN Hat Pack",
    "subTitle": "Merch",
    "price": 76.90,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/Kendrick-Best-Seller-Pack-1-300x300.jpg",
    "title": "Kendrick Lamar Best Sellers Pack: Hoodie + Hoodie",
    "subTitle": "Merch",
    "price": 104.90,
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2023/01/Kendrick-Best-Seller-Pack-1-300x300.jpg",
    "title": "Kendrick Lamar Best Sellers Pack: Hoodie + Hoodie",
    "subTitle": "Merch",
    "price": 104.90,
  },
];
