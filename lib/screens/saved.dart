import 'package:booktracker/db/database_helper.dart';
import 'package:booktracker/screens/bookdetails.dart';
import 'package:flutter/material.dart';

import '../models/bookmodel.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});


  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:FutureBuilder(future:DatabaseHelper.instance.readAllBooks(), builder: (context,snapshot)=>snapshot.hasData?ListView.builder(
          itemCount:snapshot.data!.length,
          itemBuilder: (context,index){
       Book myBooks=snapshot.data![index];
       return InkWell(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>bookdetails(myBookDetails:myBooks,)));
         },
         child: Card(
           child: ListTile(
           title:Text(myBooks.title),
             trailing: IconButton(icon: const Icon(Icons.delete),
             onPressed: (){
               DatabaseHelper.instance.deleteBook(myBooks.id);
               setState(() {});

             },
             ) ,
             leading:Image.network(myBooks.imageLinks['thumbnail']??'',
             fit:BoxFit.cover),
             subtitle: Column(
               children:<Widget>[
                 Text(myBooks.authors.join(', ')),
                 ElevatedButton.icon(onPressed:() async{
                   await DatabaseHelper.instance.toggleFavoriteStatus(myBooks.id, !myBooks.isFavorite).then((value)=>print("Item Favored!! $value"));
                 },
                   icon:Icon(Icons.favorite,color:Colors.red),
                   label: Text('Add to Favorites'),

                 )
               ]
             ),
           ),
         ),
       );

      })
      : Center(child:const CircularProgressIndicator())
      ),
    );
  }
}
