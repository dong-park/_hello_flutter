import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoMainScreen extends StatefulWidget {
  const GeoMainScreen({Key? key}) : super(key: key);

  @override
  State<GeoMainScreen> createState() => _GeoMainScreenState();
}

class _GeoMainScreenState extends State<GeoMainScreen> {
  static final companyLatLng = LatLng(37.5291, 126.9219);
  CameraPosition cameraPosition =
      CameraPosition(target: companyLatLng, zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2, child: GoogleMap(initialCameraPosition: cameraPosition)),
          Expanded(
            child: Center(child: Text('출첵')),
          ),
        ],
      ),
    );
  }
}
