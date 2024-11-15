import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OwnMessageCard extends StatelessWidget {
  String msg;
  String time;
  OwnMessageCard({super.key, required this.msg, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
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
            color: Colors.blue.shade50,
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
                  child: Row(
                    children: [
                      Text(time),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.done_all,
                        color: Colors.blue,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
