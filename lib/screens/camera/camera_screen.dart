import 'package:chatapp/screens/camera/camera_preview_screen.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool longPressTriggered = false;
  FlashMode _currentFlashMode = FlashMode.auto;
  int _cameraIndex = 0;

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("Camera", style: TextStyle(color: Colors.white)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: _toggleFlash,
                          icon: Icon(
                            _getFlashIcon(),
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!longPressTriggered) {
                              await takePicture();
                            }
                          },
                          onLongPress: () async {
                            longPressTriggered = true;
                            await takeVideo();
                          },
                          onLongPressUp: () async {
                            if (isRecording) {
                              await stopVideo();
                            }
                            longPressTriggered = false;
                          },
                          child: Icon(
                            Icons.panorama_fish_eye,
                            color: _cameraController.value.isRecordingVideo
                                ? Colors.red
                                : Colors.white,
                            size: 70,
                          ),
                        ),
                        IconButton(
                          onPressed: _flipCamera,
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Hold for Video, Tap for photo",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> takePicture() async {
    try {
      await cameraValue;

      final XFile image = await _cameraController.takePicture();
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPreviewScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  Future<void> takeVideo() async {
    if (!_cameraController.value.isRecordingVideo) {
      try {
        setState(() {
          isRecording = true;
        });

        await _cameraController.startVideoRecording();
      } catch (e) {
        print("Error starting video recording: $e");
      }
    }
  }

  Future<void> stopVideo() async {
    if (_cameraController.value.isRecordingVideo) {
      try {
        final XFile videoFile = await _cameraController.stopVideoRecording();
        setState(() {
          isRecording = false;
        });

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CameraPreviewScreen(videoPath: videoFile.path),
          ),
        );
      } catch (e) {
        print("Error stopping video recording: $e");
      }
    }
  }

  void _flipCamera() async {
    setState(() {
      _cameraIndex = (_cameraIndex + 1) % cameras.length;
    });
    await _cameraController.dispose();
    _initializeCamera();
  }

  void _initializeCamera() {
    _cameraController = CameraController(
      cameras[_cameraIndex],
      ResolutionPreset.high,
    );

    cameraValue = _cameraController.initialize().then((_) async {
      try {
        // Attempt to set the initial flash mode
        await _cameraController.setFlashMode(_currentFlashMode);
      } catch (e) {
        print("Flash mode not supported: $e");
        setState(() {
          _currentFlashMode = FlashMode.off; // Revert to 'off' if unsupported
        });
      }
      setState(() {}); // Update UI after initialization
    });
  }

  void _toggleFlash() async {
    if (_cameraController.value.isInitialized) {
      // Ensure camera is ready
      setState(() {
        // Cycle through flash modes: auto, always, off
        if (_currentFlashMode == FlashMode.auto) {
          _currentFlashMode = FlashMode.always;
        } else if (_currentFlashMode == FlashMode.always) {
          _currentFlashMode = FlashMode.off;
        } else {
          _currentFlashMode = FlashMode.auto;
        }
      });

      try {
        await _cameraController.setFlashMode(_currentFlashMode);
      } catch (e) {
        print("Error setting flash mode: $e");
        setState(() {
          // Revert to a default flash mode if setting fails
          _currentFlashMode = FlashMode.off;
        });
      }
    }
  }

  IconData _getFlashIcon() {
    switch (_currentFlashMode) {
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.off:
        return Icons.flash_off;
      default:
        return Icons.flash_auto;
    }
  }
}
