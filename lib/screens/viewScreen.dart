import 'package:flutter/material.dart';
import 'package:sms/screens/addScreen.dart';
import 'package:sms/strings.dart';
import 'package:sms/database/studentModel.dart';
import 'package:sms/database/databaseHelper.dart';


class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  bool _isLoading = true;
  List<Map<String, dynamic>>? studentRecords;
  int? numOfRecord;

  Future<void> _refreshStudentRecords() async {
    await Future.delayed(const Duration(seconds: 2));
    final resultSet = await DatabaseHelper.instance.readRecord();
    setState(() {
      studentRecords = resultSet;
      _isLoading = false;
      numOfRecord = resultSet?.length;
    });
  }

  @override
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
          StringNotations().appBartileView,
          style: const TextStyle(fontSize: 22, color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
      ),

      body: _isLoading ? const Center( child: CircularProgressIndicator( color: Colors.amber,)) : RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.amber,
        onRefresh: _refreshStudentRecords ,
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
                    trailing: GestureDetector(child: Icon(Icons.list_alt_outlined, color: Colors.black), onTap: () { _dialogBuilder(context, studentRecords, index); },),
                  ));
            }
        ),
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