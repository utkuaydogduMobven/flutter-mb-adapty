final class AdaptyErrorStrings {
  static const String noPlacementIDsProvided =
      'If you want to load all paywalls on initialize, you must provide placementIDs in the [MBAdaptyConfiguration]';
  static const String logPaywallConfigConflict =
      'Paywall view can not logged because, [logEveryPaywallView] is disabled in [MBAdaptyConfiguration]';
  static const String loadAllPaywallsError =
      'Error occurred while loadAllPaywallsByPlacements]';
  static const String loadPaywallError = 'Error occurred while [onGetPaywall]';
  static const String viewedStackFirstWhereError =
      'Type casting or search error occurred while get cached paywall from stack.';
  static const String makePurchaseError =
      'Error occurred while [onMakePurchase]';
  static const String restorePurchasesError =
      'Error occurred while [onRestorePurchases]';
  static const String getAdaptyProfileError =
      'Error occurred while [updateAndGetProfile]';
  static const String logPaywallError = 'Error occurred while [onPaywallView]';
}
