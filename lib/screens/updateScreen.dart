import 'package:flutter/material.dart';
import 'package:sms/screens/updRecordScreen.dart';
import 'package:sms/strings.dart';
import '../database/databaseHelper.dart';
import '../database/studentModel.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idForUpdateController = TextEditingController();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _cityTextEditingController = TextEditingController();


  @override
  void initState(){
    super.initState();
  }

  void cancel_button() {
    _idForUpdateController.clear();
    Navigator.pop(context);
  }

  void validateStudentIDForUpdate() async {
    int id = int.parse(_idForUpdateController.text);
    bool isStudentExist = await DatabaseHelper.instance.checkForStudentId(id);

    if(isStudentExist){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
          return updRecordScreen( stID: id);
        }));
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
          StringNotations().appBartileUpd,
          style: const TextStyle(fontSize: 22, color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 200, 15, 0),
          child: ListView(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _idForUpdateController,
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
                  ElevatedButton(onPressed: () { validateStudentIDForUpdate(); }, style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                    backgroundColor: Colors.amber,
                  ),
                      child: Text(StringNotations().updateLabel,style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20),)
                  ),

                  const SizedBox(width: 10,),

                  ElevatedButton(onPressed: () { cancel_button(); },style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                    backgroundColor: Colors.amber,
                  ),
                      child: Text(StringNotations().cancelButton,style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20),)
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}

