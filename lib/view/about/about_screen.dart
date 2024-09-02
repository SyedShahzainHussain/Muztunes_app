import 'package:flutter/material.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/view/home/widget/home/search_merchandise_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "About",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 10),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          color: AppColors.redColor,
                          width: context.screenWidth * 0.20,
                          height: 4,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "About Muztunes",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "We are Muztunes. Our goal is to transform the online Music ecosystems. From buying merch from your favorite artist. To checking out musicians music videos. Even able to finally have a music focused Social Network. ",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          color: AppColors.redColor,
                          width: context.screenWidth * 0.20,
                          height: 4,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("A Few Words About",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Our Team",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          "https://shop.muztunes.co/wp-content/uploads/2018/12/globe-free-img.png",
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Andrew Seidel",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Founder - CEO",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  Image.network(
                      "https://shop.muztunes.co/wp-content/uploads/2023/01/muztunes.co-landing-banner.jpg",
                      height: context.screenHeight * 0.30,
                      width: double.infinity,
                      fit: BoxFit.cover),
                  Container(
                    color: const Color(0xff000000).withOpacity(0.45),
                    height: context.screenHeight * 0.30,
                    width: double.infinity,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: context.screenHeight * .27,
                        width: context.screenWidth * .85,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                color: AppColors.redColor,
                                width: context.screenWidth * 0.15,
                                height: 4,
                              ),
                              SizedBox(
                                height: context.screenHeight * 0.01,
                              ),
                              Text("Subscribe",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                height: context.screenHeight * 0.01,
                              ),
                              SizedBox(
                                width: context.screenWidth * .75,
                                height: 35,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 4),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Your email address...",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: const OutlineInputBorder(),
                                    focusedBorder: const OutlineInputBorder(),
                                    errorBorder: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: context.screenHeight * 0.03,
                              ),
                              SizedBox(
                                  width: context.screenWidth * .25,
                                  height: context.screenHeight * 0.05,
                                  child: const Button(
                                    title: "SUBSCRIBE",
                                    color: AppColors.redColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SearchMerchandiseWidget(
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
