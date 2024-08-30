import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muztunes/view/filter/filter_screen.dart';
import 'package:muztunes/view/filter/sort_by_screen.dart';

class FilterPriceWidget extends StatelessWidget {
  const FilterPriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.zero),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FilterScreen()));
                },
                child: Row(
                  children: [
                    const Icon(Icons.filter_alt, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Filters",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (_) => const SortByScreen());
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/sort-solid.svg",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Price: lowest to high",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.grey)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
