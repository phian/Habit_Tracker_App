import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';

Future<void> showAlert({
  @required String title,
  @required String text,
  @required BuildContext context,
  @required CoolAlertType type,
  Function onConfirmButtonTap,
  Function onCancelButtonTap,
}) async {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.success,
    animType: CoolAlertAnimType.slideInUp,
    title: title,
    text: text,
    onConfirmBtnTap: onConfirmButtonTap?.call(),
    onCancelBtnTap: onCancelButtonTap?.call(),
  );
}
