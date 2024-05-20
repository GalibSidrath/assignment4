import 'dart:convert';

import 'package:assignment4/ImgModel.dart';
import 'package:assignment4/single_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List<ImgModel> myData = [];
  bool _getDatainProgress = false;

  @override
  void initState() {
    super.initState();
    _getData(); // Fetch data when the widget is first built
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
      ),
      body: Visibility(
        visible: !_getDatainProgress,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: myData.length,
          itemBuilder: (context, index) {
            return _buildTheData(myData[index]); // Return the built widget
          },
        ),
      ),
    );


  }

  Future<void> _getData() async {
    setState(() {
      _getDatainProgress = true;
    });

    myData.clear();
    String getDataURL = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(getDataURL);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      final List gettingData = decodeData;
      for (Map data in gettingData) {
        // TheData DATA = TheData(
        //     id: data['id'].toString(),
        //     title: data['title'] ?? '',
        //     thumbnail: data['thumbnailUrl'] ?? '',
        //     imgUrl: data['url'] ?? '');
        // myData.add(DATA);
        myData.add(ImgModel.fromJson(data));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fetching data failed'))
      );
    }

    setState(() {
      _getDatainProgress = false;
    });
  }

  Widget _buildTheData(ImgModel theData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            String title = theData.title.toString();
            String id = theData.id.toString();
            String imgUrl = theData.url.toString();
            return SingleData(title: title, id: id, imgUrl: imgUrl);
          }));
        },
        child: ListTile(
          title: Wrap(
            children: [Text(theData.title.toString(), style: TextStyle(fontWeight: FontWeight.bold),)],
          ),
          leading: Image.network(
            theData.thumbnailUrl.toString(),
            height: 60,
            width: 60,
          ),
        ),
      ),
    );
  }

}

// class TheData {
//   final String id;
//   final String title;
//   final String thumbnail;
//   final String imgUrl;
//
//   TheData(
//       {required this.id,
//         required this.title,
//         required this.thumbnail,
//         required this.imgUrl});
// }

