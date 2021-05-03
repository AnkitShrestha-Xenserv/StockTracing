import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import 'repository.dart';

String _root = "https://nepse-data-api.herokuapp.com/data/todaysprice";

class ShareApiProvider implements Source {
  Client client = Client();
  final shares = List<ItemModel>();

  Future<List<ItemModel>> fetchShare() async {
    final response = await client.get(_root);
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      for (var json in parsedJson) {
        shares.add(ItemModel.fromJson(json));
      }
      return shares;
    } else {
      print('Response Error');
    }
    return shares;
  }
}
