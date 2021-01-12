import 'dart:async';
import 'dart:typed_data';
import 'package:ThiaoNaiDee/assist/method.dart';
import 'package:ThiaoNaiDee/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ThiaoNaiDee/pages/MyBottomNavBar.dart';
import 'package:ThiaoNaiDee/assist/requset.dart';
import 'package:ThiaoNaiDee/model/address.dart';
import 'package:provider/provider.dart';
import 'package:ThiaoNaiDee/datahandle/appdata.dart';
//import 'package:polyline/polyline.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../configmap.dart';

void main() => runApp(MyApp());

class MapPage extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {
  GoogleMapController _controller;
  Position position;
  Widget _child;
  List<Marker> myMarker = [];
  double lat1, lan1, lat2, lng2;
  Color secondaryColor = Color(0xff232c51);
  TextEditingController nameController = TextEditingController();
  //Location location = Location();

  Future<void> getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        showToast('denied');
        break;
      case GeolocationStatus.disabled:
        showToast('disabled');
        break;
      case GeolocationStatus.restricted:
        showToast('restricted');
        break;
      case GeolocationStatus.unknown:
        showToast('unknown');
        break;
      case GeolocationStatus.granted:
        showToast('Access granted');
        _getCurrentLocation();
    }
  }

  // void _setStyle(GoogleMapController controller) async {
  //   String value = await DefaultAssetBundle.of(context)
  //       .loadString('assets/map_style.json');
  //   controller.setMapStyle(value);
  // }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      // markers: Set.from(myMarker),
      onTap: _handleTap,
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12.0,
      ),

      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        // _setStyle(controller);
      },
    );
  }

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Current Location'))
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            )),
            title: Text('แผนที่'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.cyan[200],
            centerTitle: true,
          )),
      body:
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //   decoration: BoxDecoration(
          //       color: secondaryColor, border: Border.all(color: Colors.blue)),
          //   child: TextField(
          //     controller: nameController,
          //     style: TextStyle(color: Colors.white),
          //     decoration: InputDecoration(
          //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
          //         labelText: 'ค้นหา',
          //         labelStyle: TextStyle(color: Colors.white),
          //         icon: Icon(
          //           Icons.account_circle,
          //           color: Colors.white,
          //         ),
          //         border: InputBorder.none),
          //   ),
          // ),

          _child,
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890";
      var res = await RequestAss.getRequest(autoCompleteUrl);

      if (res == "failed") {
        return;
      }
      print("Place Res");
      print(res);
    }
  }

  void getPlaceDetail(String placeId, context) async {
    String placeDetailUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";
    var res = await RequestAss.getRequest(placeDetailUrl);

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }
    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updateDropOffLocationAddress(address);
      print("Drop: ");
      print(address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }

  // void getPlaceDirection() async {
  //   var initialPos = Provider.of(context, listen: false).pickUpLocation;
  //   var finalPos = Provider.of(context, listen: false).dropOffLocation;

  //   var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
  //   var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);
  //   List<LatLng> pLineCoordinates = [];
  //   Set<Polyline> poLylineSet = {};

  //   var details =
  //       await AssistMethods.obtainPlaceDirection(pickUpLatLng, dropOffLatLng);

  //   Navigator.pop(context);
  //   print(details.encodedPoints);

  //   PolylinePoints polylinePoints = PolylinePoints();
  //   List<PointLatLng> decodedPolyLinePointsResult =
  //       polylinePoints.decodePolyline(details.encodedPoints);

  //   pLineCoordinates.clear();

  //   if (decodedPolyLinePointsResult.isEmpty) {
  //     decodedPolyLinePointsResult.forEach((PointLatLng pointLatLag) {
  //       pLineCoordinates
  //           .add(LatLng(pointLatLag.latitude, pointLatLag.longitude));
  //     });
  //   }

  //   poLylineSet.clear();

  //   setState(() {
  //     Polyline polyline = Polyline(
  //       color: Colors.red,
  //       polylineId: PolylineId("PolylineID"),
  //       jointType: JointType.round,
  //       points: pLineCoordinates,
  //       width: 5,
  //       startCap: Cap.roundCap,
  //       endCap: Cap.roundCap,
  //       geodesic: true,
  //     );

  //     poLylineSet.add(polyline);
  //   });
  // }
}
