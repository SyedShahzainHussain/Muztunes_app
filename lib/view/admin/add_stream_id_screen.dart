import 'package:flutter/material.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/common/cutom_text_field.dart';
import 'package:muztune/view/admin/viewmodel/create_product_view_model.dart';
import 'package:provider/provider.dart';

import '../../config/colors.dart';

class AddStreamIdScreen extends StatefulWidget {
  const AddStreamIdScreen({super.key});

  @override
  State<AddStreamIdScreen> createState() => _AddStreamIdScreenState();
}

class _AddStreamIdScreenState extends State<AddStreamIdScreen> {
  final TextEditingController streamId = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  saveStreamApi() {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;
    final body = {"videoId": streamId.text.toString()};
    context.read<CreateProductViewModel>().createStream(body,context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "Add Stream ID",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Stream ID is required";
                  }
                  return null;
                },
                controller: streamId,
                hintText: "Stream ID",
              ),
              const SizedBox(height: 20),
              Consumer<CreateProductViewModel>(builder: (context, data, _) {
                return Button(
                  loading: data.createStreamLoading,
                  title: "Submit",
                  onTap: () {
                    saveStreamApi();
                  },
                  color: AppColors.redColor,
                  titleColor: Colors.white,
                  showRadius: true,
                );
              })
            ]),
          ),
        ));
  }
}
