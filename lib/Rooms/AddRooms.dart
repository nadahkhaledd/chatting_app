import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRooms extends StatefulWidget {
  @override
  static const String routeName = 'AddRooms';

  @override
  _AddRoomsState createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {

  TextEditingController roomController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;
  List<String> category = [
    "Sports",
    "Movies",
    "Music",
  ];
  String dropdownValue = 'One';
  String selectedCategory = "Sports";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Chat App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(4, 8),
                        color: Colors.grey,
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ]),
                margin: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Create New Room',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Image(
                              image: AssetImage(
                                  'assets/icons/group-1824146_1280.png')
                          ),
                          defaultTextFormField(
                              context: context,
                              controller: roomController,
                              type: TextInputType.text,
                              label: 'Room Name',
                              messageValidate: "Room Name Can't be empty",
                              fontColor: Colors.grey),
                          DropdownButton<String>(
                            value: selectedCategory,
                            // icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            //style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                            items: category
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(children: [
                                  Text(value),
                                  SizedBox(
                                    width: widthResponsive(context: context, width: 20),
                                  ),
                                  Image(
                                    image: AssetImage('assets/icons/'+value+'.png'),
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  )
                                ]),
                              );
                            }).toList(),
                          ),
                          defaultTextFormField(
                              context: context,
                              controller: descriptionController,
                              type: TextInputType.text,
                              label: 'Room Description',
                              messageValidate: "Room description Can't be empty",
                              fontColor: Colors.grey),
                          SizedBox(
                            height:
                            heightResponsive(context: context, height: 30),
                          ),
                          ElevatedButton(onPressed: (){
                            if(_formKey.currentState?.validate()==true)
                              {
                                addRoom();
                              }
                          },
                            child:  isLoading? Center(child: CircularProgressIndicator()):Text('Create',style: TextStyle(
                              fontSize: 17
                            )
                            ,),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  void addRoom() {
    setState(() {
      isLoading = true;
    });
    final docRef=getRoomsCollectionConvertor().doc(); //Create document in firestor

    Room room=Room(
        category: selectedCategory,
        description: descriptionController.text,
        id: docRef.id,
        name: roomController.text,
    );
    docRef.set(room).then((value) => {
    setState(() {
    isLoading = true;
    }),
      Fluttertoast.showToast(msg: 'Room Added Successfully',
      toastLength:Toast.LENGTH_LONG),
      Navigator.pop(context),
    });
  }
}
