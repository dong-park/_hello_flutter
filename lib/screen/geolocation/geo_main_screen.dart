import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
      body: FutureBuilder(
        future: checkPermission(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          print(snapshot.data);

          if(snapshot.data == "위치 권한이 허용 되었습니다."){
            return Column(
              children: [
                Expanded(
                    flex: 2, child: GoogleMap(initialCameraPosition: cameraPosition)),
                Expanded(
                  child: Center(child: Text('출첵')),
                ),
              ],
            );
          } else {
            return Center(child: Text(snapshot.data.toString()),);
          }
        },
      ),
    );
  }

  Future<String> checkPermission() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      return "위치 권한을 허용 해주세요.";
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return "위치 권한을 허용 해주세요.";
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return "위치 권한을 허용 해주세요.";
    }

    return "위치 권한이 허용 되었습니다.";
  }
}
