import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String title;
  late String desc;
}

Future<void> adasdsa() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [NoteSchema],
    directory: dir.path,
  );

  final recipes = isar.notes;
}

Future<void> insert(Isar isar, Note note) async {
  await isar.writeTxn(() async {
    await isar.notes.put(note);
    if (kDebugMode) {
      print('Note Inserted: $note');
    }
  });
}

Future<void> delete(Isar isar, Id id) async {
  await isar.writeTxn(() async {
    final success = await isar.notes.delete(id);
    if (kDebugMode) {
      print('Recipe deleted: $success');
    }
  });
}

Future<void> updateNoteById(Isar isar, Id id, String title, String desc) async {
  await isar.writeTxn(() async {
    final oldNote = await isar.notes.get(id);

    if (oldNote != null) {
      oldNote.title = title;
      oldNote.desc = desc;
      await isar.notes.put(oldNote);
    }
  });

  if (kDebugMode) {
    print('Note updated');
  }
}



Future<Isar> openIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [NoteSchema],
    directory: dir.path,
  );
  return isar;
}
