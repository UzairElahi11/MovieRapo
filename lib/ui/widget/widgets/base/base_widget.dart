import 'package:flutter/material.dart';
import 'package:testmovie/ui/widget/widgets/app_colors.dart';
import 'package:testmovie/ui/widget/widgets/extensions/padding_extension.dart';


class BaseWidget extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Color? scaffoldBackgroundColor;
  final Color? appNavigationBarColor;
  final bool showBg;
  final bool useBaseWidgetPadding;
  final bool resizeToAvoidBottomPadding;
  final Widget? bottomNavigationBar;
  final Widget? floatingButton;
  final FloatingActionButtonLocation? floatingButtonPosition;
  final Widget? drawer;
  final bool? extendBody;

  const BaseWidget({
    Key? key,
    required this.child,
    this.appNavigationBarColor,
    this.scaffoldBackgroundColor,
    this.appBar,
    this.useBaseWidgetPadding = false,
    this.resizeToAvoidBottomPadding = false,
    this.showBg = true,
    this.bottomNavigationBar,
    this.floatingButton,
    this.floatingButtonPosition,
    this.drawer,
    this.extendBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody ?? false,
      bottomNavigationBar: bottomNavigationBar ?? const SizedBox.shrink(),
      endDrawer: drawer,
      floatingActionButton: floatingButton,
      floatingActionButtonLocation: floatingButtonPosition ?? FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
      backgroundColor: scaffoldBackgroundColor ?? AppColors().colorFFFFFF,
      appBar: appBar,
      body: Padding(
        padding: useBaseWidgetPadding ? (20, 0).symmetricPaddingDirectional : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
