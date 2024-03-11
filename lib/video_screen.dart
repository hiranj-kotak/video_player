import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iconify_flutter_plus/icons/carbon.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    super.key,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool istapped = true;
  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(
      "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    ))
      ..initialize().then((_) {
        setState(() {});
      });
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });

    super.initState();
  }

  void timer() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        istapped = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  istapped = true;
                });
                timer();
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )),
            ),
            istapped
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Big Buck Bunny",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _controller.seekTo(
                                      _controller.value.position -
                                          const Duration(seconds: 5));
                                });
                              },
                              icon: const Iconify(
                                Carbon.rewind_10,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const SizedBox(width: 50),
                            _controller.value.isInitialized
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      });
                                    },
                                    icon: Iconify(
                                      _controller.value.isPlaying
                                          ? Ic.outline_pause
                                          : Ic.outline_play_arrow,
                                      color: Colors.white,
                                      size: 70,
                                    ))
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                            const SizedBox(width: 50),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _controller.seekTo(
                                      _controller.value.position +
                                          const Duration(seconds: 5));
                                });
                              },
                              icon: const Iconify(
                                Ic.outline_forward_10,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${_controller.value.position.inSeconds ~/ 60}:${_controller.value.position.inSeconds % 60} / ${(_controller.value.duration.inSeconds ~/ 60)}:${_controller.value.duration.inSeconds % 60}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Stack(
                              children: [
                                Container(
                                  height: 2,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                FractionallySizedBox(
                                  widthFactor: _controller.value.isInitialized
                                      ? _controller.value.position.inSeconds /
                                          _controller.value.duration.inSeconds
                                      : 0.0,
                                  child: Container(
                                    height: 2,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
