import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  final String nme, phn, grp, id;
  const UpdateUser(
      {super.key,
      required this.nme,
      required this.phn,
      required this.grp,
      required this.id});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donorlist');
  final txtcntrl1 = TextEditingController();
  final txtcntrl2 = TextEditingController();

  final List<String> bldgrp = ["A+", "A-", "B", "B+", "O+", "O", "AB+", "AB-"];
  String? selectedgrp = "";

  void updateuser(docid) {
    final data = {
      'name': txtcntrl1.text,
      'phone': txtcntrl2.text,
      'group': selectedgrp
    };
    donor.doc(docid).update(data);
  }

  @override
  Widget build(BuildContext context) {
    txtcntrl1.text = widget.nme;
    txtcntrl2.text = widget.phn;
    selectedgrp = widget.grp;
    var docid = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Details"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: txtcntrl1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Name"),
                  hintText: "Enter name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: txtcntrl2,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Number"),
                  hintText: "Enter Phone number"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: DropdownButtonFormField(
                value: selectedgrp,
                decoration: InputDecoration(label: Text("select blood group")),
                items: bldgrp
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: ((value) {
                  selectedgrp = value.toString();
                })),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                updateuser(docid);
              },
              child: Text("update"),
              style: ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50))),
            ),
          )
        ],
      ),
    );
  }
}