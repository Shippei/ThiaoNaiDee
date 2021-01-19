class PlacePredictios {
  String secondary_text;
  String main_text;
  String place_id;
  PlacePredictios({this.secondary_text, this.main_text, this.place_id});

  PlacePredictios.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
    main_text = json["structured_format::ing"]["main_text"];
    secondary_text = json["structured_format::ing"]["secondary_text"];
  }
}
