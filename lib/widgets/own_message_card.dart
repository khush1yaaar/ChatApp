import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key});

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.blue.shade50,
            child: const Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 10,
                    bottom: 20.0,
                  ),
                  child: Text("If the issue persists, consider reinstalling Android platform-tools from the SDK Manager. Go to Android Studio > SDK Manager > SDK Tools, uncheck “Android SDK Platform-Tools,."),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Row(
                    children: [
                      Text("12:58"),
                      SizedBox(width: 5,),
                      Icon(Icons.done_all, color: Colors.blue,)
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