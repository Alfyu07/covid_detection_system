part of 'pages.dart';

class ZoomPage extends StatelessWidget {
  final Image image;
  const ZoomPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ZoomProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const ImageIcon(
            AssetImage(
              'assets/arrow_back_white.png',
            ),
            size: 24,
          ),
        ),
        title: Text(
          'Preview',
          style: whiteMediumFont.copyWith(fontSize: 16),
        ),
        backgroundColor: Colors.black87.withOpacity(0.7),
      ),
      body: Stack(
        children: [
          /// Image
          InteractiveViewer(
            transformationController: provider.controller,
            maxScale: 4,
            minScale: 1,
            constrained: false,
            onInteractionEnd: (scale) {},
            onInteractionStart: (scale) {},
            child: Hero(
              tag: 'zoom',
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: FittedBox(child: image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
