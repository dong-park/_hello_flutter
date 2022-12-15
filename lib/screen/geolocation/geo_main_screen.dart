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
  Circle withinDistanceCircle = Circle(
      circleId: CircleId("withinDistanceCircle"),
      center: companyLatLng,
      fillColor: Colors.blue.withOpacity(0.5),
      radius: 100,
      strokeColor: Colors.blue,
      strokeWidth: 1);

  Circle notWithinDistanceCircle = Circle(
      circleId: CircleId("notWithinDistanceCircle"),
      center: companyLatLng,
      fillColor: Colors.red.withOpacity(0.5),
      radius: 100,
      strokeColor: Colors.red,
      strokeWidth: 1);

  Marker marker = Marker(
    markerId: MarkerId("1"),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == "위치 권한이 허용 되었습니다.") {
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false;
                  print('why not change');

                  if (snapshot.data != null) {
                    final start = snapshot.data!;
                    final end = companyLatLng;

                    print(snapshot.data);
                    print(companyLatLng);

                    double between = Geolocator.distanceBetween(
                        start.latitude,
                        start.longitude,
                        end.latitude,
                        end.longitude
                    );

                    if (between < 100) {
                      isWithinRange = true;
                    }

                  }



                  return Column(
                    children: [
                      _Map(
                        cameraPosition: cameraPosition,
                        circle: isWithinRange
                            ? withinDistanceCircle
                            : notWithinDistanceCircle,
                        marker: marker,
                      ),
                      Expanded(
                        child: Center(child: Text('출첵')),
                      ),
                    ],
                  );
                });
          } else {
            return Center(
              child: Text(snapshot.data.toString()),
            );
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

class _Map extends StatelessWidget {
  final CameraPosition cameraPosition;
  final Circle circle;
  final Marker marker;

  const _Map(
      {Key? key,
      required this.cameraPosition,
      required this.circle,
      required this.marker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: GoogleMap(
            initialCameraPosition: cameraPosition,
            circles: <Circle>{circle},
            markers: <Marker>{marker},
            myLocationEnabled: true));
  }
}
