import 'package:flutter/material.dart';
import 'package:muztune/common/custom_app_bar.dart';
import 'package:muztune/common/t_rounded_container.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/view/home/widget/rating/t_user_rating.dart';
import 'package:muztune/view/rating/add_rating_screen.dart';
import 'package:muztune/viewModel/rating/rating_view_model.dart';
import 'package:provider/provider.dart';

class ProductRating extends StatefulWidget {
  final String type;
  final String productId;
  const ProductRating({super.key, required this.type, required this.productId});

  @override
  State<ProductRating> createState() => _ProductRatingState();
}

class _ProductRatingState extends State<ProductRating> {
  @override
  void initState() {
    super.initState();
    final body = {"Id": widget.productId, "type": widget.type};
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      context.read<RatingViewModel>().getAllRating(body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: const Text("Reviews & Rating"),
          showBackArrow: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddRatingScreen(
                                type: widget.type,
                                productId: widget.productId,
                              )));
                },
                icon: const Icon(Icons.create)),
          ],
        ),
        body: Consumer<RatingViewModel>(builder: (context, data, _) {
          switch (data.ratingListModel.status) {
            case Status.LOADING:
              return const Center(
                child: TRoundedContainer(
                  padding: EdgeInsets.all(12),
                  width: 50,
                  height: 50,
                  backgroundColor: AppColors.redColor,
                  showBorder: true,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 3.0,
                  ),
                ),
              );
            case Status.ERROR:
              return Center(child: Text(data.ratingListModel.message!));
            case Status.COMPLETED:
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: data.ratingListModel.data!.ratings!.isEmpty
                      ? const Center(child: Text("No Rating Found!"))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              data.ratingListModel.data!.ratings!.map((e) {
                            return UserRating(
                              comment: e.comment!,
                              imageurl: e.postedby!.image!,
                              rating: e.star!.toDouble(),
                              name: e.postedby!.name!,
                            );
                          }).toList()),
                ),
              );
          }
        }));
  }
}
