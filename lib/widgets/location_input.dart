import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_flutter_app/helpers/location_helper.dart';
import 'package:great_places_flutter_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {

  Function onSelectPlace;
  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void showPreviewImage(double lat, double lng ){
    final previewUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = previewUrl;
    });
  }
  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      showPreviewImage(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    }catch(error){
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(isSelecting: true),
      ),
    );
    if(selectedLocation==null){
      return;
    }
    showPreviewImage(selectedLocation.latitude, selectedLocation.longitude);

    widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text("Select on Map"),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
