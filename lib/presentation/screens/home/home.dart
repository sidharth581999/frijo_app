
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frijo/application/core/route/app_route.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/extentions.dart';
import 'package:frijo/application/core/utils/text_widget.dart';
import 'package:frijo/presentation/bloc/homeBloc/home_bloc.dart';
import 'package:frijo/presentation/screens/home/widgets/home_widgets.dart';
import 'package:frijo/presentation/widgets/error_widget.dart';
import 'package:frijo/presentation/widgets/shimmer_loading.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final playingIndex = ValueNotifier<int?>(null);
  final videoPlayerController = ValueNotifier<VideoPlayerController?>(null);
  final chewieController = ValueNotifier<ChewieController?>(null);

  @override
  void dispose() {
    _disposeVideo();
    playingIndex.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void _disposeVideo() {
    chewieController.value?.dispose();
    videoPlayerController.value?.dispose();
    chewieController.value = null;
    videoPlayerController.value = null;
  }

  Future<void> _playVideo(int index, String videoUrl) async {
    if (playingIndex.value == index) {
      playingIndex.value = null;
      _disposeVideo();
      return;
    }

    _disposeVideo();

    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await controller.initialize();

    final chewie = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: false,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
    );

    playingIndex.value = index;
    videoPlayerController.value = controller;
    chewieController.value = chewie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoute.addFeed),
        child: Container(
          height: 63.sdp,
          width: 63.sdp,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(style: BorderStyle.none), color: ColorResources.red),
        child: Icon(Icons.add, size: 45.sdp, color: ColorResources.white,),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeBuildState) {
              if (state.isLoading) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 17.sdp),
                  itemBuilder: (context, index) => ShimmerLoader.rectangular(
                    height: 40.sdp,
                    width: double.maxFinite,
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.sdp),
                  itemCount: 5,
                );
              }
              if (state.isError) {
                return ErrorMessage(message: state.errorMsg ?? "");
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.sdp),
                  UserDetailsTile(user: state.homeFeeds?.user),
                  SizedBox(height: 31.sdp),
                  CategoriesTile(categories: state.homeFeeds?.categoryDict),
                  SizedBox(height: 22.sdp),
                  Expanded(
                    child: ValueListenableBuilder<int?>(
                      valueListenable: playingIndex,
                      builder: (context, currentPlaying, _) {
                        return ListView.builder(
                          itemCount: state.homeFeeds?.results?.length ?? 0,
                          itemBuilder: (context, index) {
                            final feed = state.homeFeeds!.results![index];
                            final isPlaying = currentPlaying == index;

                            return VisibilityDetector(
                              key: Key(feed.id!.toString()),
                              onVisibilityChanged: (info) {
                                if (info.visibleFraction == 0 &&
                                    playingIndex.value == index) {
                                  playingIndex.value = null;
                                  _disposeVideo();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5.0.sdp),
                                child: Container(
                                  color: Colors.grey[900],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 17.0.sdp,
                                          top: 10.sdp,
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: CachedNetworkImage(
                                                imageUrl: "",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  height: 38.sdp,
                                                  width: 38.sdp,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorResources.greyHint,
                                                  ),
                                                  width: 38.sdp,
                                                  height: 38.sdp,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorResources.greyHint,
                                                  ),
                                                ),
                                                height: 38.sdp,
                                                width: 38.sdp,
                                              ),
                                            ),
                                            SizedBox(width: 12.sdp),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidget(
                                                  text: feed.user?.name ??
                                                      "Unknown",
                                                  style: TextStyle(
                                                    fontSize: 13.sdp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        context.dynamicColor(
                                                      light:
                                                          ColorResources.white,
                                                      dark:
                                                          ColorResources.white,
                                                    ),
                                                  ),
                                                ),
                                                TextWidget(
                                                  text: "5 Days",
                                                  style: TextStyle(
                                                    fontSize: 10.sdp,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        context.dynamicColor(
                                                      light: ColorResources
                                                          .greyTextHomeScreen,
                                                      dark: ColorResources
                                                          .greyTextHomeScreen,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17.sdp),

                                      ValueListenableBuilder<
                                          VideoPlayerController?>(
                                        valueListenable: videoPlayerController,
                                        builder: (context, controller, _) {
                                          if (isPlaying &&
                                              controller != null &&
                                              controller.value.isInitialized) {
                                            return AspectRatio(
                                              aspectRatio:
                                                  controller.value.aspectRatio,
                                              child: ValueListenableBuilder<
                                                  ChewieController?>(
                                                valueListenable:
                                                    chewieController,
                                                builder:
                                                    (context, chewie, child) {
                                                  return chewie != null
                                                      ? Chewie(
                                                          controller: chewie,
                                                        )
                                                      : const SizedBox();
                                                },
                                              ),
                                            );
                                          } else {
                                            return Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: Image.network(
                                                    feed.image ?? "",
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (_, __, ___) =>
                                                            Container(
                                                      color: ColorResources.greyTextHomeScreen,
                                                      child: const Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        color: ColorResources.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => _playVideo(
                                                      index, feed.video ?? ""),
                                                  child: Container(
                                                    height: 37.sdp,
                                                    width: 37.sdp,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        width: 1.5.sdp,
                                                        color: ColorResources
                                                            .white,
                                                      ),
                                                      color: ColorResources
                                                          .white
                                                          .withOpacity(0.25),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.play_arrow,
                                                        color: ColorResources
                                                            .white,
                                                        size: 32.sdp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),

                                      SizedBox(height: 10.sdp),
                                      Padding(
                                        padding: EdgeInsets.all(17.sdp),
                                        child: TextWidget(
                                          text: feed.description ?? "",
                                          style: TextStyle(
                                            fontSize: 12.5.sdp,
                                            fontWeight: FontWeight.w300,
                                            color: ColorResources
                                                .greyTextHomeScreen,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
