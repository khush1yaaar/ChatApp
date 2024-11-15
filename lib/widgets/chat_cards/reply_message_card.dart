import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReplyMessageCard extends StatelessWidget {
  String msg;
  String time;
  ReplyMessageCard({super.key, required this.msg, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 2 / 2.5,
            minWidth: 100,
            minHeight: 50,
          ),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 10,
                    bottom: 20.0,
                  ),
                  child: Text(msg),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 5, right: 5),
                      child: Text(time)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
