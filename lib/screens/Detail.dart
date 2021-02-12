import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vaiga_farmcare/models/StreamParser.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:plant_app/screens/details/components/body.dart';

import '../constants.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(size: size),
          TitleAndPrice(title: "NODE 1L3", country: "TOMATO", price: 440),
          SizedBox(height: kDefaultPadding),
          Row(
            children: <Widget>[
              // SizedBox(
              //   width: size.width / 2,
              //   height: 84,
              //   child: FlatButton(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(20),
              //       ),
              //     ),
              //     color: kPrimaryColor,
              //     onPressed: () {},
              //     child: Text(
              //       "Buy Now",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 16,
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: FlatButton(
                  onPressed: () {},
                  child: Text("Description"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../constants.dart';
// import 'icon_card.dart';

class ImageAndIcons extends StatefulWidget {
  const ImageAndIcons({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _ImageAndIconsState createState() => _ImageAndIconsState();
}

class _ImageAndIconsState extends State<ImageAndIcons> {
  final databaseRef = FirebaseDatabase.instance.reference();
  DatabaseReference _dhtref = FirebaseDatabase.instance.reference().child('');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dhtref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            var _dht = DHT.fromJson(snapshot.data.snapshot.value['Node1']);
            print("DHT: ${_dht.solidTEmp} / ${_dht.humidity} / ${_dht.temp}");
            return Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
              child: SizedBox(
                height: widget.size.height * 0.8,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding * 3),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                icon: SvgPicture.asset(
                                    "assets/icons/back_arrow.svg"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconCard(icon: "assets/icons/sun.svg"),
                                  Text(
                                    '125 lux',
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconCard(icon: "assets/icons/icon_4.svg"),
                                  Text(
                                    _dht.smoistNow.toString(),
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconCard(icon: "assets/icons/icon_3.svg"),
                                  Text(
                                    _dht.humidity.toString(),
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconCard(icon: "assets/icons/icon_2.svg"),
                                  Text(
                                    _dht.temp.toString(),
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: widget.size.height * 0.7,
                      width: widget.size.width * 0.50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(63),
                          bottomLeft: Radius.circular(63),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 60,
                            color: kPrimaryColor.withOpacity(0.29),
                          ),
                        ],
                        image: DecorationImage(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/img.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../constants.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    Key key,
    this.icon,
  }) : super(key: key);

  final String icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      padding: EdgeInsets.all(kDefaultPadding / 2),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 22,
            color: kPrimaryColor.withOpacity(0.22),
          ),
          BoxShadow(
            offset: Offset(-15, -15),
            blurRadius: 20,
            color: Colors.white,
          ),
        ],
      ),
      child: SvgPicture.asset(icon),
    );
  }
}

// import 'package:flutter/material.dart';

// import '../../../constants.dart';

class TitleAndPrice extends StatelessWidget {
  const TitleAndPrice({
    Key key,
    this.title,
    this.country,
    this.price,
  }) : super(key: key);

  final String title, country;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: kTextColor, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: country,
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
