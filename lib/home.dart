import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:v2/video_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight
              ]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoScreen(),
                ),
              );
            },
            child: Text('Click Me')),
      ),
    );
  }
}
