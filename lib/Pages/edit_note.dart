import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/src/model/note_database.dart';

class EditNotePage extends StatefulWidget {
  final int noteId;
  final String initialText;

  const EditNotePage(
      {super.key, required this.noteId, required this.initialText});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _textEditingController;
  late TextEditingController _bodyEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
    _bodyEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _bodyEditingController.dispose();
    super.dispose();
  }

  void updateNote() {
    final newText = _textEditingController.text;
    final newBody = _bodyEditingController.text;
    if (newText.isNotEmpty) {
      context.read<NoteDatabase>().updateNote(widget.noteId, newText, newBody);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fill both title and note.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: updateNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Edit your title',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _bodyEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Edit your note',
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
