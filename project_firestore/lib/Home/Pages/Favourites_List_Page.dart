import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_firestore/Utils/MyColors.dart';

class Favourites_List_Page extends StatefulWidget {
  Favourites_List_Page({
    super.key,
  });

  @override
  State<Favourites_List_Page> createState() => _Favourites_List_PageState();
}

class _Favourites_List_PageState extends State<Favourites_List_Page> {
  CollectionReference<Map<String, dynamic>>? _firebase;
  @override
  void initState() {
    _firebase = FirebaseFirestore.instance.collection('test');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firebase!.snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    print(index);
                    if (snapshot.data!.docs[index]['FavStatus']) {
                      return Column(
                        children: [
                          ListTile(
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
                                                  .doc(snapshot.data!
                                                      .docs[index].reference.id)
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
                                                  .doc(snapshot.data!
                                                      .docs[index].reference.id)
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
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  });
            } else {
              return Center(
                child: Text(
                  'No Fav',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                ),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
