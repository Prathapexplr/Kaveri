import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class InOutButton extends StatefulWidget {
  final String firstName;
  final String employeeId;

  const InOutButton({
    Key? key,
    required this.firstName,
    required this.employeeId,
  }) : super(key: key);

  @override
  _InOutButtonState createState() => _InOutButtonState(
        firstName: firstName,
        employeeId: employeeId,
      );
}

class _InOutButtonState extends State<InOutButton> {
  final String firstName;
  final String employeeId;

  _InOutButtonState({
    required this.firstName,
    required this.employeeId,
  });

  bool isIn = false;
  String punchedInTime = '';
  late IO.Socket socket;
  StreamSubscription<Position>? positionStream;
  Timer? timer;
  Position? lastPosition;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  @override
  void dispose() {
    stopLocationUpdates();
    socket.disconnect();
    super.dispose();
  }

  void initSocket() {
    socket = IO.io('https://api.jaynaturals.com', <String, dynamic>{
      'transports': ['websocket','polling'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      print('Connected to socket server');
      // Emit a test event when connected
      socket.emit('testConnection', {'message': 'Test connection successful'});
    });

    socket.on('disconnect', (_) {
      print('Disconnected from socket server');
    });

    socket.on('connect_error', (error) {
      print('Connection Error: $error');
      // Additional logging
      if (error is Map &&
          error.containsKey('type') &&
          error['type'] == 'TransportError') {
        print('TransportError: ${error['desc'] ?? 'No description provided'}');
      }
    });

    socket.on('error', (error) {
      print('Socket Error: $error');
    });

    socket.connect();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  Future<void> startLocationUpdates() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    const locationSettings =
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        lastPosition = position;
      },
      onError: (error) {
        print('Error getting location: $error');
      },
    );

    timer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (isIn && lastPosition != null) {
        print(
            'Preparing to send location for $firstName (ID: $employeeId): ${lastPosition!.latitude}, ${lastPosition!.longitude}');
        socket.emit('changeLocation', {
          'latitude': lastPosition!.latitude,
          'longitude': lastPosition!.longitude,
          'firstName': firstName,
          'employeeId': employeeId,
        });
      }
    });
  }

  void stopLocationUpdates() {
    positionStream?.cancel();
    timer?.cancel();
    print('Stopped location updates');
  }

  void toggleTracking() {
    setState(() {
      isIn = !isIn;
      if (isIn) {
        startLocationUpdates();
        DateTime now = DateTime.now();
        punchedInTime =
            '${now.hour}:${now.minute} ${now.hour >= 12 ? 'pm' : 'am'}';
      } else {
        stopLocationUpdates();
        punchedInTime = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    String month = monthNames[now.month - 1];
    String day = '${now.day}';

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue,
          ),
          height: 130,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (isIn)
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Punched in at\n',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    Text(
                      '$punchedInTime, $month $day',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    )
                  ],
                )
              else
                const Text("Punch in to start work",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900)),
              GestureDetector(
                onTap: toggleTracking,
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 2.5,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Stack(
                    alignment:
                        isIn ? Alignment.centerRight : Alignment.centerLeft,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(4),
                        width: 60,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isIn ? Colors.green : Colors.red,
                        ),
                      ),
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment:
                            isIn ? Alignment.centerRight : Alignment.centerLeft,
                        child: Padding(
                          padding: isIn
                              ? const EdgeInsets.only(right: 25.0)
                              : const EdgeInsets.only(left: 10),
                          child: Text(
                            isIn ? 'In' : 'Out',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
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
