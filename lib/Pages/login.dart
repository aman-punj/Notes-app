import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled3/Pages/newNote_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

 bool isGridOn = true;

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(20.0),
            child: Row(          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                const Text('Notes App' , style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),),
                IconButton(onPressed: (){setState(() {
                  isGridOn = !isGridOn;
                });}, icon: isGridOn?  const Icon(Icons.grid_view) : const Icon(Icons.list))          ],
            ),
            ),const SizedBox(height: 200,),
            Center(
              child: Column(
                children: [
                  Container(
                    child: Lottie.asset( 'assets/animations/empty_animation.json',
                      // height: 200.0,
                      repeat: true,
                      reverse: true,
                      animate: true,
                    )
                  ),
                  const Text('Press on + icon to add a new note' , style: TextStyle(
                    fontSize: 22 , color: Colors.grey
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return const NewNotePage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
