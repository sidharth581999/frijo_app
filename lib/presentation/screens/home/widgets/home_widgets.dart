import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/extentions.dart';
import 'package:frijo/application/core/utils/text_widget.dart';
import 'package:frijo/data/models/home_datamodel.dart';
import 'package:frijo/presentation/widgets/common_button.dart';


class CategoriesTile extends StatelessWidget {
  const CategoriesTile({
    super.key,
    required this.categories, required this.selCategory
  });

  final List<CategoryDict>? categories;
  final ValueNotifier<String?> selCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.sdp,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 17.sdp),
        itemCount: categories?.length??0,
        itemBuilder: (_, i) {
          return CommonButton(
            isBoarder: true,
            borderRadious: 16,
            
            boarderColor: selCategory.value == categories?[i].id? ColorResources.red.withOpacity(0.4) : ColorResources.white.withOpacity(0.4),
            buttoncolor: selCategory.value == categories?[i].id? ColorResources.red.withOpacity(0.2) : ColorResources.blackBG, onTap: (){
              selCategory.value = categories?[i].id;
            }, height: null, 
          width: null, child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.sdp, vertical:8.sdp),
            child: Row(
              children: [
                selCategory.value == categories?[i].id? Image.asset("assets/ankr.png", color: ColorResources.white,) : SizedBox(),
                selCategory.value == categories?[i].id? SizedBox(width: 6.sdp,) : SizedBox(),
                TextWidget(text: categories?[i].title??"Title not avilable", style: TextStyle(
                        fontSize: 12.sdp,
                        fontWeight: FontWeight.w400,
                        color: context.dynamicColor(light: ColorResources.white, dark: ColorResources.white)),),
              ],
            ),
          ));
        },
        separatorBuilder: (_, __) => SizedBox(width: 12.sdp),
      ),
    );
  }
}

class UserDetailsTile extends StatelessWidget {
  const UserDetailsTile({
    super.key, required this.user,
  });

  final HomeDataModelUser? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: "Hello ${user?.name?? ""}",
                style: TextStyle(
                  fontSize: 16.sdp,
                  fontWeight: FontWeight.w600,
                  color: context.dynamicColor(light: ColorResources.white, dark: ColorResources.white)),
              ),
              TextWidget(
                text: "Welcom back to section",
                style: TextStyle(
                  fontSize: 12.sdp,
                  fontWeight: FontWeight.w400,
                  color: context.dynamicColor(light: ColorResources.white, dark: ColorResources.white)),
              )
            ],
          ),    ClipRRect(    
      child: CachedNetworkImage(
        imageUrl: user?.image??"",
        imageBuilder: (context, imageProvider) => Container(
          height: 48.sdp,
          width: 48.sdp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,),
          ),
        ),
        placeholder: (context, url) => Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorResources.greyHint,
          ),
          width: 48.sdp,
          height: 48.sdp,
        ),
        errorWidget: (context, url, error) => Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorResources.greyHint,
          ),
          child: Center(child: Icon(Icons.person, color: ColorResources.white, size: 25.sdp,),),
          ),
          height: 48.sdp,
          width: 48.sdp,
        ),
      ),]
                ),
    );
  }
}
