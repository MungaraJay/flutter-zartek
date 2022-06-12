import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_zartek_test/control/custom_quantity_button.dart';
import 'package:flutter_zartek_test/core/model/restaurant_menu.dart';
import 'package:flutter_zartek_test/core/view/details/order_placed_dialog.dart';
import 'package:flutter_zartek_test/core/view_model/menu/menu_store.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';
import 'package:flutter_zartek_test/utils/app_image.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MenuStore? _menuStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _menuStore = Provider.of<MenuStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
            titleSpacing: 0,
            leading: const BackButton(color: AppColor.textColor),
            title: const Text('Order Summary',
                style: TextStyle(
                    color: AppColor.textColor, fontWeight: FontWeight.w500)),
            backgroundColor: AppColor.whiteColor),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Observer(
                builder: (BuildContext context) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColor.greyColor,
                              spreadRadius: 1,
                              blurRadius: 1),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Observer(
                          builder: (BuildContext context) {
                            return Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.cartColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(_menuStore?.dishesItemsCount ?? '',
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)));
                          },
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _menuStore?.orders.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              CategoryDishes? item = _menuStore?.orders[index];

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        item?.dishType == 2
                                            ? AppImage.imgVeg
                                            : AppImage.imgNonVeg,
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.cover),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item?.dishName ?? '',
                                              style: const TextStyle(
                                                  color: AppColor.darkTextColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis),
                                          const SizedBox(height: 8),
                                          Text(
                                              '${item?.dishCurrency ?? ''} ${item?.dishPrice ?? ''}',
                                              style: const TextStyle(
                                                  color: AppColor.darkTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                          const SizedBox(height: 8),
                                          Text(
                                              '${item?.dishCalories ?? ''} Calories',
                                              style: const TextStyle(
                                                  color: AppColor.darkTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    CustomQuantityButton(
                                        color: AppColor.cartColor,
                                        quantity: item?.quantity ?? 0,
                                        addItem: () {
                                          _menuStore?.addDishItemToCart(
                                              item?.dishId ?? '');
                                        },
                                        removeItem: () {
                                          _menuStore?.removeDishItemFromCart(
                                              item?.dishId ?? '');
                                        }),
                                    const SizedBox(width: 4),
                                    Text(
                                        '${item?.dishCurrency ?? ''} ${(item?.quantity ?? 0) * (item?.dishPrice ?? 0)}',
                                        style: const TextStyle(
                                            color: AppColor.darkTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(height: 1);
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(height: 1),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Amount',
                                  style: TextStyle(
                                      color: AppColor.darkTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(width: 4),
                              Observer(
                                builder: (BuildContext context) {
                                  return Text(
                                      'INR ${_menuStore?.cartTotalAmount ?? 0}',
                                      style: const TextStyle(
                                          color: AppColor.themeColor,
                                          fontSize: 16));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return OrderPlacedDialog(
                            title: 'Order placed successfully.',
                            orderPlacedCompleteActionCallback: () {
                              _menuStore?.clearCart();
                              Navigator.pop(context);
                            });
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.cartColor,
                      padding: const EdgeInsets.all(12),
                      shadowColor: AppColor.cartColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32))),
                  child: Text('Place Order',
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)))
            ],
          ),
        )));
  }
}
