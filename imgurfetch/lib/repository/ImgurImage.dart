
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

 

 Future<List<String>> fetchImages() async {
  final response = await http.get(
    'https://api.imgur.com/3/gallery/search/?q=cats',
    headers: {HttpHeaders.authorizationHeader: "Client-ID 1ceddedc03a5d71"},

  );

  if (response.statusCode == 200) {
    List<String> images = [];
   Map<String, dynamic> img = json.decode(response.body);
 
   images = new List<String>.from(img['data'].map((x) {
     if(x['images'] != null){
       return x['images'][0]['link'];
     }
   }));

  
  images.removeWhere((element) =>  element == null || element.contains('mp4'));
   
   return images;



  
    
  } else {
    throw Exception('Failed to fetch Images');
  }
}