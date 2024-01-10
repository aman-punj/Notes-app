import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled3/Pages/edit_note.dart';
import 'package:untitled3/Pages/note_preview.dart';
import 'package:untitled3/Pages/add_new_note.dart';
import 'package:untitled3/src/model/note.dart';
import 'package:untitled3/src/model/note_database.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/widgets/list_tile.dart';

class MikoPage extends StatefulWidget {
  const MikoPage({Key? key}) : super(key: key);

  @override
  State<MikoPage> createState() => _MikoPageState();
}

class _MikoPageState extends State<MikoPage> {
  final textController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNote();
  }

  void readNote() {
    context.read<NoteDatabase>().fetchNote();
  }

  bool isGridOn = false;
  bool isDeleted = false;

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNote;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes app"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isGridOn = !isGridOn;
                  });
                },
                icon: isGridOn
                    ? const Icon(Icons.grid_view)
                    : const Icon(Icons.list)),
          )
        ],
      ),
      body: currentNotes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Lottie.asset(
                    'assets/animations/empty_animation.json',
                    // height: 200.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  )),
                  const Text(
                    'Press on + icon to add a new note',
                    style: TextStyle(fontSize: 22, color: Colors.grey),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];

                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NoteDetailsPage(
                              title: note.text, body: note.mainBodyText)));
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Delete Note'),
                                content: Column(
                                  children: [
                                    Lottie.asset(
                                      'assets/animations/delete animation.json',
                                      // height: 200.0,
                                      repeat: true,
                                      // reverse: true,
                                      animate: true,
                                    ),
                                    const Text(
                                        'Are you sure you want to delete this note?'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      noteDatabase.deleteNote(note.id);

                                      Navigator.of(context).pop();
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Deleted'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ));
                    },
                    child: isGridOn
                        ? TileView(note: note)
                        : Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            child: const SizedBox(
                              child: Text(' This is still under development '),
                            )));
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewNotePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
