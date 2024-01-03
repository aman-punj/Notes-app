import 'dart:math';
import 'package:flutter/material.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}



class _NewNotePageState extends State<NewNotePage> {

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();



@override
void dispose(){
  super.dispose();
  log(_titleController.text as num);
  log(_bodyController.text as num);

  _titleController.dispose();
  _bodyController.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                ],
              ),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(fontSize: 26),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Title'),
              ),
              TextFormField(
                controller: _bodyController,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Description'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
