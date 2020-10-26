import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';

class HaweyatiAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool hideHome;
  final double progress;
  final List<Widget> actions;

  const HaweyatiAppBar({
    this.hideHome = false,
    this.actions,
    this.progress = 0.0
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> _actions = [];
    if (!hideHome) _actions.add(
      GestureDetector(
        child: Image.asset(HomeIcon, width: 23, color: Colors.white),
        onTap: () => Navigator
            .of(context)
            .popUntil((route) => route.settings.name == '/')
      )
    );

    Widget _leading;
    if (Navigator.of(context).canPop()) {
      _leading = IconButton(
        icon: Image.asset(ArrowBackIcon, width: 26, height: 26),
        onPressed: Navigator.of(context).pop,
      );
    }
    Widget _progress;
    if (progress > 0.0) {
      _progress = PreferredSize(
        preferredSize: Size.fromHeight(3),
        child: SizedBox(
          height: 3,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
          )
        )
      );
    }

    return AppBar(
      elevation: 0,
      bottom: _progress,
      leading: _leading,
      actions: actions ?? _actions,
      centerTitle: true,
      title: const Image(
        width: 33, height: 33,
        image: const AssetImage(AppLogo),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
