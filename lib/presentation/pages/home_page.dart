part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: edge),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/menu.png', width: 24),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset('assets/search.png', width: 24),
                  ),
                ],
              ),
              const SizedBox(height: edge),
              Text(
                'Covid Diagnose System',
                style: mediumFont.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 4),
              Text(
                'University of Mataram',
                style: lightFont.copyWith(fontSize: 14),
              ),
              const SizedBox(height: edge),
              const CarouselItem(
                image: AssetImage('assets/banner 1.png'),
                title: 'Wear a mask - saves life',
                subtitle:
                    'Did you know that wearing a mask can actually saves life?',
              )
            ],
          ),
        ),
      ),
    );
  }
}
