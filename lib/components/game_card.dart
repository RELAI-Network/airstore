import 'package:flutter/material.dart';
import 'package:futurstore/core/extensions/navigator.dart';

import '../models/game_model.dart';
import '../screens/game_detail_screen.dart';

class GameCard extends StatelessWidget {
  const GameCard({required this.data, super.key});
  final GameModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.pushTo(GameDetailScreen(data));
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const FlutterLogo(
              size: 52,
            ), // You can adjust the size as needed
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                data.title!,
              ), // Assuming 'title' is a field in your AppModel
            ),
          ],
        ),
      ),
    );
  }
}
