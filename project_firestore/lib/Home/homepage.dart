import 'package:flutter/material.dart';
import 'package:project_firestore/Home/Pages/Favourites_List_Page.dart';
import 'package:project_firestore/Home/Pages/UserHome.dart';
import 'package:project_firestore/Utils/MyColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_firestore/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _sampledata1 = TextEditingController();

  /// BOTTOM NAVIGATION BAR
  int _selectedIndex = 0;

  void _navgateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> widgetList = [
    UserHome(),
    Favourites_List_Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
        backgroundColor: AppColors.mainColor,
      ),

      body: widgetList[_selectedIndex],

// BOTTOM NAVINGATION BAR

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _navgateBottomBar,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_outlined),
            label: 'My music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
        selectedItemColor: AppColors.mainColor,
      ),

      /// FLOATING ACTION BUTTON

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
              backgroundColor: AppColors.buttonBackgroundColor,
              context: context,
              builder: (context) {
                return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 20, right: 20, left: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 0.0),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _sampledata1,
                                decoration: InputDecoration(
                                  hintText: 'Add a new Song',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20, right: 20),
                            child: ElevatedButton(
                              child: Text(
                                '+',
                                style: TextStyle(fontSize: 40),
                              ),
                              onPressed: () {
                                Map<String, dynamic> data = {
                                  'Title': _sampledata1.text,
                                  'FavStatus': false,
                                  'Createdat': DateTime.now().toString()
                                };
                                FirebaseFirestore.instance
                                    .collection('test')
                                    .doc(DateTime.now().toString())
                                    .set(data);
                                Navigator.pop(context);
                                _sampledata1.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.mainColor,
                                  minimumSize: Size(60, 60),
                                  elevation: 10),
                            ),
                          )
                        ],
                      ),
                    ));
              });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
