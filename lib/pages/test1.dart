import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:search_map_place/search_map_place.dart';
// import 'package:provider/provider.dart';
// import 'package:ThiaoNaiDee/pages/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestState();
  }
}

class _TestState extends State<TestPage> {
  GoogleMapController mapController;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();
  var googlePlace = GooglePlace("AIzaSyDRVzZ3jP3WSm-iV0q7RcRH7x5XfSdwDMs");
  final FirebaseAuth auth = FirebaseAuth.instance;

  void subdata({String email, String name, String more, String type}) async {
    await users
        .doc(email)
        .collection('faverite')
        .doc(name)
        .set({
          'name': name,
          'more': more,
          'type': type,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            )),
            title: Text('ค้นหาสถานที่'),
            //automaticallyImplyLeading: false,
            backgroundColor: Colors.cyan[200],
            centerTitle: true,
          )),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SearchMapPlaceWidget(
                hasClearButton: true,
                placeType: PlaceType.address,
                placeholder: 'ค้นหา',
                apiKey: 'AIzaSyDRVzZ3jP3WSm-iV0q7RcRH7x5XfSdwDMs',
                onSelected: (Place place) async {
                  Geolocation geolocation = await place.geolocation;
                  mapController.animateCamera(
                      CameraUpdate.newLatLng(geolocation.coordinates));
                  mapController.animateCamera(
                      CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                  subdata(
                    email: auth.currentUser.email.toString(),
                    name: place.placeId,
                    more: place.description,
                    type: place.types.toString(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: 500.0,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController googlemapcontroller) {
                    setState(() {
                      mapController = googlemapcontroller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                      zoom: 15.0, target: LatLng(21.1458, 79.0882)),
                  //mapType: MapType.satellite,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
