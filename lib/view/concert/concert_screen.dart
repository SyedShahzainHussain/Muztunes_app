import 'package:flutter/material.dart';
import 'package:muztune/view/concert/supoort_page.dart';
class ConcertScreen extends StatelessWidget {
  const ConcertScreen({super.key});

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
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 87),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
        
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const SupoortPage()));
          },
          tooltip: "Chat Support",
          child: const Icon(Icons.support_agent,color:Colors.white),
        ),
      ),
    );
  }
}
