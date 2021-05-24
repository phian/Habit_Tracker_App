import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:rate_my_app/rate_my_app.dart';

class InitRateMyAppWidget extends StatefulWidget {
  final Widget Function(RateMyApp) builder;

  const InitRateMyAppWidget({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  _InitRateMyAppWidgetState createState() => _InitRateMyAppWidgetState();
}

class _InitRateMyAppWidgetState extends State<InitRateMyAppWidget> {
  RateMyApp rateMyApp;

  @override
  Widget build(BuildContext context) => RateMyAppBuilder(
        rateMyApp: RateMyApp(
          googlePlayIdentifier: AppConstants.playStoreId,
          appStoreIdentifier: AppConstants.appStoreId,
          minDays: 0,
          minLaunches: 2,
          // remindDays: 1,
          // remindLaunches: 1,
        ),
        onInitialized: (context, rateMyApp) {
          setState(() => this.rateMyApp = rateMyApp);

          if (rateMyApp.shouldOpenDialog) {
            rateMyApp.showRateDialog(context);
          }
        },
        builder: (context) => rateMyApp == null
            ? Center(child: SpinKitFadingCube(color: AppColors.cFFFF))
            : widget.builder(rateMyApp),
      );
}
