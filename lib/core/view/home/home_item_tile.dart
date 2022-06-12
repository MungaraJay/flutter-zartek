import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/control/custom_quantity_button.dart';
import 'package:flutter_zartek_test/core/model/restaurant_menu.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';
import 'package:flutter_zartek_test/utils/app_image.dart';

class HomeItemTile extends StatelessWidget {
  const HomeItemTile(
      {required this.element,
      required this.addItem,
      required this.removeItem,
      Key? key})
      : super(key: key);

  final CategoryDishes? element;
  final VoidCallback addItem;
  final VoidCallback removeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                  element?.dishType == 2 ? AppImage.imgVeg : AppImage.imgNonVeg,
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(element?.dishName ?? '',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkTextColor)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${element?.dishCurrency ?? ''} ${element?.dishPrice ?? 0}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkTextColor)),
                        Text('${element?.dishCalories ?? 0} Calories',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkTextColor)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(element?.dishDescription ?? '',
                        style: const TextStyle(color: AppColor.textColor)),
                    const SizedBox(height: 12),
                    CustomQuantityButton(
                        quantity: element?.quantity ?? 0,
                        addItem: addItem,
                        removeItem: removeItem)
                  ],
                ),
              ),
              Image.network(
                element?.dishImage ?? '',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  return Image.asset(AppImage.imgFirebase,
                      height: 60, width: 60, fit: BoxFit.cover);
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(AppImage.imgFirebase,
                      height: 60, width: 60, fit: BoxFit.cover);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
