import 'package:flutter/material.dart';
import 'package:testmovie/ui/widget/widgets/generic_text.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeading;
  final String? title;
  final TextStyle? style;
  final Color? appBarBackgroundColor;
  final Color? backIconColor;
  final double? elevation;
  final Widget? iconNotification;
  final bool? isIconShow;
  final bool? isTitleCenter;
  final VoidCallback? refreshTap;
  final Widget? drawerWidget;
  final bool? showTopBar;
  final bool refreshIcon;
  final Function()? navigateToSpocHome;
  final bool showBranchIcon;
  final VoidCallback? branchOntap;
  final Widget? leading;
  final VoidCallback? leadingOnTap;
  final bool showLeading;
  final bool? titleForAppBar;
  final Widget? showTitleWidget;

  const GenericAppBar({
    Key? key,
    this.title,
    this.automaticallyImplyLeading,
    this.style,
    this.appBarBackgroundColor,
    this.backIconColor,
    this.elevation,
    this.iconNotification,
    this.isIconShow = true,
    this.refreshIcon = true,
    this.isTitleCenter,
    this.refreshTap,
    this.drawerWidget,
    this.showTopBar = true,
    this.navigateToSpocHome,
    this.showBranchIcon = false,
    this.leading,
    this.branchOntap,
    this.leadingOnTap,
    this.showLeading = false,
    this.titleForAppBar = false,
    this.showTitleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isTitleCenter ?? false,
      iconTheme: IconThemeData(
        color: backIconColor ?? Colors.white,
      ),
      elevation: elevation ?? 0.0,
      backgroundColor: appBarBackgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      titleSpacing: automaticallyImplyLeading == false
          ? showLeading
              ? 0
              : 20
          : -5,
      title: GenericText(
        title ?? "",
        style: style,
      ),
      bottom: const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox.shrink(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        showTopBar == true ? 70 : 50,
      );
}
