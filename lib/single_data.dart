import 'package:flutter/material.dart';

class SingleData extends StatelessWidget {
  final String title;
  final String id;
  final String imgUrl;
  const SingleData({super.key, required this.title, required this.id, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("$imgUrl"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Title : $title", style: TextStyle(fontSize: 18),),
              ),
              Text('ID : $id',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
