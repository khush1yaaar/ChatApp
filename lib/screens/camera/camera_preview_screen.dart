import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CameraPreviewScreen extends StatefulWidget {
  final String? imagePath;
  final String? videoPath;

  const CameraPreviewScreen({Key? key, this.imagePath, this.videoPath})
      : super(key: key);

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.videoPath != null) {
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() {
    _videoController = VideoPlayerController.file(File(widget.videoPath!))
      ..initialize().then((_) {
        setState(() {}); // Update the UI when the video is initialized
      })
      ..addListener(() {
        if (_videoController!.value.position ==
            _videoController!.value.duration) {
          // Reset play button when video ends
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Widget _buildImagePreview() {
    return Center(
      child: Image.file(
        File(widget.imagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildVideoPreview() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Wrap in a SizedBox to provide controlled size and padding
        Padding(
          padding: const EdgeInsets.all(16.0), // Adjust padding to control size
          child: FittedBox(
            fit: BoxFit
                .contain, // Keeps video within boundaries without full zoom-in
            child: SizedBox(
              width: _videoController!.value.size.width,
              height: _videoController!.value.size.height,
              child: VideoPlayer(_videoController!),
            ),
          ),
        ),
        // Play/pause button overlay
        IconButton(
          icon: Icon(
            _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 50,
          ),
          onPressed: () {
            setState(() {
              if (_videoController!.value.isPlaying) {
                _videoController!.pause();
              } else {
                _videoController!.play();
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.black.withOpacity(0.8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate, color: Colors.white),
            onPressed: () {
              // Action to add photo, if any
            },
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add a caption...',
                hintStyle: TextStyle(color: Colors.grey.shade300),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              // Action to send the image/video
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("Preview"),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.imagePath != null
                ? _buildImagePreview()
                : _videoController != null &&
                        _videoController!.value.isInitialized
                    ? _buildVideoPreview()
                    : const Center(child: CircularProgressIndicator()),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }
}
