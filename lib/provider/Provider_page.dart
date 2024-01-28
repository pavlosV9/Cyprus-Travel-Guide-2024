import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sql ;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:tourismappofficial/Places/place.dart';

class Data extends ChangeNotifier {

  String city = 'Limassol';
  String category = 'Restaurants';
  int id = 1;

  // Add methods that change the state here
  void changeCity(String newCity) {
    city = newCity;
    notifyListeners(); // Notify widgets listening to this model to rebuild.
  }

  void changeID(int newID) {
    id = newID;
    notifyListeners();
  }

  void changeCategory(String newCategory) {
    category = newCategory;
    notifyListeners();
  }

  List<String> cityList = [
    'Nicosia',
    'Limassol',
    'Famagusta',
    'Paphos',
    'Larnaca'
  ];

  List<String> categoryList = [
    'Restaurants',
    'Hotels',
    'Nightlife',
    'Beaches',
    'Sights'
  ];

  void selectCity(int index) {
    if (index >= 0 && index < cityList.length) {
      city = cityList[index];
      notifyListeners();
    }
  }

  String? selectedItem;

  List<Place> favouriteList = [
  ];

  Future<void> removeFromFavouriteList(int index) async {
    if (index >= 0 && index < favouriteList.length) {
      Place place = favouriteList[index];
      final db = await _getDatabase();
      await db.delete(
        'favourites',
        where: 'id = ?',
        whereArgs: [place.id],
      );
      favouriteList.removeAt(index);

      notifyListeners();
    }
  }
  Future<void> removeFromFavouriteListByPlace(Place place) async {
    int index = favouriteList.indexWhere((p) => p.id == place.id);
    if (index != -1) {
      final db = await _getDatabase();
      await db.delete(
        'favourites',
        where: 'id = ?',
        whereArgs: [place.id],
      );
      favouriteList.removeAt(index);
      notifyListeners();
    }
  }

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'favouriteList.db'),
      onCreate: (db, version) async {
        return db.execute(
            'CREATE TABLE favourites(id INTEGER PRIMARY KEY , name TEXT, longitude REAL, latitude REAL, image TEXT, city TEXT, category TEXT, description TEXT)'
        );

      },
      version: 2
  );
  return db;
}
  Future<void> loadPlaces() async {


      final db = await _getDatabase(); // Adjusted to use the correct database accessor

      // Assuming the table name is 'favourites' in the new app
      final data = await db.query('favourites');

      favouriteList = data.map((row) {
        // Extract values from the database row, adjust field names as necessary
        final name = row['name'] as String? ?? 'Default Name';
        final id = row['id'] as int; // Assuming 'id' is stored as an int
        final image = row['image'] as String? ?? 'Default Image Path';
        final latitude = row['latitude'] as double? ?? 0.0;
        final longitude = row['longitude'] as double? ?? 0.0;
        final city = row['city'] as String? ?? 'Default City';
        final category = row['category'] as String? ?? 'Default Category';
        final description = row['description'] as String? ?? 'Default Description';


        // Create a Place object (assuming Place constructor is similar to Item)
        return Place(id:id, name: name,imagePath: image, lat:latitude,long: longitude,city: city,category: category, description: description, );
      }).toList();

      notifyListeners();

  }


  Future<void> addToFavouriteList(String? newName, String? imagePath, double? latitude, double? longitude, String? city, String? category, String? description, int newid) async {


    final db = await _getDatabase();

    await db.insert(
      'favourites', // Assuming the table name is 'favourites'
      {
        'id': newid,
        'name': newName,
        'image': imagePath,
        'latitude': latitude,
        'longitude': longitude,
        'city': city,
        'category': category,
        'description': description,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final newPlace = Place(
      id: newid,
        name: newName!,
        imagePath: imagePath,
        lat: latitude,
        long: longitude,
        city: city,
        category: category,
        description: description
    );
    favouriteList.add(newPlace);
    notifyListeners();
  }

}












