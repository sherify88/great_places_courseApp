import 'package:flutter/material.dart';
import 'package:great_places_flutter_app/models/place.dart';
import 'package:great_places_flutter_app/screens/map_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/place-detail";

  @override
  Widget build(BuildContext context) {
    final placeIdArg = ModalRoute.of(context).settings.arguments as String;
    final selectedPlace =
        Provider.of<GreatPlaces>(context).findById(placeIdArg);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => MapScreen(
                  isSelecting: false,
                  initialLocation: PlaceLocation(
                      latitude: selectedPlace.location.latitude,
                      longitude: selectedPlace.location.longitude),
                ),
              ),
            ),
            child: Text("View On Map"),textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
