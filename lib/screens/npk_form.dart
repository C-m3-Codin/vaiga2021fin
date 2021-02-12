import 'package:flutter/material.dart';

class NPKFormPage extends StatefulWidget {
  @override
  _NPKFormPageState createState() => _NPKFormPageState();
}

String nitrogen = '';
String phosphorous = '';
String potassium = '';

class _NPKFormPageState extends State<NPKFormPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Fill in the NPK details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusColor: Colors.black,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: "Nitrogen",
                      hintStyle: TextStyle(fontSize: 20)),
                  onChanged: ((String newValue) {
                    nitrogen = newValue;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusColor: Colors.black,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: "Phosphorous",
                      hintStyle: TextStyle(fontSize: 20)),
                  onChanged: ((String newValue) {
                    nitrogen = newValue;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusColor: Colors.black,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: "Potassium",
                      hintStyle: TextStyle(fontSize: 20)),
                  onChanged: ((String newValue) {
                    nitrogen = newValue;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
