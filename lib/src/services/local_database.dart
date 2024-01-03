// import 'dart:js_interop';
//
// import 'package:isar/isar.dart';
//
//
// class LocalDBService{
//
//
//   late Future<Isar> db;
//
//   LocalDBService(){
//     db = openDB();
//   }
//
//   Future<Isar> openDB() async{
//     if(Isar.instanceNames.isEmpty){
//       return await Isar.open([], inspector: true, directory: '');
//     }
//     return Future.value(Isar.getInstance());
//   }
// }