import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:toastification/toastification.dart';

final Map<ToastificationType, Color> colorProgressBar = {
  ToastificationType.success: Colors.green,
  ToastificationType.warning: Colors.yellow,
  ToastificationType.error: Colors.red,
  ToastificationType.info: Colors.blue,
};

final Map<ToastificationType, Icon> iconAlertToast = {
  ToastificationType.success: const Icon(Icons.check),
  ToastificationType.warning: const Icon(Icons.warning),
  ToastificationType.error: const Icon(Icons.error),
  ToastificationType.info: const Icon(Icons.info),
};

void toastAlert(
    {required BuildContext context,
    required ToastificationType typeAlert,
    required String title,
    required String description,
    Icon? iconAlert}) {
  toastification.show(
      context: context,
      type: typeAlert,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(title),
      description: RichText(
        text: TextSpan(
            text: description,
            style: const TextStyle(color: $colorTextBlack, fontSize: 16)),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: iconAlert ?? iconAlertToast[typeAlert],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.none,
      closeOnClick: false,
      pauseOnHover: true,
      progressBarTheme: ProgressIndicatorThemeData(
        color: colorProgressBar[typeAlert],
      ));
}
