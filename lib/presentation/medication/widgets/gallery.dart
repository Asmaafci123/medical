import 'dart:io';

import 'package:flutter/material.dart';
import 'package:more4u/core/constants/api_path.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:more4u/presentation/widgets/utils/app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatefulWidget {
  final List<File> images;
  final int index;

  const Gallery({Key? key, required this.images, this.index = 0})
      :
        super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late int index;
  late final PageController pageController;

  @override
  void initState() {
    index = widget.index;
    pageController = PageController(initialPage: index);

    super.initState();
  }


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,color: AppColors.mainColor,),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PhotoViewGallery.builder(
            backgroundDecoration: const BoxDecoration(color: Colors.white),
            pageController: pageController,
            itemCount: widget.images.length,
            wantKeepAlive: true,
            builder: (context, index) {
              final image = widget.images[index];
              return PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 4.1,
                  heroAttributes: PhotoViewHeroAttributes(tag: index),
                  imageProvider:FileImage(image)
              );
            },
            onPageChanged: (index) => setState(() => this.index = index),
          ),
          Container(
            padding: const EdgeInsets.all(22),
            child: Text(
              '${index + 1}/${widget.images.length}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
