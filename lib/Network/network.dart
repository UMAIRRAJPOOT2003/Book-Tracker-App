 import '../models/bookmodel.dart';
 import 'dart:convert';
 import 'package:http/http.dart' as http;

// class Network{
//   static const String _baseurl='https://www.googleapis.com/books/v1/volumes';
//   Future<List<Book>> searchBooks(String query) async {
//     var url=Uri.parse('$_baseurl?q=$query');
//     var response=await http.get(url);
//
//     if(response.statusCode==200)
//       {
//         var data=json.decode(response.body);//this is direct method that is used when we dont want to use jsonString method as in movie app
//         if(data['items']!=null && data['items'] is List){
//           List<Book> books=(data['items'] as List<dynamic>)
//               .map((i)=>Book.fromJson(i as Map<String,dynamic>)).toList();//.mao(i) is using as a loop also
//           return books;//it return only one object of book from json file
//         }
//         else
//           {
//             return [];
//           }
//
//       }
//     else
//       {
//          throw Exception("Failed to load books");
//       }
//   }
// }
 class Network {
   static const String _baseurl = 'https://www.googleapis.com/books/v1/volumes';

   Future<List<Book>> searchBooks(String query) async {
     var url = Uri.parse('$_baseurl?q=$query');
     var response = await http.get(url);

     if (response.statusCode == 200) {
       var data = json.decode(response.body);

       if (data['items'] != null && data['items'] is List) {
         List<Book> books = (data['items'] as List<dynamic>)
             .map((i) => Book.fromJson(i as Map<String, dynamic>))
             .toList();
         return books;
       } else {
         print("No items found or items is not a list.");
         return [];
       }

     } else {
       print("Failed to load books with status code: ${response.statusCode}");
       throw Exception("Failed to load books");
     }
   }
 }

