import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wfoodalbayt/src/model/ModelRating.dart';

class ApiCentersServices {
  static const _serviceUrl = 'http://192.168.43.165:4000/api/1/reviews';
  static final _headers = {'Content-Type': 'application/json'};

  Future<ModelRating> createCenters(ModelRating modelRateings) async {
    try {
      String json = _toJson(modelRateings);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json).then(
        (response) {
          print("Response status: ${response.statusCode}");
          print("Response body: ${response.body}");
        },
      );
      var c = _fromJson(response.body);
      return c;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  ModelRating _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var modelRateings = new ModelRating();
    modelRateings.id = map['id'];
    modelRateings.subfieldId = map['subfield_id'];
    modelRateings.clientId = map['client_id'];
    modelRateings.review = map['review'];
    modelRateings.rate = map['rate'];
    return modelRateings;
  }

  String _toJson(ModelRating modelRateings) {
    var mapData = new Map();
    mapData["_id"] = modelRateings.id;
    mapData["subfield_id"] = modelRateings.subfieldId;
    mapData["client_id"] = modelRateings.clientId;
    mapData["review"] = modelRateings.review;
    mapData["rate"] = modelRateings.rate;
    String json = jsonEncode(mapData);
    return json;
  }
}
