import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavoriteValue(bool newValue)
  {
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus(String token,String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 
        'https://shopping-application-481ec.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try{
      final response = await put(url,
        body: json.encode({
          'isFavorite': isFavorite,
        }));

        if(response.statusCode > 400 )
    {
        _setFavoriteValue(oldStatus);
    }

    }
    catch(error){
      print(error);
      _setFavoriteValue(oldStatus);
    }  }
}
