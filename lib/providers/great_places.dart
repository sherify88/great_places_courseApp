import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_flutter_app/helpers/db_helper.dart';
import 'package:great_places_flutter_app/models/place.dart';
import 'package:great_places_flutter_app/helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: updatedLocation,
        image: pickedImage);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_lat": newPlace.location.latitude,
      "loc_lng": newPlace.location.longitude,
      "address": newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placesMap = await DBHelper.getData("user_places");
    _items = placesMap
        .map(
          (mapItem) => Place(
            id: mapItem["id"],
            title: mapItem["title"],
            location: PlaceLocation(
              latitude: mapItem["loc_lat"],
              longitude: mapItem["loc_lng"],
              address: mapItem["address"],
            ),
            image: File(
              mapItem["image"],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
  Place findById(String id){
    return _items.firstWhere((element) => element.id==id);
  }
}
