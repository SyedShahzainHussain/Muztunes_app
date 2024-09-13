import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/view/admin/viewmodel/create_product_view_model.dart';
import 'package:muztune/view/concert/supoort_page.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ConcertScreen extends StatefulWidget {
  const ConcertScreen({super.key});

  @override
  State<ConcertScreen> createState() => _ConcertScreenState();
}

class _ConcertScreenState extends State<ConcertScreen> {
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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Concert",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<CreateProductViewModel>(builder: (context, data, _) {
        switch (data.getStreams.status) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.COMPLETED:
            return Container(
              margin: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: ListView.separated(
                separatorBuilder: (context, index) => const  SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: YoutubePlayer(
                     
                      controller: YoutubePlayerController.fromVideoId(
                        videoId: data.getStreams.data![index],
                        autoPlay: false,
                        params: const YoutubePlayerParams(
                            showFullscreenButton: false),
                      ),
                      aspectRatio: 16 / 9,
                    ),
                  );
                },
                itemCount: data.getStreams.data!.length,
              ),
            );
          case Status.ERROR:
            return Center(
              child: Text(data.getStreams.message!),
            );
        }
      }),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 87),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SupoortPage()));
          },
          tooltip: "Chat Support",
          child: const Icon(Icons.support_agent, color: Colors.white),
        ),
      ),
    );
  }
}
