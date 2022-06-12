import 'package:flutter_zartek_test/core/model/restaurant_menu.dart';
import 'package:flutter_zartek_test/service/api_repository.dart';
import 'package:mobx/mobx.dart';

part 'menu_store.g.dart';

class MenuStore = _MenuStore with _$MenuStore;

abstract class _MenuStore with Store {
  @observable
  List<RestaurantMenu> restaurantMenus = [];

  @observable
  int tabsCount = 0;

  @observable
  bool isLoaded = false;

  @action
  void changeLoaded(bool val) {
    isLoaded = val;
  }

  @action
  void clearPostList() {
    restaurantMenus = [];
  }

  @action
  Future<void> fetchRestaurantMenu() async {
    changeLoaded(false);
    clearPostList();
    try {
      restaurantMenus = await APIRepository().getRestaurantMenu();

      tabsCount = restaurantMenus.first.tableMenuList?.length ?? 0;
    } catch (e) {
      tabsCount = 0;
    } finally {
      changeLoaded(true);
    }
  }

  @action
  void addItemToCart(int tableMenuIndex, int dishIndex) {
    restaurantMenus.first.tableMenuList?[tableMenuIndex]
        .categoryDishes?[dishIndex].quantity = (restaurantMenus
                .first
                .tableMenuList?[tableMenuIndex]
                .categoryDishes?[dishIndex]
                .quantity ??
            0) +
        1;

    restaurantMenus = [...restaurantMenus, restaurantMenus.first];
  }

  @action
  void removeItemFromCart(int tableMenuIndex, int dishIndex) {
    int quantity = (restaurantMenus.first.tableMenuList?[tableMenuIndex]
            .categoryDishes?[dishIndex].quantity ??
        0);
    restaurantMenus.first.tableMenuList?[tableMenuIndex]
        .categoryDishes?[dishIndex].quantity = quantity >= 1 ? quantity - 1 : 0;

    restaurantMenus = [...restaurantMenus, restaurantMenus.first];
  }

  @computed
  int get cartItemCount {
    int count = 0;
    restaurantMenus.first.tableMenuList?.forEach((element) {
      element.categoryDishes?.forEach((item) {
        count = count + (item.quantity ?? 0);
      });
    });

    return count;
  }

  @computed
  List<CategoryDishes> get orders {
    List<CategoryDishes> items = [];

    restaurantMenus.first.tableMenuList?.forEach((element) {
      element.categoryDishes?.forEach((item) {
        if (item.quantity != 0) {
          items.add(item);
        }
      });
    });

    return items;
  }

  @computed
  double get cartTotalAmount {
    double total = 0;
    restaurantMenus.first.tableMenuList?.forEach((element) {
      element.categoryDishes?.forEach((item) {
        if (item.quantity != 0) {
          total = total + ((item.quantity ?? 0) * (item.dishPrice ?? 0));
        }
      });
    });

    return total;
  }

  @computed
  String get dishesItemsCount {
    int dishes = 0;
    int items = 0;
    restaurantMenus.first.tableMenuList?.forEach((element) {
      element.categoryDishes?.forEach((item) {
        if (item.quantity != 0) {
          items = items + (item.quantity ?? 0);
          dishes = dishes + 1;
        }
      });
    });

    return '$dishes Dishes - $items Items';
  }

  @action
  void addDishItemToCart(String dishIndex) {
    List<TableMenuList>? menuList = restaurantMenus.first.tableMenuList;
    for (int i = 0; i < (menuList?.length ?? 0); i++) {
      for (int j = 0; j < (menuList?[i].categoryDishes?.length ?? 0); j++) {
        if (menuList?[i].categoryDishes?[j].dishId == dishIndex) {
          menuList?[i].categoryDishes?[j].quantity =
              (menuList[i].categoryDishes?[j].quantity ?? 0) + 1;
          break;
        }
      }
    }

    restaurantMenus = [...restaurantMenus, restaurantMenus.first];
  }

  @action
  void removeDishItemFromCart(String dishIndex) {
    List<TableMenuList>? menuList = restaurantMenus.first.tableMenuList;
    for (int i = 0; i < (menuList?.length ?? 0); i++) {
      for (int j = 0; j < (menuList?[i].categoryDishes?.length ?? 0); j++) {
        if (menuList?[i].categoryDishes?[j].dishId == dishIndex) {
          int quantity = (menuList?[i].categoryDishes?[j].quantity ?? 0);
          menuList?[i].categoryDishes?[j].quantity =
              quantity >= 1 ? quantity - 1 : 0;
          break;
        }
      }
    }

    restaurantMenus = [...restaurantMenus, restaurantMenus.first];
  }

  @action
  void clearCart() {
    restaurantMenus.first.tableMenuList?.forEach((element) {
      element.categoryDishes?.forEach((item) {
        item.quantity = 0;
      });
    });

    restaurantMenus = [...restaurantMenus, restaurantMenus.first];
  }
}
