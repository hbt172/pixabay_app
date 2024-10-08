
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_app/FullScreenImage.dart';

import 'ImageController.dart';

/// Image gallery widget using GetX for state management.
class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.put(ImageController());

    final int crossAxisCount =
    (MediaQuery.of(context).size.width / 200).floor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixabay Image Gallery'),
      ),
      body: Obx(() {
        if (imageController.isLoading.value && imageController.images.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          controller: imageController.scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.0,
          ),
          itemCount: imageController.images.length +
              (imageController.isLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == imageController.images.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final image = imageController.images[index];
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullScreenImage(likes: '${image['likes']}', views: '${image['views']}', image: '${image['webformatURL']}')));
              },
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text('Likes: ${image['likes']}'),
                  subtitle: Text('Views: ${image['views']}'),
                ),
                child: Image.network(image['webformatURL'], fit: BoxFit.cover),
              ),
            );
          },
        );
      }),
    );
  }
}
