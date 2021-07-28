import 'package:flutter/material.dart';
import 'package:great_places_flutter_app/providers/great_places.dart';
import 'package:great_places_flutter_app/screens/add_place_screen.dart';
import 'package:great_places_flutter_app/screens/place_detail_screen.dart';
import 'package:great_places_flutter_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),routes: {
          AddPlaceScreen.routeName: (ctx)=> AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx)=> PlaceDetailScreen(),
      },
      ),
    );
  }
}
