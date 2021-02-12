import 'package:flutter/material.dart';
import 'package:vaiga_farmcare/data.dart';
import 'package:vaiga_farmcare/screens/cropDetails.dart';

class CropData extends StatefulWidget {
  @override
  _CropDataState createState() => _CropDataState();
}

class _CropDataState extends State<CropData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MASTER DATA'),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          ExpansionTile(title: Text('CROPS'), children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cropsList.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CropDetails(cropsList[index])),
                ),
                title: Text(cropsList[index].cropName),
              ),
            ),
          ]),
          ExpansionTile(title: Text('FERTILISERS'), children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cropsList.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CropDetails(cropsList[index])),
                ),
                title: Text(cropsList[index].cropName),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
