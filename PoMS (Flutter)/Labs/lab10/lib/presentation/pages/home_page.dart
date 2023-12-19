import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab10/firestore.dart';
import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirestoreService firestoreService=FirestoreService();
  final TextEditingController textController=TextEditingController();

  void openMusicBox({String? docId}){
    showDialog(context: context, builder: (context)=>AlertDialog(
      content: TextField(
        controller:textController,
      ),
      actions: [
        ElevatedButton(onPressed: ()
        {if(docId==null){
          firestoreService.addMusic(textController.text, textController.text, textController.text);}
        else{firestoreService.updateMusic(docId, textController.text);}
          textController.clear();
          Navigator.pop(context);
          }, child: Text("Add"),)
      ],
    ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("HomePage"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:openMusicBox,
           child:const Icon(Icons.add),
    ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getMusicStream(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List musicList=snapshot.data!.docs;
              return ListView.builder(
                itemCount: musicList.length,
                  itemBuilder: (context,index){
                DocumentSnapshot document=musicList[index];
                String docID=document.id;

                Map<String,dynamic> data =
                document.data() as Map<String,dynamic>;
                String musicText=data['genre'];

                return ListTile(
                  title: Text(musicText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>openMusicBox(docId: docID),
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deleteMusic(docID),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )


                );
              }
              );
            }
            else{return const Text("no music");}
          }
          )
        
        
        
        
        
        
        
        
        /*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Welcome Home buddy!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            )),

            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
                showToast(message: "Successfully signed out");
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),

          ],
        )*/
    );
  }
}
