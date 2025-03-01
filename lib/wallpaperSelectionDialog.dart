import 'package:flutter/material.dart';

class WallpaperSelectionDialog extends StatelessWidget {
  final List<String> screenOptions;
  final ValueChanged<String> onSelection;

  const WallpaperSelectionDialog({
    super.key,
    required this.screenOptions,
    required this.onSelection,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Screen'),
      content: ListView.builder(
        shrinkWrap: true, // Makes the dialog fit its content
        itemCount: screenOptions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(screenOptions[index]),
            onTap: () {
              onSelection(screenOptions[index]);
              Navigator.of(context).pop(); // Close dialog on selection
            },
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () =>
              Navigator.of(context).pop(), // Close dialog on cancel
        ),
      ],
    );
  }
}
