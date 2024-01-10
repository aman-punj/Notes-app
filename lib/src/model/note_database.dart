import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled3/src/model/note.dart';


class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialise() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> currentNote = [];

  Future<void> addNote(String title, String mainBodyText) async {
    final newNote = Note(text: title, mainBodyText: mainBodyText);

    await isar.writeTxn(() => isar.notes.put(newNote));
    fetchNote();
  }

  Future<void> fetchNote() async {
    final fetchedNote = await isar.notes.where().findAll();
    currentNote.clear();
    currentNote.addAll(fetchedNote);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNote();
  }

  Future<void> updateNote(int id, String newTitle, String newMainBodyText) async {
    final existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = newTitle;
      existingNote.mainBodyText = newMainBodyText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNote();
    }
  }
}