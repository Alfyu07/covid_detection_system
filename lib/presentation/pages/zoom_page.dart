part of 'pages.dart';

class ZoomPage extends StatefulWidget {
  final Image image;
  final String tag;
  const ZoomPage({Key? key, required this.image, required this.tag})
      : super(key: key);

  @override
  State<ZoomPage> createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> with TickerProviderStateMixin {
  final _controller = TransformationController();
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _controller.addListener(() {
      if (_controller.value.getMaxScaleOnAxis() > 1.3) {
        print("scaled up > 1.3");
      }
    });
  }

  void reset() {
    // setState(() {
    //   _controller.value = Matrix4.identity();
    // });
    final animationReset = Matrix4Tween(
      begin: _controller.value,
      end: Matrix4.identity(),
    ).animate(_animationController);

    animationReset.addListener(() {
      _controller.value = animationReset.value;
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Stack(
        children: [
          /// Image
          InteractiveViewer(
            transformationController: _controller,
            minScale: 1,
            constrained: false,
            onInteractionEnd: (scale) {
              reset();
            },
            onInteractionStart: (scale) {},
            child: Hero(
              tag: widget.tag,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: FittedBox(child: widget.image),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                padding: const EdgeInsets.only(
                  left: edge,
                  right: edge,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Center(
                          child: Image.asset(
                            'assets/arrow_back_white.png',
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Preview',
                      style: whiteMediumFont.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
