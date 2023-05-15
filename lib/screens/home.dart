import 'package:flutter/material.dart';
import 'package:sms/strings.dart';
import 'package:sms/screens/addScreen.dart';
import 'package:sms/screens/viewScreen.dart';
import 'package:sms/screens/updateScreen.dart';
import 'package:sms/screens/deleteScreen.dart';
import 'package:sms/database/databaseHelper.dart';

import 'combos_screen.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          StringNotations().title,
        style: const TextStyle(fontSize: 22, color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body:Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 225, 5, 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return AddScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 70),
                    backgroundColor: Colors.amber,
                  ),
                  child: Text(StringNotations().addLabel,
                        style: const TextStyle( fontSize: 18, color: Colors.black)),
                ),
                const SizedBox(width: 45,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const ViewScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 70),
                    backgroundColor: Colors.amber,
                  ),
                  child: Text(StringNotations().viewLabel,
                      style: const TextStyle( fontSize: 18, color: Colors.black)),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const UpdateScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 70),
                    backgroundColor: Colors.amber,
                  ),
                  child: Text(StringNotations().updateLabel,
                      style: const TextStyle( fontSize: 18, color: Colors.black)),
                ),
                const SizedBox(width: 45,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const DeleteScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 70),
                    backgroundColor: Colors.amber,
                  ),
                  child: Text(StringNotations().deleteLabel,
                      style: const TextStyle( fontSize: 18, color: Colors.black)),
                ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CRUDsScreen();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 70),
                  backgroundColor: Colors.amber,
                ),
                child: Text(StringNotations().comboButton,
                    style: const TextStyle( fontSize: 18, color: Colors.black)),
              ),
            ],
          ),
        ]
      ),
    );
  }
}
