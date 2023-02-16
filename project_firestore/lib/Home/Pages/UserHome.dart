import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_firestore/Utils/MyColors.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  CollectionReference<Map<String, dynamic>>? _firebase;
  @override
  void initState() {
    _firebase = FirebaseFirestore.instance.collection('test');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firebase!.orderBy("Createdat", descending: true).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // if(snapshot.data!.docs[index]['FavStatus']){

                  // }
                  return Column(
                    children: [
                      Container(
                        child: ListTile(
                            title: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: 500,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['Title'],
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  snapshot.data!.docs[index]['FavStatus']
                                      ? InkWell(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('test')
                                                .doc(snapshot.data!.docs[index]
                                                    .reference.id)
                                                .update({'FavStatus': false});
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: AppColors.mainColor,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('test')
                                                .doc(snapshot.data!.docs[index]
                                                    .reference.id)
                                                .update({'FavStatus': true});
                                          },
                                          child: Icon(
                                            Icons.favorite_border_outlined,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        )),
                      ),
                    ],
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
