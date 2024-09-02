import 'package:flutter/material.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/viewModel/category/category_view_model.dart';
import 'package:muztune/viewModel/filter/filter_view_model.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F3F5),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
        surfaceTintColor: Colors.black,
        shadowColor: Colors.black87,
        backgroundColor: Colors.black,
        title: const Text(
          "Filters",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            context.read<FilterViewModel>().clear();
            Navigator.pop(context);
          }
        },
        child: Consumer<FilterViewModel>(
          builder: (context, data, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Price range",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.zero),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$${data.minPrice.toStringAsFixed(0)}"),
                            Text("\$${data.maxPrice.toStringAsFixed(0)}"),
                          ],
                        ),
                        RangeSlider(
                          activeColor: AppColors.redColor,
                          min: 0.0,
                          max: 10000.0,
                          values: RangeValues(data.minPrice, data.maxPrice),
                          onChanged: (values) {
                            data.setPriceRange(values.start, values.end);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Category",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Consumer<CategoryViewModel>(
                builder: (context, data, _) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.zero),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                            spacing: 8,
                            runSpacing: 5,
                            children: data.categoryList.data!
                                .map(
                                  (e) =>
                                      _buildCategoryButton(context, e.title!),
                                )
                                .toList())),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight + 20,
        child: Card(
          elevation: 8.0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.zero),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<FilterViewModel>().clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Discard",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redColor,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      context.read<FilterViewModel>().save();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Apply",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // final List color = [
  //   Colors.black,
  //   const Color(0xfff8f8f8),
  //   const Color(0xffb84235),
  //   const Color(0xffc7b9b8),
  //   const Color(0xffe3c8a3),
  //   const Color(0xff1d2976)
  // ];
  Widget _buildCategoryButton(BuildContext context, String category) {
    return Consumer<FilterViewModel>(
      builder: (context, data, _) {
        final isSelected = data.selectedCategory.contains(category);
        return GestureDetector(
          onTap: () {
            context.read<FilterViewModel>().setSelectedCategory(category);
          },
          child: Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.redColor : Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text(
          //     "Colors",
          //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //           fontWeight: FontWeight.bold,
          //         ),
          //   ),
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   height: 100,
          //   child: Card(
          //     margin: EdgeInsets.zero,
          //     color: Colors.white,
          //     shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadiusDirectional.zero),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: List.generate(
          //             color.length,
          //             (index) => Padding(
          //               padding: const EdgeInsets.only(right: 10.0),
          //               child: Container(
          //                 height: 40,
          //                 width: 40,
          //                 decoration: BoxDecoration(
          //                     border: Border.all(
          //                         color: AppColors.redColor, width: 2,),
          //                     shape: BoxShape.circle,
          //                     color: color[index]),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
//  Padding(
//             padding: const EdgeInsets.all(10),
//             child: Text(
//               "Size",
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             height: 100,
//             child: Card(
//               color: Colors.white,
//               margin: EdgeInsets.zero,
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadiusDirectional.zero),
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.grey,
//                               ),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: const Center(child: Text("XS")),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               color: AppColors.redColor,
//                               border: Border.all(
//                                 color: Colors.grey,
//                               ),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: const Center(child: Text("S")),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               color: AppColors.redColor,
//                               border: Border.all(
//                                 color: Colors.grey,
//                               ),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: const Center(child: Text("M")),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.grey,
//                               ),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: const Center(child: Text("L")),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.grey,
//                               ),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           child: const Center(child: Text("XL")),
//                         ),
//                       ],
//                     ),
//                   )),
//             ),
//           ),