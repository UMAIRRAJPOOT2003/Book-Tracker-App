//this class will interact with database
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/bookmodel.dart'; // Import the path package

class DatabaseHelper {
  static const _databaseName = 'books_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'books';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper
      ._privateConstructor(); //it i sused to make the constructor private in dart
  static Database? _database;

  Future<Database> get database async {
    _database ??=
    await _initDatabase(); //the ?? operator is used to check if _database is null or not if null then it will assign _initDatabase fuction value to _database and if _database is not null then _database will not accept any value from _initDatabase function
    return _database!; //the ! operator is used to tell that _database willnot be null in any condition
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
        path, version: _databaseVersion, onCreate: _onCreate);
  }

//now we will make a onCreate function whihhc will connstruct table in database

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        authors TEXT NOT NULL,
        favorite INTEGER DEFAULT 0,
        publisher TEXT,
        publishedDate TEXT,
        description TEXT,
        industryIdentifiers TEXT,
        pageCount INTEGER,
        language TEXT,
        imageLinks TEXT,
        previewLink TEXT,
        infoLink TEXT
      )
    ''');
  }

  //NOW STARTING CRUD OPERATIONS
Future<int> insert(Book book) async{
Database db= await instance.database;
return await db.insert(_tableName,book.toJson());//book.tojson() function is present in bookmodel.dart class.simple passing a book object will show error here
}
Future<List<Book>> readAllBooks()async{
    Database db=await instance.database;
    var books=await db.query(_tableName);
    return books.isNotEmpty?books.map((bookData)=>Book.fromJsonDatabase(bookData)).toList():[];
}
//updating  a table
  Future<int> toggleFavoriteStatus(String id, bool isFavorite) async {
    Database db = await instance.database;
    return await db.update(_tableName, {'favorite': isFavorite ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
  }

//function to display updated data on screen
  Future<List<Book>> getFavorites() async {
    Database db = await instance.database;
    var favBooks =
    await db.query(_tableName, where: 'favorite = ?', whereArgs: [1]);

    return favBooks.isNotEmpty
        ? favBooks.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];
  }
Future<int> deleteBook(String id) async{
    Database db=await instance.database;
    return await db.delete(_tableName,where: 'id=?',whereArgs:[id]);//this line is used to convert the map (that we got from database in map format) to List

}


}