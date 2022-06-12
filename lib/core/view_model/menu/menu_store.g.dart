// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuStore on _MenuStore, Store {
  Computed<int>? _$cartItemCountComputed;

  @override
  int get cartItemCount =>
      (_$cartItemCountComputed ??= Computed<int>(() => super.cartItemCount,
              name: '_MenuStore.cartItemCount'))
          .value;
  Computed<List<CategoryDishes>>? _$ordersComputed;

  @override
  List<CategoryDishes> get orders =>
      (_$ordersComputed ??= Computed<List<CategoryDishes>>(() => super.orders,
              name: '_MenuStore.orders'))
          .value;
  Computed<double>? _$cartTotalAmountComputed;

  @override
  double get cartTotalAmount => (_$cartTotalAmountComputed ??= Computed<double>(
          () => super.cartTotalAmount,
          name: '_MenuStore.cartTotalAmount'))
      .value;
  Computed<String>? _$dishesItemsCountComputed;

  @override
  String get dishesItemsCount => (_$dishesItemsCountComputed ??=
          Computed<String>(() => super.dishesItemsCount,
              name: '_MenuStore.dishesItemsCount'))
      .value;

  late final _$restaurantMenusAtom =
      Atom(name: '_MenuStore.restaurantMenus', context: context);

  @override
  List<RestaurantMenu> get restaurantMenus {
    _$restaurantMenusAtom.reportRead();
    return super.restaurantMenus;
  }

  @override
  set restaurantMenus(List<RestaurantMenu> value) {
    _$restaurantMenusAtom.reportWrite(value, super.restaurantMenus, () {
      super.restaurantMenus = value;
    });
  }

  late final _$tabsCountAtom =
      Atom(name: '_MenuStore.tabsCount', context: context);

  @override
  int get tabsCount {
    _$tabsCountAtom.reportRead();
    return super.tabsCount;
  }

  @override
  set tabsCount(int value) {
    _$tabsCountAtom.reportWrite(value, super.tabsCount, () {
      super.tabsCount = value;
    });
  }

  late final _$isLoadedAtom =
      Atom(name: '_MenuStore.isLoaded', context: context);

  @override
  bool get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
    });
  }

  late final _$fetchRestaurantMenuAsyncAction =
      AsyncAction('_MenuStore.fetchRestaurantMenu', context: context);

  @override
  Future<void> fetchRestaurantMenu() {
    return _$fetchRestaurantMenuAsyncAction
        .run(() => super.fetchRestaurantMenu());
  }

  late final _$_MenuStoreActionController =
      ActionController(name: '_MenuStore', context: context);

  @override
  void changeLoaded(bool val) {
    final _$actionInfo = _$_MenuStoreActionController.startAction(
        name: '_MenuStore.changeLoaded');
    try {
      return super.changeLoaded(val);
    } finally {
      _$_MenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearPostList() {
    final _$actionInfo = _$_MenuStoreActionController.startAction(
        name: '_MenuStore.clearPostList');
    try {
      return super.clearPostList();
    } finally {
      _$_MenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addItemToCart(int tableMenuIndex, int dishIndex) {
    final _$actionInfo = _$_MenuStoreActionController.startAction(
        name: '_MenuStore.addItemToCart');
    try {
      return super.addItemToCart(tableMenuIndex, dishIndex);
    } finally {
      _$_MenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItemFromCart(int tableMenuIndex, int dishIndex) {
    final _$actionInfo = _$_MenuStoreActionController.startAction(
        name: '_MenuStore.removeItemFromCart');
    try {
      return super.removeItemFromCart(tableMenuIndex, dishIndex);
    } finally {
      _$_MenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDishItemToCart(String dishIndex) {
    final _$actionInfo = _$_MenuStoreActionController.startAction(
        name: '_MenuStore.addDishItemToCart');
    try {
      return super.addDishItemToCart(dishIndex);
    } finally {
      _$_MenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeDishItemFromCart(String dishIndex) {
    final _$actionInfo = _$_MenuStoreActionController.startAction(
        name: '_MenuStore.removeDishItemFromCart');
    try {
      return super.removeDishItemFromCart(dishIndex);
    } finally {
      _$_MenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo =
        _$_MenuStoreActionController.startAction(name: '_MenuStore.clearCart');
    try {
      return super.clearCart();
    } finally {
      _$_MenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
restaurantMenus: ${restaurantMenus},
tabsCount: ${tabsCount},
isLoaded: ${isLoaded},
cartItemCount: ${cartItemCount},
orders: ${orders},
cartTotalAmount: ${cartTotalAmount},
dishesItemsCount: ${dishesItemsCount}
    ''';
  }
}
