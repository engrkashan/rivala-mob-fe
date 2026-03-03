import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';

class PlatformConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final bool isDestructive;

  const PlatformConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = "Confirm",
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return widget_cupertion_alert(
        title: title,
        message: message,
        confirmText: confirmText,
        isDestructive: isDestructive,
      );
    }
    return widget_material_alert(
      title: title,
      message: message,
      confirmText: confirmText,
      isDestructive: isDestructive,
    );
  }
}

class widget_material_alert extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final bool isDestructive;

  const widget_material_alert({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.isDestructive,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmText,
            style: TextStyle(color: isDestructive ? kred : kblue),
          ),
        ),
      ],
    );
  }
}

class widget_cupertion_alert extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final bool isDestructive;

  const widget_cupertion_alert({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.isDestructive,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: 270,
            decoration: BoxDecoration(
              color: kwhite,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(
                          confirmText,
                          style: TextStyle(
                              color: isDestructive ? kred : kblue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
