import 'package:http/http.dart' as http;
import 'dart:convert';

class Networker {
  Networker(this.Url);

  final String Url;
  //'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'

  Future getData() async {
    http.Response response = await http.get(Url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
