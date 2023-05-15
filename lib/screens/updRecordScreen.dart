import 'package:flutter/material.dart';

import '../database/databaseHelper.dart';
import '../database/studentModel.dart';
import '../strings.dart';

class updRecordScreen extends StatefulWidget {
  final int stID;
  const updRecordScreen( {Key? key, required this.stID}) : super(key: key);

  @override
  State<updRecordScreen> createState() => _updRecordScreenState();
}

class _updRecordScreenState extends State<updRecordScreen> {
  // ${widget.sentID}   - To access the id sent from prev screen.

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _cityTextEditingController = TextEditingController();

  final List<String> _gender = ['Mr.', 'Mrs.'];
  var _selectedItemFromDropDown = '';
  late int idFromDB;

  void _onDropDownSelectedItem( String newValSelected){
    setState(() {
      _selectedItemFromDropDown = newValSelected;
    });
  }

  void _setExistingValues() async{
    if(widget.stID != null) {
      var existingStRecord = await DatabaseHelper.instance.getStudentRecordForUpd(widget.stID);
      _nameTextEditingController.text = existingStRecord![0]['Name'];
      _emailTextEditingController.text = existingStRecord![0]['Email'];
      _phoneTextEditingController.text = existingStRecord![0]['Phone'];
      _cityTextEditingController.text = existingStRecord![0]['City'];
      _onDropDownSelectedItem(existingStRecord![0]['Prefix']);
      setState(() {
        idFromDB = existingStRecord![0]['ID'];
      });
    }
  }

  Future<void> _updButton() async {
    String genderSelected = _selectedItemFromDropDown;
    String nameEntered = _nameTextEditingController.text;
    String emailEntered = _emailTextEditingController.text;
    String phoneEntered = _phoneTextEditingController.text;
    String cityEntered = _cityTextEditingController.text;

    Student obj = Student(genderSelected, nameEntered, emailEntered, phoneEntered, cityEntered);
    print(obj.toString());

    Map<String, dynamic> record = obj.toMap();
    int? respondedID = await DatabaseHelper.instance.updateRecord(record, idFromDB);
    print('Updated Record ID: $respondedID');

    if(respondedID!=null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(StringNotations().updatedSuc, style: const TextStyle(letterSpacing: 2, color: Colors.black),),
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          elevation: 20,
        ));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _setExistingValues();
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
                            _updButton();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 45),
                          backgroundColor: Colors.amber,
                        ),
                        child: Text(StringNotations().updateLabel,style: const TextStyle(color: Colors.black ,fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20),)
                    ),
                    const SizedBox(width: 25),
                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}
