import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';

class CustomQuantityButton extends StatelessWidget {
  const CustomQuantityButton(
      {required this.quantity,
      required this.addItem,
      required this.removeItem,
      this.color = AppColor.themeColor,
      Key? key})
      : super(key: key);

  final int quantity;
  final Color color;
  final VoidCallback addItem;
  final VoidCallback removeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
                color: AppColor.greyColor, spreadRadius: 1, blurRadius: 1),
          ]),
      width: 125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 8),
          GestureDetector(
              onTap: removeItem,
              child: Icon(Icons.remove, color: AppColor.whiteColor, size: 24)),
          const SizedBox(width: 8),
          Text('$quantity',
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          GestureDetector(
              onTap: addItem,
              child: Icon(Icons.add, color: AppColor.whiteColor, size: 24)),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
