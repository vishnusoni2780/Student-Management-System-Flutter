import 'package:flutter/material.dart';
import 'package:sms/screens/updRecordScreen.dart';
import 'package:sms/strings.dart';

import '../database/databaseHelper.dart';
import 'addScreen.dart';

class CRUDsScreen extends StatefulWidget {
  const CRUDsScreen({Key? key}) : super(key: key);

  @override
  State<CRUDsScreen> createState() => _CRUDsScreenState();
}

class _CRUDsScreenState extends State<CRUDsScreen> {

  bool _isLoading = true;
  List<Map<String, dynamic>>? studentRecords ;
  int? numOfRecord;

  Future<void> _refreshStudentRecords() async {
    if(studentRecords==null){
      await Future.delayed(const Duration(seconds: 2));
      final resultSet = await DatabaseHelper.instance.readRecord();
      setState(() {
        studentRecords = resultSet;
        _isLoading = false;
        numOfRecord = resultSet?.length;
      });
    }
    else{
      final resultSet = await DatabaseHelper.instance.readRecord();
      setState(() {
        studentRecords = resultSet;
        _isLoading = false;
        numOfRecord = resultSet?.length;
      });
    }

  }


  void _deleteIcon(int index) async {
    int id = studentRecords![index]['ID'];
    int? respondedID = await DatabaseHelper.instance.deleteRecord(id);
    //print('Deleting Student Record-> respondedID: $respondedID , id: $id');
    _refreshStudentRecords();
    if(respondedID!=null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(StringNotations().deletedSuc, style: const TextStyle(letterSpacing: 2, color: Colors.black),),
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
        elevation: 20,
      ));
    }
  }

  void _updateIcon(int index){
    int id = studentRecords![index]['ID'];
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return updRecordScreen( stID: id);
    })).then((value) => _refreshStudentRecords());
  }

  void initState() {
    super.initState();
    _refreshStudentRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(
            color: Colors.black
        ),
        backgroundColor: Colors.amber,
        title: Text(
          StringNotations().appBartileCRUds,
          style: const TextStyle(fontSize: 22, color: Colors.black, letterSpacing: 2),
        ),
        centerTitle: true,
      ),

      body: _isLoading ? const Center( child: CircularProgressIndicator( color: Colors.amber,)) : RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.amber,
        onRefresh: _refreshStudentRecords,
        child: ListView.builder(
            itemCount: numOfRecord,
            itemBuilder: ( BuildContext context, int index ){
              return Card(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5), color: Colors.grey,
                  elevation: 2,
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child : Icon(Icons.perm_identity)
                    ),
                    title: Text(studentRecords![index]['Name']),
                    subtitle: Text(studentRecords![index]['Email']),
                    trailing: Wrap(
                      spacing: 15,
                      children: [
                        GestureDetector(child: Icon(Icons.edit, color: Colors.black), onTap: () { _updateIcon(index); },),
                        GestureDetector(child: Icon(Icons.delete, color: Colors.black), onTap: () { _deleteIcon(index); },),
                      ],
                    ),
                    onTap: () { _dialogBuilder(context, studentRecords, index); },
                  ));
            }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddScreen();
          })).then((value) => _refreshStudentRecords());
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add,color: Colors.black, size: 30,),
      ),
    );
  }


  Future<void> _dialogBuilder(BuildContext context, List<Map<String, dynamic>>? studentRecords, int index ) {
    int id = studentRecords![index]['ID'];
    String prefix = studentRecords![index]['Prefix'];
    String name = studentRecords![index]['Name'];

    bool _isMale = false;
    if(prefix == 'Mr.'){
      _isMale = true;
    }
    else{
      _isMale = false;
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.grey,
              title: Text('$id'),
              scrollable: true,
              content: SingleChildScrollView(
                  child: ListBody(
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage: _isMale ? const AssetImage('asset/man.png') : const AssetImage('asset/female.png'),
                          ),
                        ),

                        const Divider(
                          height: 60,
                          color: Colors.black,
                        ),

                        const SizedBox(height: 30,),
                        Text('$prefix $name',
                            style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 3,
                            )),
                        const SizedBox(height: 30),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.call,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text(studentRecords[index]['Phone'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                )),
                          ],
                        ),

                        SizedBox(height: 30,),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text(studentRecords![index]['Email'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20
                                )),
                          ],
                        ),


                        SizedBox(height: 30,),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.place,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text(studentRecords![index]['City'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 3,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                )),
                          ],
                        ),


                      ]
                  )
              )
          );
        }
    );
  }
}
