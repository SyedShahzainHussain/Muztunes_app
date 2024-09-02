import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/viewModel/rating/rating_view_model.dart';
import 'package:provider/provider.dart';

class AddRatingScreen extends StatefulWidget {
  final String type;
  final String productId;
  const AddRatingScreen(
      {super.key, required this.type, required this.productId});

  @override
  State<AddRatingScreen> createState() => _AddRatingScreenState();
}

class _AddRatingScreenState extends State<AddRatingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  double rating = 0.0;

  saveRating() {
    final validate = _formKey.currentState!.validate();

    if (!validate) {
      return;
    } else if (rating == 0.0) {
      Utils.showToaster(message: "Selected Rating", context: context);
      return;
    }

    if (validate) {
      final body = {
        "star": rating.toInt(),
        "id": widget.productId,
        "comment": messageController.text,
        "type": widget.type
      };
      context.read<RatingViewModel>().putRatingApi(body, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text("Add ${widget.type} Rating",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        itemBuilder: (context, index) {
                          return const Icon(
                            Iconsax.star1,
                            color: AppColors.redColor,
                          );
                        },
                        onRatingUpdate: (double rating) {
                          setState(() {
                            this.rating = rating;
                          });
                        },
                        itemSize: 30.0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: messageController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Message is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.red,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<RatingViewModel>(
                        builder: (context, data, _) => Button(
                          loading: data.ratingLoading,
                          onTap: () {
                            saveRating();
                          },
                          title: "Submit",
                          color: AppColors.redColor,
                          titleColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
