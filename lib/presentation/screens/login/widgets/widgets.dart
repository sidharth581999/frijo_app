
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/extentions.dart';
import 'package:frijo/application/core/utils/text_widget.dart';

Widget coutryCodeDropdown(
  String? value,
  List<String> items,
  Function(String?) onChanged,
  BuildContext context,
) {
  return DropdownButtonFormField<String>(
    value: value,
    dropdownColor: ColorResources.blackBG,
    decoration: dropdownInputDecoration(""),
    icon: Icon(
      Icons.arrow_drop_down,
      color: context.dynamicColor(
        light: ColorResources.white,
        dark: ColorResources.white,
      ),
      size: 22.sdp,
    ),
    style: TextStyle(
      fontSize: 16.sdp,
      fontWeight: FontWeight.w600,
      color: context.dynamicColor(
        light: ColorResources.white,
        dark: ColorResources.white,
      ),
    ),
    onChanged: onChanged,
    items: items
        .map(
          (e) => DropdownMenuItem<String>(
            value: e,
            child: TextWidget(
              text: e,
              style: TextStyle(fontSize: 16.sdp, fontWeight: FontWeight.w600),
              textColor: context.dynamicColor(
                light: ColorResources.white,
                dark: ColorResources.white,
              ),
            ),
          ),
        )
        .toList(),
  );
}

//dropdown decoration
InputDecoration dropdownInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle:  TextStyle(
      fontSize: 14.sdp,
      fontWeight: FontWeight.w600,
      color: ColorResources.greyTextloginScreen,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12.sdp),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sdp),
      borderSide: BorderSide(color: ColorResources.white, width:  0.5.sdp),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sdp),
      borderSide: BorderSide(color: ColorResources.white, width:  0.5.sdp),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sdp),
      borderSide: BorderSide(color: ColorResources.red, width: 1.sdp),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sdp),
      borderSide: BorderSide(color: ColorResources.red, width: 1.sdp),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ColorResources.white,width:  0.5.sdp),
      borderRadius: BorderRadius.circular(8.sdp),
    ),
  );
}
