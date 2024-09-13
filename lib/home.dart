import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              _logout();

            },
          ),
        ],
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            "CRUD",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: const CircleBorder(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: donor.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 210, 207, 207),
                          blurRadius: 10,
                          spreadRadius: 10
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                              child: Text(donorSnap['blood'],style: TextStyle(
                                fontSize: 25
                              ),),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(donorSnap['name']),
                            Text(donorSnap['phone'].toString())
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(onPressed: (){
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateWidget(
                                      documentId: donorSnap.id,
                                    ),
                                  ),
                                );                            }, icon: Icon(Icons.edit),
                            iconSize: 30,
                            color: Colors.blue,),
                            IconButton(onPressed: (){
                              DeleteDonor(donorSnap.id);
                            }, icon: Icon(Icons.delete),
                            iconSize: 30,
                            color: Colors.red,
                            )               
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
void DeleteDonor(String id)
{
  donor.doc(id).delete();
}

Future<void> _logout() async{
  try{
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn',false);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route)=>false);
  }catch(error){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout Failed')));
  }
}
}
