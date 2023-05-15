import 'package:flutter/material.dart';
import 'package:sms/database/databaseHelper.dart';
import 'package:sms/strings.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idForDeleteController = TextEditingController();

  void cancel_button(){
    _idForDeleteController.clear();
    Navigator.pop(context);
  }

  void delete_button() async{
    int id = int.parse(_idForDeleteController.text);
    bool isStudentExist = await DatabaseHelper.instance.checkForStudentId(id);

    if(isStudentExist){
      int? respondedID = await DatabaseHelper.instance.deleteRecord(id);
      if(respondedID!=null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(StringNotations().deletedSuc, style: const TextStyle(letterSpacing: 2, color: Colors.black),),
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          elevation: 20,
        ));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(StringNotations().stDoesntExists, style: const TextStyle(letterSpacing: 2, color: Colors.black),),
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
        elevation: 20,
      ));
    }
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
          StringNotations().appBartileDel,
          style: const TextStyle(fontSize: 22, color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
          child: ListView(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _idForDeleteController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringNotations().fillText;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: StringNotations().enterID,
                    labelStyle: const TextStyle(color: Colors.amber,letterSpacing: 2),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.amber,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2
                      ),
                    ),
                    errorStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 15
                    )
                ),
              ),

              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () { delete_button(); }, style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                    backgroundColor: Colors.amber,
                  ),
                      child: Text(StringNotations().deleteLabel,style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20),)
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(onPressed: () { cancel_button(); }, style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                    backgroundColor: Colors.amber,
                  ),
                      child: Text(StringNotations().cancelButton,style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20),)
                  ),
                ],
              ),


            ],
          ),
        ),
      )
    );
  }
}
