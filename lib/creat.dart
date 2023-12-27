import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donorlist');
  final txtcntrl1 = TextEditingController();
  final txtcntrl2 = TextEditingController();

  final List<String> bldgrp = ["A+", "A-", "B", "B+", "O+", "O", "AB+", "AB-"];
  String selectedgrp = "";

  void adddonor() {
    final data = {
      'name': txtcntrl1.text,
      'group': selectedgrp,
      'phone': txtcntrl2.text
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Donor Details"),
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
                adddonor();
              },
              child: Text("submit"),
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