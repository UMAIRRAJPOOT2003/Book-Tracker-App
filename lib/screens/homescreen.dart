
import 'package:booktracker/screens/bookdetails.dart';
import 'package:flutter/material.dart';

import '../Network/network.dart';
import '../models/bookmodel.dart';


class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  Network mynetwork=Network();
  List<Book> _books=[];
Future<void> _searchBooks(String query) async{
    try{
      List<Book> data=await mynetwork.searchBooks(query);
      //print("Books: ${data.toString()}");//here tostring function is not builtin function it is userwritten function in bookmodel.dart file
      setState(() {
        _books=data;
      });
    }
    catch(e)
    {
      print("ERROR IN LOADING Data");
    }

  }
  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body:Container(
       color: Colors.black,
       child: Center(

         child:Column(
           children: <Widget>[

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(

                 style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
                 decoration:InputDecoration(
                   suffixIcon: Icon(Icons.search),
                   border:OutlineInputBorder(

                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     borderSide: BorderSide(color: Colors.green.shade800, width: 3),
                   )
                 ),
                 onSubmitted: (query)=> _searchBooks(query),
               ),
             ),


     Expanded(
                 child:GridView.builder(

                 itemCount:_books.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.6),
                     itemBuilder: (context,index){
                       Book mybook=_books[index];
                   return Container(
                     margin:const EdgeInsets.all(8),
                     decoration:BoxDecoration(
                       color:Colors.blueGrey.shade900,
                       borderRadius: BorderRadius.all(Radius.circular(10),),
                     ),
                     child:GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) =>bookdetails(myBookDetails:mybook,)));
                       },
                       child: Column(
                         children:<Widget>[
                           Padding(
                             padding: const EdgeInsets.all(18.0),
                             child: Image.network(mybook.imageLinks['thumbnail'] ?? ''),//question mark is important otherwise error will be produced on thhis line beacuse it says that if imageLinks['thumbnail']contain nothing then it should return ' '(nothing)

                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(mybook.title,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,//TextOverFlow.ellipses is used to solve the screen overflow issue
                             ),
                           ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(mybook.authors.join(', & ') ?? '',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,//it is used to solve the screen overflow issue
                              ),
                            ),//to display list of authors at once without using loop.ALSO, question mark is important otherwise error will be produced on thhis line beacuse it says that if imageLinks['thumbnail']contain nothing then it should return ' '(nothing)
                         ]
                       ),
                     )


                   );
                 })
             ),
             // Expanded(
             //   child: Container(
             //     width:double.infinity,
             //     child: ListView.builder(
             //         itemCount:_books.length,
             //         itemBuilder: (context,index){
             //       Book mybook=_books[index];
             //       return ListTile(
             //         title: Text(mybook.title,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
             //         subtitle: Text(mybook.authors.join(', & ') ?? ''),//to display list of authors at once without using loop
             //       );
             //     }
             //     ),
             //   ),
             // )
           ],
         )
       ),
     )
   );
  }
}
