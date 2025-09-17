// Dart imports:
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/text_widget.dart';
import 'package:get/get.dart';

class HelperService {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;



// ------------------------------------------------------------ Timer --------------------------------------------------
  static void showCustomToast(
      {required String message, String type = 'normal', int milliseconds=2000}) {
        print("-------------000--------------");
    final OverlayState? overlayState = navigatorKey.currentState!.overlay;
    if (toastTimer == null || !toastTimer!.isActive) {
      _overlayEntry = createOverlayEntry(message, type);
      overlayState!.insert(_overlayEntry!);
      toastTimer = Timer(Duration(milliseconds: milliseconds), () {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
        }
      });
    } else {
      _overlayEntry!.remove();
      toastTimer!.cancel();
      showCustomToast(message: message, type: type);
    }
  }

  static OverlayEntry createOverlayEntry(String message, String type) {
    // customizing dio error message because it is too long to fit
    final overlayMessage = type == 'error' && message.contains('DioError')
        ? 'error.somethingWentWrong'.tr
        : message;
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: 15,
        right: 15,
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity != 0) {
              // User swiped
              if (_overlayEntry != null) {
                _overlayEntry!.remove();
                toastTimer!.cancel();
              }
            }
          },
          child: 
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 40,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: type == 'normal'
                        ? ColorResources.white
                        : ColorResources.red),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: TextWidget(text:
                          overlayMessage,
                          style: TextStyle(color: ColorResources.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}
