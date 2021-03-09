import 'package:flutter/material.dart';
import 'package:imgurfetch/repository/ImgurImage.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<String> images = [];
  ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _fetchImages();
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    _fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     
      body: _loadView(),
    );
  }

  Widget _loadView() {
    if (images.length == 0 ) {
      return Center(child: CircularProgressIndicator());
    }  else {
      return Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              controller: _controller,
              children: List.generate(
                images.length,
                (index) {
                  var image = images[index];
                    if(image == null ){
                      return Container();
                    }
                    return Center(
                        child: FadeInImage.assetNetwork(
                            placeholder: 'image/imgur_placeholder.jpg',
                            image: image));
                 
                },
              ),
            ),
          ),
  
        ],
      );
    }
  }

 

  void _fetchImages() async {
      await fetchImages().then((imgurImages) {
        print(imgurImages);
        setState(() {
          images = imgurImages;
        });
          
        
      });
    
  }
}