import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/dotted_borderpainter.dart';
import 'package:frijo/application/core/utils/extentions.dart';
import 'package:frijo/application/core/utils/text_widget.dart';
import 'package:frijo/application/core/utils/toast.dart';
import 'package:frijo/presentation/bloc/buildFeed/addfeed_bloc.dart';
import 'package:frijo/presentation/bloc/shareFeed/share_feed_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class AddFeedsScreen extends StatelessWidget {
  AddFeedsScreen({super.key});

  final ValueNotifier<File?> videoFile = ValueNotifier<File?>(null);
  final ValueNotifier<File?> thumbnailFile = ValueNotifier<File?>(null);
  final ValueNotifier<VideoPlayerController?> videoPlayerController =
      ValueNotifier<VideoPlayerController?>(null);
  final ValueNotifier<ChewieController?> chewieController =
      ValueNotifier<ChewieController?>(null);
  final ValueNotifier<bool> isVideoPlaying = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showAll = ValueNotifier<bool>(false);

  final TextEditingController descriptionController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  final ValueNotifier<List<int>> selectedCategories = ValueNotifier<List<int>>(
    [],
  );

  /// Pick video
  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      videoFile.value = file;
      await _initializeVideo(file);
      isVideoPlaying.value = false; // Don't autoplay
    }
  }

  /// Pick thumbnail
  Future<void> pickThumbnail() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      thumbnailFile.value = File(pickedFile.path);
    }
  }

  /// Initialize video controllers
  Future<void> _initializeVideo(File file) async {
    videoPlayerController.value?.dispose();
    chewieController.value?.dispose();

    final controller = VideoPlayerController.file(file);
    await controller.initialize();

    final chewie = ChewieController(
      videoPlayerController: controller,
      autoPlay: false,
      looping: false,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
    );

    videoPlayerController.value = controller;
    chewieController.value = chewie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// AppBar with Share button
            Padding(
              padding: EdgeInsets.fromLTRB(17.sdp, 30.sdp, 17.sdp, 10.sdp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 25.sdp,
                          width: 25.sdp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorResources.white),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 13.sdp,
                              color: ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17.sdp),
                      TextWidget(
                        text: "Add Feeds",
                        style: TextStyle(
                          fontSize: 16.sdp,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.white,
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<ShareFeedBloc, ShareFeedState>(
                    listener: (context, state) {
                      if (state is ShareFeedClickedState && state.isError) {
                            HelperService.showCustomToast(
                      message: state.errorMsg??"", type: "error"
                    );
                          } if (state is ShareFeedClickedState && state.isSuccess) {
                             HelperService.showCustomToast(
                      message: state.errorMsg??"",
                    );
                            Navigator.of(context).pop(); 
                          }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          if (state is ShareFeedClickedState && state.isLoading) {}
                          else{
                            context.read<ShareFeedBloc>().add(
                            ShareFeedClickedEvent(
                              data: ShareFeedModel(
                                video: videoFile.value!.path,
                                image: thumbnailFile.value!.path,
                                desc: descriptionController.text,
                                categories: selectedCategories.value,
                              ),
                            ),
                          );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.sdp,
                            vertical: 7.sdp,
                          ),
                          decoration: BoxDecoration(
                            color: ColorResources.red.withOpacity(0.23),
                            borderRadius: BorderRadius.circular(18.sdp),
                            border: Border.all(
                              color: ColorResources.red,
                              width: 0.5.sdp,
                            ),
                          ),
                          child: TextWidget(
                            text: state is ShareFeedClickedState && state.isLoading? "Sharing..." : "Share",
                            style: TextStyle(
                              color: ColorResources.white,
                              fontSize: 13.sdp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.sdp,),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 17.sdp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Video Upload
                    _videoSection(),

                    SizedBox(height: 35.sdp),

                    /// Thumbnail Upload
                    _thumbnailSection(),

                    SizedBox(height: 30.sdp),
                    TextWidget(
                      text: "Add Description",
                      style: TextStyle(
                        fontSize: 14.sdp,
                        color: ColorResources.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.sdp),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 11.sdp,
                        fontWeight: FontWeight.w300,
                        color: ColorResources.white.withOpacity(0.6),
                      ),
                      decoration: const InputDecoration(
                        hintText: "Enter text",
                        // disabledBorder: ,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorResources.darkGrey,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorResources.darkGrey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorResources.darkGrey,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 27.sdp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Categories This Project",
                          style: TextStyle(
                            color: ColorResources.white,
                            fontSize: 14.sdp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: showAll,
                          builder: (context, value, child) => 
                          InkWell(
                            onTap: () {
                              showAll.value = !showAll.value;  
                            },
                            child: Row(
                              children: [
                                TextWidget(
                                  text: showAll.value? "View Less" : "View All",
                                  style: TextStyle(
                                    color: ColorResources.white,
                                    fontSize: 10.sdp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5.sdp),
                                Container(
                                  height: 10.4.sdp,
                                  width: 10.4.sdp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorResources.white),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 6.sdp,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    BlocBuilder<AddFeedBloc, AddFeedState>(
                      builder: (context, state) {
                        if (state is AddFeedBuildState && state.isSuccess) {
                          return ValueListenableBuilder(
                            valueListenable: showAll,
                            builder: (context, value, child) => 
                             ValueListenableBuilder<List<int>>(
                              valueListenable: selectedCategories,
                              builder: (context, selected, _) {
                                final categories = state.categories?.categories ?? [];
                                                    final visibleCategories = showAll.value
                            ? categories
                                                   : categories.take(6).toList();
                                return state.categories?.categories != null
                                    ? Wrap(
                                        spacing: 10.sdp,
                                        runSpacing: 10.sdp,
                                        children: visibleCategories
                                            .map((cat) {
                                              final isSelected = selected
                                                  .contains(cat.id);
                                              return GestureDetector(
                                                onTap: () {
                                                  if (isSelected) {
                                                    selectedCategories.value =
                                                        List.from(selected)
                                                          ..remove(cat.id);
                                                  } else {
                                                    selectedCategories.value =
                                                        List.from(selected)
                                                          ..add(cat.id!);
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sdp,
                                                    vertical: 9.sdp,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15.7.sdp,
                                                        ),
                                                    border: Border.all(
                                                      color: ColorResources.red
                                                          .withOpacity(0.4),
                                                    ),
                                                    color: isSelected
                                                        ? ColorResources.red
                                                              .withOpacity(0.3)
                                                        : null,
                                                  ),
                                                  child: TextWidget(
                                                    text: cat.title,
                                                    style: TextStyle(
                                                      color: ColorResources.white,
                                                      fontSize: 10.sdp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                            .toList(),
                                      )
                                    : SizedBox();
                              },
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    SizedBox(height: 20.sdp),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Video Section Widget
  Widget _videoSection() {
    return ValueListenableBuilder<File?>(
      valueListenable: videoFile,
      builder: (context, file, _) {
        if (file == null) {
          return GestureDetector(
            onTap: pickVideo,
            child: _uploadBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/gallery-add.png"),
                  SizedBox(height: 25.sdp),
                  TextWidget(
                    text: "Select a video from Gallery",
                    style: TextStyle(
                      fontSize: 15.sdp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.greyTextloginScreen,
                    ),
                  ),
                ],
              ),
              height: 273.sdp,
            ),
          );
        } else {
          return Stack(
            children: [
              ValueListenableBuilder<ChewieController?>(
                valueListenable: chewieController,
                builder: (context, chewie, _) {
                  if (chewie != null &&
                      videoPlayerController.value != null &&
                      videoPlayerController.value!.value.isInitialized) {
                    return AspectRatio(
                      aspectRatio:
                          videoPlayerController.value!.value.aspectRatio,
                      child: Chewie(controller: chewie),
                    );
                  } else {
                    return _uploadBox(
                      child: const CircularProgressIndicator(),
                      height: 273.sdp,
                    );
                  }
                },
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    videoFile.value = null;
                    videoPlayerController.value?.dispose();
                    videoPlayerController.value = null;
                    chewieController.value?.dispose();
                    chewieController.value = null;
                    isVideoPlaying.value = false;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  /// image sectionn
  Widget _thumbnailSection() {
    return ValueListenableBuilder<File?>(
      valueListenable: thumbnailFile,
      builder: (context, file, _) {
        return GestureDetector(
          onTap: file == null ? pickThumbnail : null,
          child: _uploadBox(
            height: 128.sdp,
            child: file == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/addpng.png"),
                      SizedBox(width: 25.sdp),
                      TextWidget(
                        text: "Add a Thumbnail",
                        style: TextStyle(
                          fontSize: 16.sdp,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.greyTextloginScreen,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            thumbnailFile.value = null;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  /// Upload box
  Widget _uploadBox({required Widget child, required double height}) {
    return CustomPaint(
      painter: DottedBorderPainter(
        color: ColorResources.white.withOpacity(0.8),
        radius: 10.sdp,
      ),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Center(child: child),
      ),
    );
  }
}
