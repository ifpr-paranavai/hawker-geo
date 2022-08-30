/*
 * Created by Kairo Amorim on 30/08/2022 18:20
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 18:20
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../styles/color.dart';

class SharedPopUps {
  errorPopUp(BuildContext context,
      {String? title, required String description, required String buttonText}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: AlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              : null,
          content: Text(
            description,
            style: Theme.of(context).textTheme.bodyText2!,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 20, color: kPrimaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  genericPopUp(BuildContext context,
      {String? title,
      bool scrollable = false,
      required String description,

      ///Cancel button
      String? cancelButtonText,
      Color? cancelButtonColor,
      GestureTapCallback? cancelButtonOnPressed,

      ///Accept button
      String? acceptButtonText,
      Color? acceptButtonColor,
      VoidCallback? acceptButtonOnPressed,
      bool barrierDismissible = false}) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Center(
        child: AlertDialog(
          scrollable: scrollable,
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              : null,
          content: Text(
            description,
            style: Theme.of(context).textTheme.bodyText2!,
          ),
          actions: [
            if (cancelButtonText != null) ...[
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(cancelButtonColor)),
                  onPressed: cancelButtonOnPressed,
                  child: Text(
                    cancelButtonText,
                    style: const TextStyle(
                        fontSize: 16, color: kTextColor, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
            if (acceptButtonText != null) ...[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(acceptButtonColor)),
                  onPressed: acceptButtonOnPressed,
                  child: Text(
                    acceptButtonText,
                    style: const TextStyle(
                        fontSize: 16, color: kTextColor, fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
