import 'package:flutter/material.dart';
import 'package:sultanpos/state/app.dart';

class OnlineOfflieWidget extends StatelessWidget {
  const OnlineOfflieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: AppState().websocketTransport.getOnlineStream(),
      initialData: false,
      builder: (context, snapshot) {
        final value = snapshot.data ?? false;
        return Container(
          decoration: BoxDecoration(
              color: value ? Colors.green : Colors.red, borderRadius: const BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Text(
            value ? 'ONLINE' : 'OFFLINE',
            style: const TextStyle(fontSize: 10),
          ),
        );
      },
    );
  }
}
