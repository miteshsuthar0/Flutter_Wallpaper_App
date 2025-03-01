import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({super.key, required this.imageurl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallpaper() async {
    // Show the selection dialog before setting wallpaper
    // await showDialog(
    //   context: context,
    //   builder: (context) => WallpaperSelectionDialog(
    //     screenOptions: ['Home Screen', 'Lock Screen', 'Both'], // Adjust screen options if needed
    //     onSelection: (selectedScreen) async {
    //       int location = WallpaperManager.HOME_SCREEN;
    //       switch (selectedScreen) {
    //         case 'Home Screen':
    //           location = WallpaperManager.HOME_SCREEN;
    //           break;
    //         case 'Lock Screen':
    //           location = WallpaperManager.LOCK_SCREEN;
    //           break;
    //         case 'Both Screen':
    //           location = WallpaperManager.BOTH_SCREENS;
    //           break;
    //       }
    //       var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    //       var result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    //       // Handle the result (success/failure)
    //     },
    //   ),
    // );
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    var result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wallpaper set successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Image.network(widget.imageurl),
            )),
            InkWell(
              onTap: () async {
                setWallpaper();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "Set Wallpaper",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
