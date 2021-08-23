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
            buildCarousel(),
            const SizedBox(height: edge),
            //! Diagnose
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text('Diagnose', style: mediumFont.copyWith(fontSize: 18)),
            ),
            const SizedBox(height: 16),
            buildSort(),
            const SizedBox(height: 16),
            buildDiagnoseList(context),
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

  Padding buildCarousel() {
    return Padding(
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
          autoPlay: true,
        ),
      ),
    );
  }

  Widget buildDiagnoseList(BuildContext context) {
    return FutureBuilder<List<Diagnosis>>(
      future: Api.readDiagnoses(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: primaryColor),
                ],
              ),
            );
          default:
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                children: snapshot.data!
                    .map((e) => DiagnosisCard(diagnosis: e))
                    .toList(),
              );
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: edge),
                height: 80,
                child: Center(
                  child: Text(
                    'No Data',
                    style: mediumFont.copyWith(fontSize: 16),
                  ),
                ),
              );
            }
        }

        // Column(
        //   children: diagnoses.map((e) => DiagnosisCard(diagnosis: e)).toList(),
        // ),
      },
    );
  }

  Widget buildSort() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: edge),
      child: SizedBox(
        height: 28,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              height: 28,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                'Covid 19',
                style: mediumFont.copyWith(fontSize: 12, color: primaryColor),
              ),
            ),
            Container(
              height: 28,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                'Pneumonia',
                style: mediumFont.copyWith(fontSize: 12, color: primaryColor),
              ),
            ),
            Container(
              height: 28,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                'Normal',
                style: mediumFont.copyWith(fontSize: 12, color: primaryColor),
              ),
            ),
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
