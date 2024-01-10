import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/src/model/note_database.dart';

class NewNotePage extends StatefulWidget {

  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  void createNote(BuildContext context) {
    String noteText = textController.text.trim(); // Remove leading/trailing spaces
    String noteBody = bodyController.text.trim(); // Remove leading/trailing spaces

    if (noteText.isNotEmpty && noteBody.isNotEmpty) {
      context.read<NoteDatabase>().addNote(noteText , noteBody );
      Navigator.of(context).pop(); // Close the page after adding the note
    } else {
      // Display a message indicating that the note is empty
      ScaffoldMessenger.of(context).showSnackBar(
       const  SnackBar(
          content: Text('Cannot save an empty note.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        actions: [
          IconButton(onPressed: () => createNote(context), icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              maxLines: null, // Allow multiple lines for the note text
            ),const SizedBox(height: 20,),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: 'Enter your note',
                border: OutlineInputBorder(),
              ),
              maxLines: null, // Allow multiple lines for the note text
            ),
          ],
        ),
      ),
    );
  }
}
