import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/provider/provider.dart';
import 'package:provider_example/utils/constants.dart';

class Google_Maps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<Google_Maps> {
  Completer<GoogleMapController> _controller = Completer();

  Provide provider = Provide();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Provide>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Google map'),
        backgroundColor: Constants.red,
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: provider.currentMapType,
          initialCameraPosition: CameraPosition(target: Constants.center,
            zoom: 11.0,),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            onPressed: (){
              provider.setMapType(provider.currentMapType);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            backgroundColor: Constants.red,
            child: const Icon(Icons.map, size: 36.0),
          ),
        ),
      ),
    );
  }
}