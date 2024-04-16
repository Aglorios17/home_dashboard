import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeorideMap extends StatelessWidget {

  const GeorideMap({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    LatLng center = LatLng(latitude, longitude);


    void onMapCreated(GoogleMapController controller) {
      // You can perform actions here when the map is created
      // For example, you can set the initial camera position
      controller.moveCamera(CameraUpdate.newLatLng(center));
    }

    return(SafeArea(
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 11.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("Bike"),
            position: LatLng(latitude, longitude),
          ), // Marker
        }, // markers
    ), // GoogleMap
      )
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
        if (snapchat.hasData) {
          return SfMaps(
            layers: [
              MapTileLayer(
                initialFocalLatLng: MapLatLng(
                    latitude, longitude),
                initialZoomLevel: 5,
                initialMarkersCount: 1,
                urlTemplate: 'https://www.openstreetmap.org/{z}/{x}/{y}.png',
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    latitude: latitude,
                    longitude: longitude,
                    size: const Size(20, 20),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red[800],
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      }, future: null,
    );
  }
*/
}

