part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int initialPage;
  const MainPage({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController pageController;

  final _pageNavigation = [
    const HomePage(),
    Container(),
    const Center(child: Text('Settings')),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<BottomNavProvider>(
        builder: (context, bottomNavProvider, _) => Stack(
          children: [
            _buildBody(bottomNavProvider.index),
            buildBottomNavbar(bottomNavProvider.index)
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavbar(int index) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: onChangeBottomNav,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: index == 0
                    ? Image.asset('assets/home_active.png', width: edge)
                    : Image.asset('assets/home.png', width: edge),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: index == 1
                    ? Image.asset('assets/add_active.png', width: edge)
                    : Image.asset('assets/add.png', width: edge),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: index == 2
                    ? Image.asset('assets/setting_active.png', width: edge)
                    : Image.asset('assets/setting.png', width: edge),
              ),
            ],
          )),
    );
  }

  Widget _buildBody(int index) {
    /// Check if index is in range
    return _pageNavigation.elementAt(index);
  }

  void onChangeBottomNav(int index) {
    if (index == 1) {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        barrierColor: blackColor.withOpacity(0.2),
        context: context,
        builder: (BuildContext context) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          child: buildSheet(),
        ),
      );
      return;
    }
    Provider.of<BottomNavProvider>(context, listen: false).setIndex(index);
  }

  Widget buildSheet() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Container(
              height: 4,
              width: 36,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Color(0xffBABEDE)),
            ),
          ),
          const SizedBox(height: edge),
          const Text(
            'Image Source',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: edge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Image.asset(
                      'assets/gallery.png',
                      width: 64,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Gallery',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Image.asset(
                      'assets/camera.png',
                      width: 64,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Camera',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: edge),
        ],
      );
}
