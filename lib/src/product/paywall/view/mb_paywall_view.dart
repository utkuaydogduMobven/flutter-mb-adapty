// ignore_for_file: inference_failure_on_function_return_type, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mb_adapty/src/product/paywall/viewmodel/paywall_viewmodel.dart';

import '../../../../flutter_mb_adapty.dart';
import '../viewmodel/state/paywall_state.dart';

typedef WidgetBuilder = Widget Function(
  BuildContext,
  PaywallViewmodel,
  PaywallState,
);
typedef ViewModelBuilder = PaywallViewmodel Function(BuildContext);
typedef InitializeCallback = void Function(BuildContext);
typedef DisposeCallback = void Function(BuildContext);
typedef PostFrameCallback = void Function(BuildContext);

/// Base class for views that are connected to a [BaseCubit] and use
/// [EquatableState] as the state.
class MBPaywallView extends StatefulWidget {
  /// Creates a new [MBPaywallView] instance.
  ///
  /// The [vmBuilder] and [builder] parameters are required. The [vmBuilder]
  /// parameter is a function that creates an instance of [BaseCubit]. The
  /// [builder] parameter is a function that builds the UI based on the
  /// [BuildContext] and the [BaseCubit] and [EquatableState] instances.
  ///
  /// The [onInitialize] parameter is optional. If provided, it will be called
  /// when the view before initialized.
  ///
  /// The [useDefaultLoading] parameter is optional. If set to `true`, the
  /// default loading widget will be used.
  const MBPaywallView({
    this.onInitialize,
    this.onDispose,
    this.onPostFrame,
    this.vmBuilder,
    this.builder,
    this.isAppWrapper = false,
    this.useDefaultLoading = true,
    this.authGuardEnabled = false,
    this.ignorePointerWhenLoading = true,
    this.disableLoadingOverlay = false,
    super.key,
  }) : assert(
          vmBuilder != null || builder != null,
          'vmBuilder or builder must not be null',
        );

  /// The function that creates an instance of [BaseCubit].
  final ViewModelBuilder? vmBuilder;

  /// The function that builds the UI based on the [BuildContext] and the
  final WidgetBuilder? builder;

  /// The function that will be called when the view before initialized.
  final InitializeCallback? onInitialize;

  /// The function that will be called when the view is disposed.
  final DisposeCallback? onDispose;

  /// The function that will be called after the view is initialized.
  final PostFrameCallback? onPostFrame;

  /// A boolean value that indicates whether the pointer should be ignored when
  /// the state is loading.
  ///
  /// Defaults to `true`.
  final bool ignorePointerWhenLoading;

  /// A boolean value that indicates whether the default loading widget should
  /// be used.
  ///
  /// Defaults to `true`.
  final bool useDefaultLoading;

  /// A boolean value that indicates whether the auth guard is enabled.
  ///
  /// Defaults to `false`.
  final bool authGuardEnabled;

  /// A boolean value that indicates whether the view is an app wrapper.
  ///
  /// Defaults to `false`.
  final bool isAppWrapper;

  /// A boolean value that indicates whether the loading overlay should be
  /// disabled.
  ///
  /// Defaults to `false`.
  final bool disableLoadingOverlay;

  @override
  _MBPaywallViewState createState() => _MBPaywallViewState();
}

class _MBPaywallViewState extends BaseState<MBPaywallView> {
  @override
  void initState() {
    super.initState();
    widget.onInitialize?.call(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPostFrame?.call(context);
    });
  }

  @override
  void dispose() {
    widget.onDispose?.call(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.authGuardEnabled) {
      true => switch (productViewModel.userAuthStatus == UserStatus.loggedIn) {
          false => _unauthorizedInfoView,
          true => switch (widget.isAppWrapper) {
              false => _defaultView,
              true => _appWrapperView,
            },
        },
      false => switch (widget.isAppWrapper) {
          false => _defaultView,
          true => _appWrapperView,
        }
    };
  }

  /// Returns the default view.
  ///
  /// The default view is a view that uses the [BlocProvider] and [BlocBuilder]
  /// widgets to provide the [BaseCubit] instance and build the UI based on the
  /// [BuildContext] and the [BaseCubit] and [EquatableState] instances.
  Widget get _defaultView {
    return BlocProvider<PaywallViewmodel>(
      create: widget.vmBuilder!,
      child: BlocBuilder<PaywallViewmodel, PaywallState>(
        builder: _buildAuthenticatedContent,
      ),
    );
  }

  /// Returns the app wrapper view.
  ///
  /// The app wrapper view is a view that uses the [BlocConsumer] widget to
  /// provide the [BaseCubit] instance and build the UI based on the
  /// [BuildContext] and the [BaseCubit] and [EquatableState] instances.
  Widget get _appWrapperView {
    return BlocConsumer<PaywallViewmodel, PaywallState>(
      listener: (context, state) {},
      /* BlocListenerManager.getListener<R>(StateErrorListener()), */
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              widget.builder!(
                  context, context.watch<PaywallViewmodel>(), state),
              if (state.isLoading && !widget.disableLoadingOverlay)
                const ProductLoadingOverlay(),
              if (state.status == StateType.ERROR)
                const ProjectErrorStateView(),
            ],
          ),
        );
      },
    );
  }

  /// Returns the unauthorized info view.
  Widget get _unauthorizedInfoView => const UnauthorizedInfoView();

  /// Renders the loading overlay.
  Widget get _buildFadeLoading => const ProductLoadingOverlay();

  /// Builds the authenticated content.
  ///
  /// The authenticated content is a widget that uses the [CustomLoading] and
  /// [ProjectErrorStateView] widgets to display the loading and error states.
  /// If the [useDefaultLoading] parameter is set to `true`, the default loading
  /// widget will be used.
  Widget _buildAuthenticatedContent(BuildContext context, PaywallState state) {
    if (state.status == StateType.LOADING && widget.useDefaultLoading) {
      return const CustomLoading();
    }
    if (state.status == StateType.ERROR) {
      return ProjectErrorStateView(
          onRetry: context.read<PaywallViewmodel>().initialEvent);
    }
    return IgnorePointer(
      ignoring: widget.ignorePointerWhenLoading ? state.isLoading : false,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          if (!widget.disableLoadingOverlay) ...{
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              reverseDuration: const Duration(milliseconds: 300),
              child:
                  state.isLoading ? _buildFadeLoading : const SizedBox.shrink(),
            ),
          },
          widget.builder!(context, context.watch<PaywallViewmodel>(), state),
        ],
      ),
    );
  }
}
