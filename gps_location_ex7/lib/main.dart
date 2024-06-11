import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Hide debug banner
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _latitude = '';
  String _longitude = '';
  String _locationCountry = 'Fetching...';
  String _locationState = 'Fetching...';
  String _area = 'Fetching...';
  String _region = '';
  String _greetingMessage = '';
  String _warmMessage = 'Stay safe & Enjoy your day !';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _setGreetingMessage();
  }

  _getCurrentLocation() async {
    // Check if permission is granted
    PermissionStatus status = await Permission.locationWhenInUse.status;

    if (!status.isGranted) {
      // If permission is not granted, request it
      status = await Permission.locationWhenInUse.request();
    }

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _latitude = position.latitude.toString();
          _longitude = position.longitude.toString();
        });
        _getPlaceDetails(position.latitude, position.longitude);
      } catch (e) {
        // print("Error getting location: $e");
        setState(() {
          _locationState = '';
        });
      }
    } else {
      // print("Location permission is not granted");
      setState(() {
        _locationState = 'Fetching...';
      });
    }
  }

  _getPlaceDetails(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _locationCountry = placemark.country ?? '';
          _locationState = placemark.administrativeArea ?? '';
          _area = placemark.locality ?? ''; // This will show the area name
          _region = placemark.subAdministrativeArea ?? '';
        });
      }
    } catch (e) {
      // print("Error getting place details: $e");
      setState(() {
        _locationState = 'Fetching...';
      });
    }
  }

  _setGreetingMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      setState(() {
        _greetingMessage = 'Good Morning';
      });
    } else if (hour < 17) {
      setState(() {
        _greetingMessage = 'Good Afternoon';
      });
    } else {
      setState(() {
        _greetingMessage = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Location Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15), // Curve the corners by 30
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _greetingMessage,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 16),
              Text(
                _warmMessage,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              SizedBox(height: 16),
              Container(
                height: 410,  // Set the height of the Container
                width: 350,   // Set the width of the Container
                child: Container(
                  height: 410,  // Set the height of the Card
                  width: 350,   // Set the width of the Card
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(_locationCountry, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 12),
                          Text(
                            'State:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(_locationState, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 12),
                          Text(
                            'Area:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(_area, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 12),
                          Text(
                            'Region:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(_region, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 12),
                          Text(
                            'Latitude:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(_latitude, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 12),
                          Text(
                            'Longitude:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(_longitude, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}