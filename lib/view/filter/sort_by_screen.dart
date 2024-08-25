import 'package:flutter/material.dart';

class SortByScreen extends StatelessWidget {
  const SortByScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Sort by",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Text("Popular"),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Text("Newest"),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Text("Customer review"),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Text("Price: lowest to high"),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            child: ListTile(
              title: Text("Price: highest to low"),
            ),
          ),
        ],
      ),
    );
  }
}
