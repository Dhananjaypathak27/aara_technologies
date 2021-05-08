import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  Completer<GoogleMapController> _controller = Completer();
  //26.87401109107057, 80.97209228465805
  static const LatLng _center = const LatLng(26.87401109107057, 80.97209228465805);


  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }


  Widget button(Function function,IconData icon){
    return FloatingActionButton(onPressed: function,
    materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blueAccent,
      child: Icon(
        icon,size: 36,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoogleMap'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16.0
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: EdgeInsets.all(16),
          ),

          Positioned(
            top: 105.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 5.0),
                      blurRadius: 10,
                      spreadRadius: 3)
                ],
              ),
              child: TextField(
                onTap: ()async{
                  Prediction p = await PlacesAutocomplete.show(context: context, apiKey: 'AIzaSyDxVPvHG8cVUF7Ynjkb2bpkBd1EfEo_syY'
                  ,language: 'en',components: [
                    Component(Component.country, 'IN')
                      ]);
                },
                cursorColor: Colors.black,
                textInputAction: TextInputAction.go,
                onSubmitted: (value) {
                },
                decoration: InputDecoration(
                  icon: Container(
                    margin: EdgeInsets.only(left: 20, top: 5),
                    width: 10,
                    height: 10,
                    child: Icon(
                      Icons.local_taxi,
                      color: Colors.black,
                    ),
                  ),
                  hintText: "destination?",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
