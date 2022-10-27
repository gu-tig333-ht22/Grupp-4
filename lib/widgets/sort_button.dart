import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final Function(int value) onSelectedFunctionCallback;

  const SortButton({required this.onSelectedFunctionCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(Icons.sort_outlined),
        color: Colors.black,
        onSelected: (int value) {
          onSelectedFunctionCallback(value);
        },
        itemBuilder: (context) => const [
              PopupMenuItem(value: 0, child: Text('Sort by recently added.')),
              PopupMenuItem(value: 1, child: Text('Sort by highest rating. ')),
              PopupMenuItem(value: 2, child: Text('Sort by lowest rating. ')),
            ]);
  }
}
