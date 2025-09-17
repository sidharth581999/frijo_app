import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frijo/application/core/route/app_route.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/extentions.dart';
import 'package:frijo/application/core/utils/text_widget.dart';
import 'package:frijo/application/core/utils/toast.dart';
import 'package:frijo/presentation/bloc/homeBloc/home_bloc.dart';
import 'package:frijo/presentation/bloc/loginBloc/login_bloc.dart';
import 'package:frijo/presentation/screens/login/widgets/widgets.dart';
import 'package:frijo/presentation/widgets/common_button.dart';
import 'package:frijo/presentation/widgets/common_textformfield.dart';
import 'package:get/utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController phoneController = TextEditingController();
  String countryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: context.dynamicColor(
            light: ColorResources.blackBG,
            dark: ColorResources.blackBG,
          ),
          child: SingleChildScrollView(
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginClickedState) {
                  if (state.isError) {
                    HelperService.showCustomToast(
                      message: state.errorMsg ?? "",
                      type: "error",
                    );
                  } else if (state.isSuccess) {
                    HelperService.showCustomToast(
                      message: "Successfully Logedin",
                    );
                    context.read<HomeBloc>().add(HomeBuildEvent());
                    // Navigator.pushReplacementNamed(context, AppRoute.home);
                  }
                }
              },
              child: Padding(
                padding: EdgeInsets.all(16.sdp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: context.mediaQuerySize.height * 0.10),
                    TextWidget(
                      text: "Enter Your\nMobile Number",
                      style: TextStyle(
                        fontSize: 23.sdp,
                        fontWeight: FontWeight.w500,
                        color: context.dynamicColor(
                          light: ColorResources.white,
                          dark: ColorResources.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.sdp),
                    TextWidget(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Porta at id hac vitae. Et tortor at vehicula euismod mi viverra.",
                      style: TextStyle(
                        fontSize: 12.sdp,
                        fontWeight: FontWeight.w400,
                        color: context.dynamicColor(
                          light: ColorResources.greyTextloginScreen,
                          dark: ColorResources.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.sdp),
                    Row(
                      children: [
                        SizedBox(
                          width: 80.sdp,
                          child: coutryCodeDropdown("+91", ["+91", "+56"], (
                            value,
                          ) {
                            countryCode = value!;
                          }, context),
                        ),
                        SizedBox(width: 10.sdp),
                        Expanded(
                          child: CommonTextFormField(
                            controller: phoneController,
                            hintText: "Enter Mobile Number",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.mediaQuerySize.height * 0.40.sdp),
                    Center(
                      child: BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginClickedState && state.isError) {
                            
                          } else if(state is LoginClickedState && state.isSuccess) {
                              context.read<HomeBloc>().add(
                          HomeBuildEvent()
                        );
                            Navigator.pushReplacementNamed(
                                context,
                                AppRoute.home,
                              );
                          }
                        },
                        builder: (context, state) {
                          return CommonButton(
                            borderRadious: 25.5.sdp,
                            isBoarder: true,
                            buttoncolor: ColorResources.blackBG.withOpacity(
                              0.2,
                            ),
                            boarderColor: ColorResources.white.withOpacity(0.6),
                            onTap: () {
                              if (state is LoginClickedState && state.isLoading) { } else{
                                 context.read<LoginBloc>().add(
                          LoginClickedEvent(countryCode: countryCode, phoneNo: phoneController.text)
                        );
                              }
                              
                            },
                            height: 50.sdp,
                            width: 140.sdp,
                            child: Row(
                              children: [
                                TextWidget(
                                  text: "Continue",
                                  style: TextStyle(
                                    fontSize: 14.sdp,
                                    fontWeight: FontWeight.w400,
                                    color: context.dynamicColor(
                                      light: ColorResources.white,
                                      dark: ColorResources.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Container(
                                  height: 36.sdp,
                                  width: 36.sdp,
                                  decoration: BoxDecoration(
                                    color: ColorResources.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: state is LoginClickedState &&  state.isLoading? CircularProgressIndicator(color: ColorResources.white,) : Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorResources.white,
                                      size: 18.sdp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
