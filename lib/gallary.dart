import 'package:flutter/material.dart';
import 'package:groundbooking/api.dart';
import 'package:groundbooking/main.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
   void initState() {
    getImage();
    super.initState();
  }
  void getImage()async{
    
   await fetchImagesFromDjango();
   setState(() {
     
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3,crossAxisSpacing: 3,
        ),
        itemCount: imageUrlsList.length,
        itemBuilder: (BuildContext context, int index) {
          print(imageUrlsList.length);
          return InkWell(
            onTap: () {
              navigation(
                  context,
                  ImageView(
                    img:
                        imageUrlsList[index],
                  ));
            },
            child: Container(
                height: 100,
                width: 100,
                child: Image.network(
                    imageUrlsList[index])),
          );
        },
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.img});
  final img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(
            img,
            fit: BoxFit.contain,
          ),
             ),
      ),
);
}
}
