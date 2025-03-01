import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_check/FullScreen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          "Authorization":
              'wBvwOQ0nuooSX7EktkQodPxVbOGW8T2oeDHpxpuBB0BcAXrBOfMUG8VX'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result["photos"];
      });
      print(images[0]);
    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url = "https://api.pexels.com/v1/curated?per_page=80&page=$page";
    await http.get(Uri.parse(url), headers: {
      "Authorization":
          'wBvwOQ0nuooSX7EktkQodPxVbOGW8T2oeDHpxpuBB0BcAXrBOfMUG8VX'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2 / 4,
                      mainAxisSpacing: 2),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    imageurl: images[index]["src"]
                                        ["large2x"])));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          images[index]["src"]["tiny"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Load More",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
