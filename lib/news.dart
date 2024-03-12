import 'package:flutter/material.dart';
import 'package:groundbooking/api.dart';

class ViewNews extends StatefulWidget {
  const ViewNews({super.key});

  @override
  State<ViewNews> createState() => _ViewNewsState();
}

class _ViewNewsState extends State<ViewNews> {
  @override
  void initState() {
    getNews();
    super.initState();
  }
  void getNews()async{
   await fetchNewsListFromApi();
   setState(() {
     
   });
  }
  @override
  Widget build(BuildContext context) {
    print(newsList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Newses'),
      ),
      body: ListView.builder(
        itemCount:newsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(title: Text(newsList[index]['news']),trailing: Text(newsList[index]['date']),),
          );
        },
     ),
);
}
}