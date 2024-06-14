import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:unyo/api/anilist_api_anime.dart';

class AnimeButton extends StatefulWidget {
  const AnimeButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.width,
      required this.height,
      required this.horizontalAllignment,
      });

  final String text;
  final void Function() onTap;
  final double width;
  final double height;
  final bool horizontalAllignment;

  @override
  State<AnimeButton> createState() => _AnimeButtonState();
}

class _AnimeButtonState extends State<AnimeButton> {
  String? bannerImageUrl;

  @override
  void initState() {
    super.initState();
    getBanner();
  }

  void getBanner() async {
    String? newUrl;
    newUrl = await getRandomAnimeBanner(0);
    setState(() {
      bannerImageUrl = newUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return bannerImageUrl != null
        ? InkWell(
            onTap: widget.onTap,
            child: HoverAnimatedContainer(
              //TODO check percentages
              duration: const Duration(milliseconds: 130),
              alignment: Alignment.center,
              width: widget.width * 0.3,
              hoverWidth: widget.horizontalAllignment ? widget.width * 0.3 * 1.03 : widget.width * 0.3,
              height: widget.height * 0.1,
              hoverHeight: widget.horizontalAllignment ? widget.height * 0.1 : widget.height * 0.1 * 1.1,
              cursor: SystemMouseCursors.click, 
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  opacity: 0.35,
                  image: NetworkImage(
                    bannerImageUrl!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: widget.width * 0.08,
                    height: 2,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
