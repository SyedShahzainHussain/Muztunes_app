import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:muztune/common/cutom_text_field.dart';
import 'package:muztune/common/product_tile.dart';
import 'package:muztune/data/response/api_response.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true; // Start showing loading indicator
      });
      context
          .read<ProductViewModel>()
          .getAllProductsFromQuery({'title': query});
    } else {
      // Clear results if the search query is empty
      setState(() {
        isSearching = false; // Hide loading indicator
      });
      context.read<ProductViewModel>().setQueryData(ApiResponse.loading());
    }
  }

  @override
  Widget build(BuildContext context) {
    final queryProduct = context.watch<ProductViewModel>().queryProduct;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Ionicons.arrow_back),
            ),
            const SizedBox(width: 3),
            Expanded(
              child: CustomTextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                hintText: "Search For Products",
                onTap: () {
                  FocusScope.of(context).requestFocus();
                },
                suffixIcon: _searchController.text.isEmpty
                    ? GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Ionicons.search_circle,
                          size: 40,
                          color: Color(0xff83829A),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (_searchController.text.isNotEmpty) {
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isSearching =
                                  false; // Hide loading indicator when cleared
                            });
                          }
                        },
                        child: const Icon(
                          Ionicons.close_circle,
                          size: 40,
                          color: Color(0xff83829A),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: isSearching && queryProduct.status == Status.LOADING
              ? const Center(child: CircularProgressIndicator())
              : queryProduct.status == Status.ERROR
                  ? Center(child: Text('${queryProduct.message}'))
                  : queryProduct.data?.data?.isEmpty ?? true
                      ? const Center(child: Text("Search for products"))
                      : GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 25,
                            childAspectRatio: 0.52,
                          ),
                          itemBuilder: (context, index) {
                            final product = queryProduct.data!.data![index];
                            return ProductTile(
                              type: product.type!,
                              imageUrl: product.images![0],
                              title: product.title!,
                              subTitle: product.description!,
                              tags: product.tags!,
                              price: double.parse(product.price.toString()),
                              category: product.category ?? "",
                              productId: product.sId!,
                              images: product.images ?? [],
                              image: product.images?[0],
                              totalrating: product.totalrating ?? "0",
                              link: product.link!,
                              color: product.colors ?? [],
                              information: product.information,
                            );
                          },
                          itemCount: queryProduct.data!.data!.length,
                        )),
    );
  }
}
