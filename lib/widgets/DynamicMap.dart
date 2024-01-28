import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourismappofficial/Places/place.dart';

class MapSample extends StatefulWidget {
  final Place place;
  const MapSample(this.place, {Key? key}) : super(key: key); // Added Key parameter

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  @override
  Widget build(BuildContext context) {
    return SizedBox( // Replaced Container with SizedBox
      height: 200,
      width: MediaQuery.of(context).size.width / 2,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.place.lat!, widget.place.long!),
          zoom: 16.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('${widget.place.name}'),
            position: LatLng(widget.place.lat!, widget.place.long!),
          ),
        },
      ),
    );
  }
}
