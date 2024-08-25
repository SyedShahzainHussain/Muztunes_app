import 'package:flutter/material.dart';

class HomeGridProduct extends StatelessWidget {
  const HomeGridProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
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
          return GridTile(
            footer: const GridTileBar(
              backgroundColor: Colors.black87,
              // leading: IconButton(
              //     onPressed: () {},
              //     icon: const Icon(Icons.shopping_cart)),
              title: FittedBox(
                  child: Text(
                "Men  & Women T-Shirts",
                maxLines: 1,
              )),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
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
          );
        },
        itemCount: images.length,
      ),
    );
  }
}

List<String> images = [
  "https://shop.muztunes.co/wp-content/uploads/2023/01/T_SHIRTS-CATEGORY.jpg",
  "https://shop.muztunes.co/wp-content/uploads/2023/01/CAPS_CATEGORY.jpg",
  "https://shop.muztunes.co/wp-content/uploads/2023/01/Shoes-Category.jpg",
  "https://shop.muztunes.co/wp-content/uploads/2023/01/8_EMINEMPRESENTSLP-blackvinyl-300x300.png",
];
