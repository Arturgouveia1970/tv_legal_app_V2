import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class PlayerPage extends StatefulWidget {
  final String canalNome;
  final String canalUrl;

  const PlayerPage({required this.canalNome, required this.canalUrl});

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.canalUrl));

    await _videoController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: true,
      allowFullScreen: true,
      allowMuting: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.white,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  // ✅ Detect orientation change and toggle fullscreen
  void _checkOrientation(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (isLandscape) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Fullscreen
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Normal UI
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkOrientation(context); // ✅ Checks each build cycle

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.canalNome),
        backgroundColor: Colors.deepPurple,
      ),
      body: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
