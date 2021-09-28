part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.read<User>();
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: edge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Row(
                children: [
                  InkWell(
                    onTap: () =>
                        Provider.of<BottomNavProvider>(context, listen: false)
                            .index = 2,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ghostWhiteColor,
                      child: ClipOval(
                        child: SvgPicture.network(
                          firebaseUser.photoURL ??
                              "https://avatars.dicebear.com/api/jdenticon/default.svg",
                          width: 40,
                          placeholderBuilder: (context) {
                            return Container(width: 40, color: ghostWhiteColor);
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final Diagnosis? result = await showSearch(
                          context: context, delegate: CustomSearchDelegate());
                      if (result!.id == null) {
                        return;
                      }

                      detailProvider.diagnosis = result;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DetailPage()));
                    },
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
            buildDisease(size),
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
    final diagnoseProvider = Provider.of<DiagnoseProvider>(context);
    final sortProvider = Provider.of<SortProvider>(context);
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return StreamBuilder<QuerySnapshot>(
        stream: sortProvider.sortValue == 'Terbaru'
            ? diagnoseProvider.readDiagnoses()
            : sortProvider.sortValue == 'Normal'
                ? diagnoseProvider.readNormalDiagnoses()
                : sortProvider.sortValue == 'Covid 19'
                    ? diagnoseProvider.readCovidDiagnoses()
                    : diagnoseProvider.readPneumoniaDiagnoses(),
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
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }

              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return buildNoData();
                }

                return Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                  final Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  final diagnosis = Diagnosis.fromJson(data);
                  return DiagnosisCard(
                      diagnosis: diagnosis,
                      onTap: () {
                        detailProvider.diagnosis = diagnosis;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WillPopScope(
                              onWillPop: () async {
                                Navigator.of(context).pop();
                                return false;
                              },
                              child: const DetailPage(),
                            ),
                          ),
                        );
                      });
                }).toList());
              }
              return buildNoData();
          }

          // Column(
          //   children: diagnoses.map((e) => DiagnosisCard(diagnosis: e)).toList(),
          // ),
        });
  }

  Container buildNoData() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: edge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Data',
            style: mediumFont,
          ),
        ],
      ),
    );
  }

  Widget buildSort() {
    return SizedBox(
      height: 28,
      child: Consumer<SortProvider>(
        builder: (context, sortProvider, _) => ListView(
          scrollDirection: Axis.horizontal,
          children: sortProvider.sortBy
              .map(
                (e) => InkWell(
                  onTap: () =>
                      sortProvider.index = sortProvider.sortBy.indexOf(e),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: e == sortProvider.sortBy.first ? 24 : 0),
                    child: SortItem(
                      title: e,
                      isActive:
                          sortProvider.index == sortProvider.sortBy.indexOf(e),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget buildDisease(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: edge),
      child: Row(
        mainAxisAlignment: size.width < 480
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.spaceAround,
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
