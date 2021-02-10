import 'dart:async';
import 'package:ThiaoNaiDee/main.dart';
import 'package:ThiaoNaiDee/pages/Divider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ThiaoNaiDee/pages/MyBottomNavBar.dart';
import 'package:ThiaoNaiDee/assist/Request.dart';
import 'package:ThiaoNaiDee/assist/method.dart';
import 'package:ThiaoNaiDee/model/address.dart';
import 'package:provider/provider.dart';
import 'package:ThiaoNaiDee/datahandle/appdata.dart';
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
  String look;
  final Geolocator _geolocator = Geolocator();
  String _isoCountryCode = "";
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 400.0;

  void locatePosition() async {
    Position position2 = await geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position2;
    // LatLng latlngPosition = LatLng(position2.latitude, position2.longitude);
    // CameraPosition cameraPosition =
    //     new CameraPosition(target: latlngPosition, zoom: 14);
    String address = await AssistMethods.searchCoordinateAddess(position2);
    if (address != null) {
      print("This is your address :" + address);
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

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

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

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

  Widget _mapWidget() {
    return GoogleMap(
      padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      //markers: _createMarker(),
      onTap: _handleTap,
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;

        //locatePosition();
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
      body: Stack(children: [
        _child,
        // GoogleMap(
        //   padding: EdgeInsets.only(
        //     bottom: bottomPaddingOfMap,
        //   ),
        //   mapType: MapType.normal,
        //   myLocationButtonEnabled: true,
        //   myLocationEnabled: true,
        //   zoomGesturesEnabled: true,
        //   zoomControlsEnabled: true,
        //   onTap: _handleTap,
        //   initialCameraPosition: CameraPosition(
        //     target: LatLng(position.latitude, position.longitude),
        //     zoom: 12.0,
        //   ),
        //   onMapCreated: (GoogleMapController controller) {
        //     _controller = controller;

        //     locatePosition();
        //   },
        // ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: 320.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.0),
                  Text(
                    "Hi there,",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    "Where to?",
                    style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 6.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text("Search Drop off")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add Home"),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Your living home address",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  DividerWidget(),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add Work"),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Your office address",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  // void findPlace(String placeName) async {
  //   if (placeName.length > 1) {
  //     String autoCompleteUrl =
  //         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890";
  //     var res = await RequestAss.getRequest(autoCompleteUrl);
  //     if (res == "failed") {
  //       return;
  //     }
  //     print("Place Res");
  //     print(res);
  //   }
  // }

  // void getPlaceDetail(String placeId, context) async {
  //   String placeDetailUrl =
  //       "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";
  //   var res = await RequestAss.getRequest(placeDetailUrl);
  //   Navigator.pop(context);
  //   if (res == "failed") {
  //     return;
  //   }
  //   if (res["status"] == "OK") {
  //     Address address = Address();
  //     address.placeName = res["result"]["name"];
  //     address.placeId = placeId;
  //     address.latitude = res["result"]["geometry"]["location"]["lat"];
  //     address.longitude = res["result"]["geometry"]["location"]["lng"];
  //     Provider.of<AppData>(context, listen: false)
  //         .updateDropOffLocationAddress(address);
  //     print("Drop: ");
  //     print(address.placeName);
  //     Navigator.pop(context, "obtainDirection");
  //   }
  // }

  // Future<String> testAddress(double latitude, double longitude) async {
  //   List<Placemark> newPlace =
  //       await _geolocator.placemarkFromCoordinates(latitude, longitude);
  //   Placemark placeMark = newPlace[0];
  //   String name = placeMark.name;
  //   // String subLocality = placeMark.subLocality;
  //   String locality = placeMark.locality;
  //   String administrativeArea = placeMark.administrativeArea;
  //   // String subAdministrativeArea = placeMark.administrativeArea;
  //   String postalCode = placeMark.postalCode;
  //   String country = placeMark.country;
  //   // String subThoroughfare = placeMark.subThoroughfare;
  //   String thoroughfare = placeMark.thoroughfare;
  //   _isoCountryCode = placeMark.isoCountryCode;
  //   return "$name, $thoroughfare, $locality, $administrativeArea, $postalCode, $country";
  // }
}
