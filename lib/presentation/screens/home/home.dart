import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Feed {
  final int id;
  final String description;
  final String thumbnail;
  final String videoUrl;
  final String userName;
  final String? userImage;

  Feed({
    required this.id,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.userName,
    this.userImage,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      description: json['description'] ?? "",
      thumbnail: json['image'] ?? "",
      videoUrl: json['video'] ?? "",
      userName: json['user']?['name'] ?? "Unknown",
      userImage: json['user']?['image'],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? playingIndex;
  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;

  final categories = ["Explore", "Trending", "All", "Sociology", "Literature"];

  /// Simulated API response
  final List<Map<String, dynamic>> feedJson = [
    {
      "id": 160,
      "description": "POLITICAL SOCIOLOGY",
      "image":
          "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
      "video": "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4",
      "user": {"id": 1, "name": "Frijo", "image": null}
    },
    {
      "id": 160,
      "description": "POLITICAL SOCIOLOGY",
      "image":
          "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
      "video": "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4",
      "user": {"id": 1, "name": "Frijo", "image": null}
    },
    {
      "id": 160,
      "description": "POLITICAL SOCIOLOGY",
      "image":
          "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
      "video": "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4",
      "user": {"id": 1, "name": "Frijo", "image": null}
    },
    {
      "id": 160,
      "description": "POLITICAL SOCIOLOGY",
      "image":
          "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
      "video": "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4",
      "user": {"id": 1, "name": "Frijo", "image": null}
    },
    {
      "id": 159,
      "description": "GENDER AND SOCIETY",
      "image":
          "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
      "video": "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4",
      "user": {"id": 1, "name": "Frijo", "image": null}
    },
    {
      "id": 158,
      "description": "LITERATURE BUSINESS DEVELOPMENT ASSOCIATE",
      "image":
          "https://i.ibb.co/wrzL7vr/Screenshot-2024-11-04-at-2-43-45-PM.png",
      "video": "https://cdn.noviindus.com/3209829-hd_1280_720_25fps.mp4",
      "user": {"id": 1, "name": "Frijo", "image": null}
    },
  ];

  late List<Feed> feeds;

  @override
  void initState() {
    super.initState();
    feeds = feedJson.map((e) => Feed.fromJson(e)).toList();
  }

  @override
  void dispose() {
    _disposeVideo();
    super.dispose();
  }

  void _disposeVideo() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    _chewieController = null;
    _videoPlayerController = null;
  }

  Future<void> _playVideo(int index) async {
    if (playingIndex == index) {
      setState(() {
        playingIndex = null;
        _disposeVideo();
      });
      return;
    }

    _disposeVideo();

    final controller = VideoPlayerController.network(feeds[index].videoUrl);
    await controller.initialize();

    final chewie = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: false,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
    );

    setState(() {
      playingIndex = index;
      _videoPlayerController = controller;
      _chewieController = chewie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Categories Row
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (_, i) {
                  return Chip(
                    label: Text(categories[i]),
                    backgroundColor: Colors.red,
                    labelStyle: const TextStyle(color: Colors.white),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
              ),
            ),

            /// Feeds
            Expanded(
              child: ListView.builder(
                itemCount: feeds.length,
                itemBuilder: (context, index) {
                  final feed = feeds[index];
                  final isPlaying = playingIndex == index;

                  return VisibilityDetector(
                    key: Key(feed.id.toString()),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction == 0 && playingIndex == index) {
                        setState(() {
                          playingIndex = null;
                          _disposeVideo();
                        });
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.all(12),
                      color: Colors.grey[900],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Video or Thumbnail
                          if (isPlaying &&
                              _chewieController != null &&
                              _videoPlayerController != null &&
                              _videoPlayerController!.value.isInitialized)
                            AspectRatio(
                              aspectRatio:
                                  _videoPlayerController!.value.aspectRatio,
                              child: Chewie(controller: _chewieController!),
                            )
                          else
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                    feed.thumbnail,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  onPressed: () => _playVideo(index),
                                ),
                              ],
                            ),

                          /// User row
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: feed.userImage != null
                                      ? NetworkImage(feed.userImage!)
                                      : null,
                                  child: feed.userImage == null
                                      ? const Icon(Icons.person,
                                          color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  feed.userName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Description
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              feed.description,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
