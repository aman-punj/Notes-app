import 'package:flutter/material.dart';
import 'package:untitled3/Pages/edit_note.dart';
import 'package:untitled3/src/model/note.dart';

class TileView extends StatelessWidget {
  const TileView({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            note.mainBodyText,
            style: const TextStyle(
                fontWeight: FontWeight.w300, fontSize: 18),
          )
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNotePage(
                noteId: note.id,
                initialText: note.text,
              ),
            ),
          );
        },
      ),
    );
  }
}
