import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/view/admin/viewmodel/create_product_view_model.dart';
import 'package:provider/provider.dart';

class GetStreamScreen extends StatefulWidget {
  const GetStreamScreen({super.key});

  @override
  State<GetStreamScreen> createState() => _GetStreamScreenState();
}

class _GetStreamScreenState extends State<GetStreamScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CreateProductViewModel>().getStreamApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text("Get Streams",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white)),
        ),
        body: Consumer<CreateProductViewModel>(builder: (context, data, _) {
          switch (data.getStreams.status) {
            case Status.LOADING:
              return Center(
                child: Utils.showLoadingSpinner(AppColors.cherryRed),
              );
            case Status.COMPLETED:
              return data.getStreams.data!.isEmpty
                  ? const Center(
                      child: Text("No Stream Found"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.black,
                          child: ListTile(
                            title: SelectableText(
                              data.getStreams.data![index].videoId!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text("Are you sure?"),
                                        content: const Text(
                                            "Do you really want to delete this stream? This action cannot be undone."),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.black),
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.red),
                                            child: const Text("Delete"),
                                            onPressed: () {
                                              context
                                                  .read<
                                                      CreateProductViewModel>()
                                                  .deleteStreamApi(data
                                                      .getStreams
                                                      .data![index]
                                                      .sId!);
                                              Navigator.pop(context);
                                              // Schedule the deletion after the current frame is rendered
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ),
                        );
                      },
                      itemCount: data.getStreams.data!.length,
                    );
            case Status.ERROR:
              return Center(
                child: Text(data.getStreams.message!),
              );
          }
        }));
  }
}
