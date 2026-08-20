import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom_image_view/custom_image_view.dart';
import 'package:healing/controller/usercontroller/view_detail_controller.dart';
import 'package:healing/core/image_constant/image_constant.dart';
import 'package:healing/common/common_widget.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class ViewDetailGallery extends StatefulWidget {
  final ViewDetailController controller;

  const ViewDetailGallery({super.key, required this.controller});

  @override
  State<ViewDetailGallery> createState() => _ViewDetailGalleryState();
}

class _ViewDetailGalleryState extends State<ViewDetailGallery> {
  int _selectedImageIndex = 0;

  void _openFullScreenViewer(
    BuildContext context,
    List<String> imageUrls,
    int initialIndex,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImageViewer(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return Container(
          margin: const EdgeInsets.all(16),
          height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const CommonCircularIndicator(),
        );
      }
      final doc = widget.controller.centerDetail;
      final List<String> imageUrls = [];

      if (doc.gallery != null) {
        for (var img in doc.gallery!) {
          if (img.url != null && img.url!.isNotEmpty) {
            imageUrls.add(img.url!);
          }
        }
      }

      if (imageUrls.isEmpty) {
        imageUrls.add(ImageConstant.imageNotFound);
      }

      if (_selectedImageIndex >= imageUrls.length) {
        _selectedImageIndex = 0;
      }

      final mainImage = imageUrls[_selectedImageIndex];

      return Container(
        margin: const EdgeInsets.all(16),
        height: 320,
        width: double.infinity,
        child: Stack(
          children: [
            // Main Image
            GestureDetector(
              onTap: () => _openFullScreenViewer(
                context,
                imageUrls,
                _selectedImageIndex,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: _buildImageView(
                  mainImage,
                  width: double.infinity,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Favorite Button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  widget.controller.toggleFavoriteCentre();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.controller.isFavorite.value
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: widget.controller.isFavorite.value
                        ? Colors.red
                        : Colors.grey,
                    size: 24,
                  ),
                ),
              ),
            ),

            // Bottom Thumbnails
            if (imageUrls.length > 1)
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(children: _buildThumbnailRow(context, imageUrls)),
              ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildThumbnailRow(
    BuildContext context,
    List<String> imageUrls,
  ) {
    final List<Widget> thumbnailWidgets = [];
    const int maxThumbnails = 4;
    final int displayCount = imageUrls.length > maxThumbnails
        ? maxThumbnails
        : imageUrls.length;

    for (int i = 0; i < displayCount; i++) {
      final isLast =
          (i == displayCount - 1 && imageUrls.length > maxThumbnails);

      Widget thumb;
      if (isLast) {
        final remainingCount = imageUrls.length - (maxThumbnails - 1);
        thumb = Expanded(
          child: GestureDetector(
            onTap: () => _openFullScreenViewer(context, imageUrls, i),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildThumbnail(
                  imageUrls[i],
                  isFullWidth: true,
                  isSelected: _selectedImageIndex == i,
                ),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+$remainingCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        thumb = GestureDetector(
          onTap: () {
            setState(() {
              _selectedImageIndex = i;
            });
          },
          child: _buildThumbnail(
            imageUrls[i],
            isFullWidth: false,
            isSelected: _selectedImageIndex == i,
          ),
        );
      }

      thumbnailWidgets.add(thumb);
      if (i < displayCount - 1 && !isLast) {
        thumbnailWidgets.add(const SizedBox(width: 8));
      }
    }

    return thumbnailWidgets;
  }

  Widget _buildThumbnail(
    String pathOrUrl, {
    required bool isFullWidth,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? ColorConstant.appColor : Colors.transparent,
          width: isSelected ? 2.0 : 0.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isSelected ? 10 : 12),
        child: _buildImageView(
          pathOrUrl,
          height: 52,
          width: isFullWidth ? double.infinity : 68,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildImageView(
    String pathOrUrl, {
    required double width,
    required double height,
    required BoxFit fit,
  }) {
    if (pathOrUrl.startsWith('http://') || pathOrUrl.startsWith('https://')) {
      return CustomImageView(
        url: pathOrUrl,
        width: width,
        height: height,
        fit: fit,
        errorWidget: (_, _, _) =>
            Image.asset(ImageConstant.imageNotFound, fit: BoxFit.cover),
      );
    } else {
      return CustomImageView(
        imagePath: pathOrUrl,
        width: width,
        height: height,
        fit: fit,
        errorWidget: (_, _, _) =>
            Image.asset(ImageConstant.imageNotFound, fit: BoxFit.cover),
      );
    }
  }
}

class FullScreenImageViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final pathOrUrl = widget.imageUrls[index];
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child:
                      pathOrUrl.startsWith('http://') ||
                          pathOrUrl.startsWith('https://')
                      ? CustomImageView(
                          url: pathOrUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                          errorWidget: (_, _, _) => Image.asset(
                            ImageConstant.imageNotFound,
                            fit: BoxFit.contain,
                          ),
                        )
                      : CustomImageView(
                          imagePath: pathOrUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                          errorWidget: (_, _, _) => Image.asset(
                            ImageConstant.imageNotFound,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    '${_currentIndex + 1} / ${widget.imageUrls.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
