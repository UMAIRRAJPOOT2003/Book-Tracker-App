import 'package:booktracker/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../db/database_helper.dart';
import '../models/bookmodel.dart';

class bookdetails extends StatelessWidget {
  const bookdetails({super.key, required this.myBookDetails});
  final Book myBookDetails;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        title: Text(
          "${myBookDetails.title}",
          style: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.network(
                          myBookDetails.imageLinks['thumbnail'] ?? '',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            myBookDetails.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            myBookDetails.authors.join(', & ') ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Published: ${myBookDetails.publishedDate}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Page Count: ${myBookDetails.pageCount.toString()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Language: ${myBookDetails.language}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
            Padding(
                padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
              ElevatedButton.icon(
              onPressed: () async {
                Navigator.push(context,MaterialPageRoute(builder:(context)=>FavoritePage()));

              },
                icon: const Icon(Icons.favorite,color:Colors.red),
                label: const Text('Favorite')
              ),

            ElevatedButton.icon(
                onPressed: () async {
                  try{

                    await DatabaseHelper.instance.insert(myBookDetails);
                    SnackBar snackbar= SnackBar(content:Text("Book saved"));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  catch(e){
                    print("ERROR:$e");

                  }
                },
                icon: const Icon(Icons.favorite,color: Colors.red,),
                label: const Text('Saved')
            ),

                ]
              )

            ),



                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),

                      // Description Container with vertical scrolling
                      Container(
                        decoration: BoxDecoration(
                          color:Colors.blueGrey.shade900,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            myBookDetails.description ?? 'No description available',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async{
                            final url=myBookDetails.previewLink;
                           if(await canLaunch(url)){
                             await launch(url);
                           }
                          },
                          child: Text('Read Book',style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
