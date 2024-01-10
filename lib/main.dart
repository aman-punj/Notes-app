import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Pages/note_preview.dart';
import 'package:untitled3/Pages/main_notelist_page.dart';
import 'package:untitled3/src/model/note_database.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialise();

  runApp(ChangeNotifierProvider(
    create: (context) => NoteDatabase(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // Set the initial light theme
      darkTheme: ThemeData.dark(),
      // Set the initial dark theme
      themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? ThemeMode.dark // Choose dark theme based on system brightness
          : ThemeMode.light,
      home: const MikoPage(),
    );
  }
}
