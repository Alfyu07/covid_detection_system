part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: edge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/menu.png', width: 24),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset('assets/search.png', width: 24),
                  ),
                ],
              ),
            ),
            const SizedBox(height: edge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text(
                'Covid Diagnose System',
                style: mediumFont.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text(
                'University of Mataram',
                style: lightFont.copyWith(fontSize: 14),
              ),
            ),
            const SizedBox(height: edge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: CarouselSlider(
                items: const [
                  CarouselItem(
                    image: AssetImage('assets/banner 1.png'),
                    title: 'Wear a mask - saves life',
                    subtitle:
                        'Did you know that wearing a mask can actually saves life?',
                  ),
                  CarouselItem(
                    image: AssetImage('assets/banner 2.png'),
                    title: 'Diagnose with AI',
                    subtitle:
                        'Detect your desease quickly using artificial intelligence model',
                  )
                ],
                options: CarouselOptions(
                  height: 110,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            const SizedBox(height: edge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text('Diagnose', style: mediumFont.copyWith(fontSize: 18)),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: SizedBox(
                height: 28,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 28,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor,
                      ),
                      child: Text('Terbaru',
                          style: whiteMediumFont.copyWith(fontSize: 12)),
                    ),
                    Container(
                      height: 28,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        'Covid 19',
                        style: mediumFont.copyWith(
                            fontSize: 12, color: primaryColor),
                      ),
                    ),
                    Container(
                      height: 28,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        'Pneumonia',
                        style: mediumFont.copyWith(
                            fontSize: 12, color: primaryColor),
                      ),
                    ),
                    Container(
                      height: 28,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        'Normal',
                        style: mediumFont.copyWith(
                            fontSize: 12, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 286,
              color: whiteColor,
              child: ListView.builder(
                itemCount: diagnoses.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    // TODO Navigate to details
                  },
                  child: DiagnosisCard(
                    diagnosis: diagnoses[index],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            //! Disease
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text(
                'Disease',
                style: mediumFont.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
            buildDisease(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget buildDisease() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: edge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DiseaseCard(
              image: Image.asset('assets/tipe_covid.png', width: 70),
              name: 'Covid 19'),
          DiseaseCard(
              image: Image.asset('assets/tipe_pneumonia.png', width: 70),
              name: 'Pneumonia'),
          DiseaseCard(
              image: Image.asset('assets/tipe_normal.png', width: 70),
              name: 'Normal Lungs')
        ],
      ),
    );
  }
}
