import 'dart:async';

import 'package:flutter/material.dart';

class ToastWidget {
  ToastWidget(this.context);
  BuildContext context;

  lostConnection({
    String text = "การเชื่อมต่อมีปัญหา",
    int time = 1000,
  }) {
    Timer timer = Timer(Duration(milliseconds: time), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              // overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  // width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[600],
                  ),
                  padding: EdgeInsets.only(left: 5, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_outlined,
                        color: Colors.white,
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    ).then((value) {
      timer.cancel();
    });
  }

  errorAction({
    String text = "ไม่สามารถทำรายการได้",
    int time = 1000,
  }) {
    Timer timer = Timer(Duration(milliseconds: time), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              // overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  // width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[600],
                  ),
                  padding: EdgeInsets.only(left: 5, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_outlined,
                        color: Colors.white,
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    ).then((value) {
      timer.cancel();
    });
  }

  successAction({
    String text = "ทำรายการสำเร็จ",
    int time = 1000,
  }) {
    Timer timer = Timer(Duration(milliseconds: time), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              // overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  // width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green,
                  ),
                  padding: EdgeInsets.only(left: 5, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    ).then((value) {
      timer.cancel();
    });
  }
}
