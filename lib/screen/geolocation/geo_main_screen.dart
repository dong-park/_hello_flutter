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

  Circle chulcheckDoneCircle = Circle(
      circleId: CircleId("chulcheckDoneCircle"),
      center: companyLatLng,
      fillColor: Colors.green.withOpacity(0.5),
      radius: 100,
      strokeColor: Colors.green,
      strokeWidth: 1);

  Marker marker = Marker(
    markerId: MarkerId("1"),
    position: companyLatLng,
  );

  bool isChulCheck = false;

  GoogleMapController? mapController;

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

                  if (snapshot.data != null) {
                    final start = snapshot.data!;
                    final end = companyLatLng;

                    double between = Geolocator.distanceBetween(start.latitude,
                        start.longitude, end.latitude, end.longitude);

                    if (between < 100) {
                      isWithinRange = true;
                    }
                  }

                  return Column(
                    children: [
                      AppBar(
                        title: Text(
                          '오늘도 출근',
                          style: TextStyle(color: Colors.blue),
                        ),
                        backgroundColor: Colors.white,
                        actions: [
                          IconButton(
                              onPressed: onLocationPressed,
                              icon: Icon(
                                Icons.my_location,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      _Map(
                        cameraPosition: cameraPosition,
                        circle: isChulCheck
                            ? chulcheckDoneCircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : notWithinDistanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      _Chulcheck(
                        pressedChulCheck: pressedChulCheck,
                        isChulCheck: isChulCheck,
                        isWithin: isWithinRange,
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

  pressedChulCheck() async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('출근하기'),
            content: Text('출근하실?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('출첵')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('취소')),
            ],
          );
        });

    setState(() {
      isChulCheck = result;
    });
  }

  onLocationPressed() async {
    if(mapController == null){
      return;
    }

    final location = await Geolocator.getCurrentPosition();

    await mapController!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(location.latitude, location.longitude)
      )
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}

class _Map extends StatelessWidget {
  final CameraPosition cameraPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _Map(
      {Key? key,
      required this.cameraPosition,
      required this.circle,
      required this.marker,
      required this.onMapCreated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: GoogleMap(
          initialCameraPosition: cameraPosition,
          circles: <Circle>{circle},
          markers: <Marker>{marker},
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: onMapCreated,
        ));
  }
}

class _Chulcheck extends StatelessWidget {
  final VoidCallback pressedChulCheck;

  final bool isChulCheck;
  final bool isWithin;

  const _Chulcheck(
      {Key? key,
      required this.pressedChulCheck,
      required this.isChulCheck,
      required this.isWithin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.timelapse_outlined,
          size: 50,
          color: isChulCheck
              ? Colors.green
              : isWithin
                  ? Colors.blue
                  : Colors.red,
        ),
        if (!isChulCheck && isWithin)
          TextButton(onPressed: pressedChulCheck, child: Text('출첵하기'))
      ],
    ));
  }
}
