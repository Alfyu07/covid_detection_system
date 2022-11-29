part of '../pages.dart';

class DiagnoseHistoryPage extends StatelessWidget {
  const DiagnoseHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: edge),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        final navProvider = Provider.of<BottomNavProvider>(
                          context,
                          listen: false,
                        );
                        navProvider.index = 0;
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Image.asset(
                        'assets/arrow_back_black.png',
                        width: 26,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Diagnose History',
                      style: mediumFont.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        final Diagnosis? result = await showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(),
                        );
                        if (result!.id == null) {
                          return;
                        }

                        detailProvider.diagnosis = result;
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(),
                          ),
                        );
                      },
                      child: Image.asset('assets/search.png', width: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              buildSort(),
              const SizedBox(height: 16),
              buildDiagnoseList(context),
              const SizedBox(height: 16),
            ],
          ),
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
          ? diagnoseProvider.readDiagnoses(0)
          : sortProvider.sortValue == 'Normal'
              ? diagnoseProvider.readNormalDiagnoses(0)
              : sortProvider.sortValue == 'Covid 19'
                  ? diagnoseProvider.readCovidDiagnoses(0)
                  : diagnoseProvider.readPneumoniaDiagnoses(0),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Column(
              children: [
                for (int i = 0; i < 10; i++) buildSkeleton(context),
              ],
            );
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return buildNoData();
              }
              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
                    },
                  );
                }).toList(),
              );
            }
            return buildNoData();
        }
      },
    );
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
                      left: e == sortProvider.sortBy.first ? 24 : 0,
                    ),
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

  Widget buildSkeleton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: edge, right: edge, bottom: 16),
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          const SkeletonContainer.circular(
            width: 64,
            height: 64,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkeletonContainer.rounded(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 16,
              ),
              const SizedBox(height: 8),
              const SkeletonContainer.rounded(
                width: 60,
                height: 12,
              ),
              const SizedBox(height: 8),
              const SkeletonContainer.rounded(
                width: 80,
                height: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
