// import 'package:get/get.dart';
// import 'package:seller/core/database/database_initializer.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseService extends GetxService {
//   final DatabaseInitializer _databaseInitializer = DatabaseInitializer();
//   Database? _database;

//   /// Initialize the database
//   Future<DatabaseService> init() async {
//     _database = await _databaseInitializer.database;
//     return this;
//   }

//   /// Getter for the database
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _databaseInitializer.database;
//     return _database!;
//   }

//   /// Close the database
//   Future<void> close() async {
//     if (_database != null) {
//       await _database!.close();
//       _database = null;
//     }
//   }
// }
