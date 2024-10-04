import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';

class SupoortPage extends StatelessWidget {
  const SupoortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
iconTheme: const IconThemeData().copyWith(color: Colors.white),
        title:  Text('Muzconert Support',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Tawk(
        directChatLink: 'https://tawk.to/chat/6700337837379df10df1ec2b/1i9cci3sq',
        visitor: TawkVisitor(
          name: SessionController().userModel.user?.name ?? "Guest",
          email: SessionController().userModel.user?.email ?? "Guest@gmail.com",
        ),
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: Center(
          child: Utils.showLoadingSpinner(AppColors.redColor),
        ),
      ),
    );
  }
}
