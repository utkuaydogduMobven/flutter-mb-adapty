import 'package:flutter/material.dart';

/// [BaseState] is a base state for the product module.
/// It is used to prevent the state from being emitted after the
/// widget is disposed.
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// [productNetworkManager] is a network manager for the product module.
  /* ProductNetworkManager get productNetworkManager =>
      ProductStateItems.productNetworkManager; */

  /// [productViewModel] is a view model for the product module.
  /* ProductViewModel get productViewModel => ProductStateItems.productViewModel; */
}

/// [BaseStateMixin] is a mixin for the product module.
/// It is used to add the [productNetworkManager] and [productViewModel]
/// features to the stateless widget.
mixin BaseStateMixin on StatelessWidget {
  /// [productNetworkManager] is a network manager for the product module.
  /* ProductNetworkManager get productNetworkManager =>
      ProductStateItems.productNetworkManager; */

  /// [productViewModel] is a view model for the product module.
  /* ProductViewModel get productViewModel => ProductStateItems.productViewModel; */
}
