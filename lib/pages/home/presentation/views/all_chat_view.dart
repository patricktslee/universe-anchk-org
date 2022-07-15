import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/views/home_layout.dart';

class AllChatPage extends StatelessWidget {
  AllChatPage({Key? key}) : super(key: key);
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),

                //Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  children: <Widget>[
                //    const Text(
                //      "Conversations",
                //      style:
                //          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                //    ),
                //    Container(
                //      padding: const EdgeInsets.only(
                //          left: 8, right: 8, top: 2, bottom: 2),
                //      height: 30,
                //      decoration: BoxDecoration(
                //        borderRadius: BorderRadius.circular(30),
                //        color: Colors.pink[50],
                //      ),
                //      child: Row(
                //        children: const <Widget>[
                //          Icon(
                //            Icons.add,
                //            color: Colors.pink,
                //            size: 20,
                //          ),
                //          SizedBox(
                //            width: 2,
                //          ),
                //          Text(
                //            "Add New",
                //            style: TextStyle(
                //                fontSize: 14, fontWeight: FontWeight.bold),
                //          ),
                //        ],
                //      ),
                //    )
                //  ],
                //),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
