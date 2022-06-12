import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {required this.imgPath,
      required this.title,
      required this.gradientStartColor,
      required this.gradientEndColor,
      required this.onTap,
      Key? key})
      : super(key: key);

  final String imgPath;
  final String title;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 16, right: 16),
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(imgPath,
                      height: 24, width: 24, fit: BoxFit.cover)),
              Container(
                  alignment: Alignment.center,
                  child: Text(title,
                      style:
                          TextStyle(color: AppColor.whiteColor, fontSize: 16))),
            ],
          ),
        ),
      ),
    );
  }
}
