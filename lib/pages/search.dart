import 'package:ThiaoNaiDee/assist/Request.dart';
import 'package:ThiaoNaiDee/model/address.dart';
import 'package:ThiaoNaiDee/model/placepredic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ThiaoNaiDee/datahandle/appdata.dart';
import '../configmap.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenStage createState() => _SearchScreenStage();
}

class _SearchScreenStage extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictios> placePredictionsList = [];
  @override
  Widget build(BuildContext context) {
    // String placeAddress =
    //     Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    String placeAddress = '555';
    pickUpTextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 20.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Stack(
                    children: [
                      Icon(Icons.arrow_back),
                      Center(
                        child: Text(
                          "Set Drop off",
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: "Brand-Bold"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: pickUpTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Pickup Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (val) {
                                findPlace(val);
                              },
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Pickup Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          (placePredictionsList.length > 0)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        placePredictios: placePredictionsList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: placePredictionsList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container(),
        ],
      ),
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
      if (res["status" == "OK"]) {
        var predictions = res["predictios"];
        var placelist = (predictions as List)
            .map((e) => PlacePredictios.fromJson(e))
            .toList();
        setState(() {
          placePredictionsList = placelist;
        });
      }
      print("Place Res");
      print(res);
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictios placePredictios;
  PredictionTile({Key key, this.placePredictios}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return Container(
        child: Row(
      children: [
        Icon(Icons.add_location),
        SizedBox(
          width: 14.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              placePredictios.main_text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              placePredictios.secondary_text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ],
    ));
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
