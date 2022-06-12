import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_zartek_test/control/custom_loader.dart';
import 'package:flutter_zartek_test/control/custom_retry_widget.dart';
import 'package:flutter_zartek_test/core/model/restaurant_menu.dart';
import 'package:flutter_zartek_test/core/view/home/home_item_tile.dart';
import 'package:flutter_zartek_test/core/view_model/menu/menu_store.dart';
import 'package:flutter_zartek_test/helpers/google_helper.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';
import 'package:flutter_zartek_test/utils/app_constant.dart';
import 'package:flutter_zartek_test/utils/app_image.dart';
import 'package:flutter_zartek_test/utils/app_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  MenuStore? _menuStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _menuStore = Provider.of<MenuStore>(context);
    fetchRestaurantMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return (_menuStore?.isLoaded ?? false)
            ? (_menuStore?.restaurantMenus.isNotEmpty ?? false)
                ? DefaultTabController(
                    initialIndex: 1,
                    length: _tabController?.length ?? 0,
                    child: Scaffold(
                      drawer: Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            DrawerHeader(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    AppColor.drawerGradientStartColor,
                                    AppColor.drawerGradientEndColor
                                  ]),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0))),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                        radius: 30,
                                        child:
                                            Image.asset(AppImage.imgFirebase)),
                                    Text(GoogleHelper.user?.email ?? '',
                                        style: const TextStyle(fontSize: 20)),
                                    Text(
                                        'ID : ${GoogleHelper.user?.uid ?? ''}'),
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                                leading: Icon(Icons.logout_outlined,
                                    color: AppColor.iconColor),
                                title: Text('Log out',
                                    style:
                                        TextStyle(color: AppColor.iconColor)),
                                onTap: logout),
                          ],
                        ),
                      ),
                      appBar: AppBar(
                        backgroundColor: AppColor.whiteColor,
                        leading: Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                                icon:
                                    Icon(Icons.menu, color: AppColor.iconColor),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                tooltip: MaterialLocalizations.of(context)
                                    .openAppDrawerTooltip);
                          },
                        ),
                        actions: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (_menuStore?.cartItemCount != 0) {
                                Navigator.pushNamed(
                                    context, AppConstant.routeDetailScreen);
                              } else {
                                AppUtils.showSnackBar(
                                    context, 'No items found in the cart.');
                              }
                            },
                            child: Stack(
                              children: [
                                Center(
                                    child: Icon(Icons.shopping_cart,
                                        color: AppColor.iconColor)),
                                Observer(
                                  builder: (BuildContext context) {
                                    return Positioned(
                                        top: 10,
                                        right: 0,
                                        child: Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                                color: AppColor.tabColor,
                                                borderRadius:
                                                    BorderRadius.circular(24)),
                                            child: Center(
                                                child: Text(
                                                    '${_menuStore?.cartItemCount ?? 0}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColor
                                                            .whiteColor)))));
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20)
                        ],
                        bottom: TabBar(
                          controller: _tabController,
                          indicatorColor: AppColor.tabColor,
                          labelColor: AppColor.tabColor,
                          unselectedLabelColor: AppColor.textColor,
                          labelStyle: const TextStyle(
                              color: AppColor.tabColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          isScrollable: true,
                          tabs: List<Widget>.generate(
                              _tabController?.length ?? 0, (index) {
                            TableMenuList? item = _menuStore
                                ?.restaurantMenus.first.tableMenuList?[index];

                            return Tab(child: Observer(
                              builder: (BuildContext context) {
                                return Text(item?.menuCategory ?? '',
                                    style: TextStyle(color: AppColor.tabColor));
                              },
                            ));
                          }),
                        ),
                      ),
                      body: TabBarView(
                        controller: _tabController,
                        children: List<Widget>.generate(
                            _tabController?.length ?? 0, (index) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _menuStore
                                    ?.restaurantMenus
                                    .first
                                    .tableMenuList?[index]
                                    .categoryDishes
                                    ?.length ??
                                0,
                            itemBuilder: (BuildContext context, int i) {
                              CategoryDishes? element = _menuStore
                                  ?.restaurantMenus
                                  .first
                                  .tableMenuList?[index]
                                  .categoryDishes?[i];

                              return Observer(
                                builder: (BuildContext context) {
                                  return HomeItemTile(
                                    element: element,
                                    addItem: () {
                                      _menuStore?.addItemToCart(index, i);
                                    },
                                    removeItem: () {
                                      _menuStore?.removeItemFromCart(index, i);
                                    },
                                  );
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(height: 1);
                            },
                          );
                        }),
                      ),
                    ),
                  )
                : Scaffold(body: CustomRetryWidget(onTap: fetchRestaurantMenu))
            : const Scaffold(body: CustomLoader());
      },
    );
  }

  Future<void> fetchRestaurantMenu() async {
    await _menuStore?.fetchRestaurantMenu();
    _tabController =
        TabController(length: _menuStore?.tabsCount ?? 0, vsync: this);
  }

  Future<void> logout() async {
    Navigator.pop(context);
    await GoogleHelper.signOutGoogle();

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppConstant.routeLoginScreen, (route) => false);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
