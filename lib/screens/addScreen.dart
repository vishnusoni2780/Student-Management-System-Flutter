import 'package:flutter/material.dart';
import 'package:sms/strings.dart';
import 'package:sms/database/studentModel.dart';
import 'package:sms/database/databaseHelper.dart';

class AddScreen extends StatefulWidget {
  AddScreen();

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _cityTextEditingController = TextEditingController();

  final List<String> _gender = ['Mr.', 'Mrs.'];
  var _selectedItemFromDropDown = '';

  @override
  void initState(){
    super.initState();
    setState(() {
      _selectedItemFromDropDown = _gender[0];
    });
  }

  void _onDropDownSelectedItem( String newValSelected){
    setState(() {
      _selectedItemFromDropDown = newValSelected;
    });
  }

  void _resetButton() {
    setState(() {
      _nameTextEditingController.text = '';
      _emailTextEditingController.text = '';
      _phoneTextEditingController.text = '';
      _cityTextEditingController.text = '';
      _selectedItemFromDropDown = _gender[0];
    });
  }

  Future<void> _saveButton() async {
    String genderSelected = _selectedItemFromDropDown;
    String nameEntered = _nameTextEditingController.text;
    String emailEntered = _emailTextEditingController.text;
    String phoneEntered = _phoneTextEditingController.text;
    String cityEntered = _cityTextEditingController.text;

    Student obj = Student(genderSelected, nameEntered, emailEntered, phoneEntered, cityEntered);
    print(obj.toString());

    Map<String, dynamic> record = obj.toMap();
    int? id = await DatabaseHelper.instance.insertRecord(record);
    print('Insert Record ID: $id');

    if (id!=0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(StringNotations().addedSuc, style: const TextStyle(letterSpacing: 2, color: Colors.black),),
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
        elevation: 20,
      ));
      _resetButton();
      Navigator.pop(context);
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
          StringNotations().appBartileAdd,
          style: const TextStyle(fontSize: 22, color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [

              const SizedBox(height: 50),
              Row(
                children: [
                  DropdownButton(
                    items: _gender.map( (String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val,style: const TextStyle(color: Colors.amber, fontSize: 15,letterSpacing: 3, fontWeight: FontWeight.bold),),
                      );
                    }).toList(),
                    value: _selectedItemFromDropDown,
                    onChanged: (String? newValSelected) {
                      _onDropDownSelectedItem(newValSelected!);
                    },
                    iconEnabledColor: Colors.amber,
                    iconSize: 50,
                    focusColor: Colors.amber,
                    dropdownColor: Colors.blueGrey,
                  ),

                  // Name Input
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _nameTextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringNotations().fillText;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: StringNotations().name,
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
                  ),
                ],
              ),


              // Email Input
              const SizedBox(height: 50),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _emailTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringNotations().fillText;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: StringNotations().email,
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



              // Phone Input
              const SizedBox(height: 50),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _phoneTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringNotations().fillText;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: StringNotations().phone,
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



              // City Input
              const SizedBox(height: 50),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _cityTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringNotations().fillText;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: StringNotations().city,
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

              // Buttons
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          _saveButton();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 45),
                        backgroundColor: Colors.amber,
                      ),
                      child: Text(StringNotations().saveButton,style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20),)
                  ),
                  const SizedBox(width: 25),
                  ElevatedButton(
                      onPressed: () {
                        _resetButton();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 45),
                        backgroundColor: Colors.amber,
                      ),
                      child: Text(StringNotations().resetbutton,style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20),)
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
