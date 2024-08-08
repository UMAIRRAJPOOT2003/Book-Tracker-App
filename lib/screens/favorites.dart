import 'package:booktracker/screens/bookdetails.dart';
import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/bookmodel.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: DatabaseHelper.instance.getFavorites(),
          builder: (context, snapshot) {
            // print("OGj:: ${snapshot.data?.first}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Book> favBooks = snapshot.data!;

              return ListView.builder(
                  itemCount: favBooks.length,
                  itemBuilder: (context, index) {
                    Book book = favBooks[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>bookdetails(myBookDetails:book)));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            fit: BoxFit.cover,
                          ),
                          title: Text(book.title),
                          subtitle: Text(book.authors.join(', ')),
                          trailing: const Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text('No favorite books found'),
              );
            }
          }),
    );
  }
}
