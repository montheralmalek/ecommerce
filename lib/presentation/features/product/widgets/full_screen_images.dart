import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void showFullScreenImages(
  BuildContext context, {
  required int currentIndex,
  required List<String> imageUrls,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return _FullScreenImages(
          imageUrls: imageUrls,
          initialIndex: currentIndex,
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}

class _FullScreenImages extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const _FullScreenImages({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImages> createState() => _FullScreenImagesState();
}

class _FullScreenImagesState extends State<_FullScreenImages> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // material: (context, platform) => MaterialScaffoldData(extendBody: true),
      // cupertino: (context, platform) => CupertinoPageScaffoldData(),
      body: Stack(
        children: [
          // Blurred background barrier
          // Positioned.fill(child: Container(color: Colors.white30)),

          // Main gallery content
          GestureDetector(
            onTap: _toggleControls,
            child: PhotoViewGallery.builder(
              pageController: _pageController,
              itemCount: widget.imageUrls.length,

              onPageChanged: (index) => setState(() => _currentIndex = index),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.imageUrls[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.imageUrls[index],
                    transitionOnUserGestures: true,
                  ),
                );
              },
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              loadingBuilder:
                  (context, event) => Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      child: CircularProgressIndicator(
                        value:
                            event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes!,
                      ),
                    ),
                  ),
            ),
          ),

          // Control buttons
          if (_showControls) ...[
            // Close button
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // Previous button
            if (widget.imageUrls.length > 1)
              Positioned(
                left: 20,
                top: MediaQuery.of(context).size.height / 2 - 30,
                child: IconButton.filledTonal(
                  icon: const Icon(Icons.chevron_left, size: 40),
                  onPressed:
                      _currentIndex > 0
                          ? () {
                            _pageController.animateToPage(
                              _currentIndex - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                          : null,
                ),
              ),

            // Next button
            if (widget.imageUrls.length > 1)
              Positioned(
                right: 20,
                top: MediaQuery.of(context).size.height / 2 - 30,
                child: IconButton.filledTonal(
                  icon: const Icon(Icons.chevron_right, size: 40),
                  onPressed:
                      _currentIndex < widget.imageUrls.length - 1
                          ? () {
                            _pageController.animateToPage(
                              _currentIndex + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                          : null,
                ),
              ),

            // Position indicator
            if (widget.imageUrls.length > 1)
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.imageUrls.length, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index
                                ? Colors.white
                                : Colors.white.withAlpha(127),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
