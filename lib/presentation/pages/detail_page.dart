part of 'pages.dart';

class DetailPage extends StatelessWidget {
  final Diagnosis diagnosis;
  const DetailPage({Key? key, required this.diagnosis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        final navProvider = Provider.of<BottomNavProvider>(
                            context,
                            listen: false);
                        navProvider.setIndex(0);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ),
                        );
                      },
                      child:
                          Image.asset('assets/arrow_back_black.png', width: 26),
                    ),
                    Text(
                      'Diagnostic Result',
                      style: mediumFont.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: 26),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: diagnosis.result == "Normal"
                      ? Image.asset('assets/emot_smile.png', width: 140)
                      : Image.asset('assets/emot_sad.png', width: 140),
                ),
                const SizedBox(height: edge),
                buildReport(),
                const SizedBox(height: 32),
                buildPredictionDetails(),
                const SizedBox(height: 32),
                // * Selected Image
                InkWell(
                  onTap: () {
                    final bool visibility =
                        Provider.of<DetailProvider>(context, listen: false)
                            .isImgVisible;
                    Provider.of<DetailProvider>(context, listen: false)
                        .setImgVisibility(!visibility);
                  },
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Selected Image', style: mediumFont),
                        Consumer<DetailProvider>(
                          builder: (context, detailProvider, _) => Image.asset(
                            detailProvider.isImgVisible
                                ? 'assets/arrow_up.png'
                                : 'assets/arrow_down.png',
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<DetailProvider>(
                  builder: (context, detailProvider, _) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    height: detailProvider.isImgVisible ? 160 : 0,
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 160,
                        decoration: BoxDecoration(
                          color: ghostWhiteColor,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(diagnosis.imgUrl ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (diagnosis.isCorrected!)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Corrected Result', style: mediumFont),
                      const SizedBox(height: 16),
                      CorrectedType(result: diagnosis.result!),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Is this diagnosis correct?', style: regularFont),
                      const SizedBox(height: 24),
                      ButtonPrimary(text: "True", onPressed: () {}),
                      const SizedBox(height: 16),
                      ButtonSecondary(text: "False", onPressed: () {}),
                    ],
                  ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPredictionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prediction Details',
          style: mediumFont.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Text(
                'Covid 19',
                style: lightFont.copyWith(fontSize: 12),
              ),
            ),
            ProgressBar(
              value: diagnosis.covid ?? 0,
              color: redColor,
            ),
            SizedBox(
              width: 23,
              child: Text(
                '${((diagnosis.covid ?? 0) * 100).round()}%',
                style: lightFont.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Text(
                'Pneumonia',
                style: lightFont.copyWith(fontSize: 12),
              ),
            ),
            ProgressBar(
              value: diagnosis.pneumonia ?? 0,
              color: yellowColor,
            ),
            SizedBox(
              width: 23,
              child: Text(
                '${((diagnosis.pneumonia ?? 0) * 100).round()}%',
                style: lightFont.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Text(
                'Normal',
                style: lightFont.copyWith(fontSize: 12),
              ),
            ),
            ProgressBar(
              value: diagnosis.normal ?? 0,
              color: greenColor,
            ),
            SizedBox(
              width: 23,
              child: Text(
                '${((diagnosis.normal ?? 0) * 100).round()}%',
                style: lightFont.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildReport() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: diagnosis.result == "Normal" ? "They are " : "Infected by ",
              style: regularFont,
            ),
            TextSpan(
              text: diagnosis.result,
              style: boldFont.copyWith(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
            TextSpan(
              text:
                  '\nwith ${((diagnosis.result == "Normal" ? diagnosis.normal : diagnosis.result == "Pneumonia" ? diagnosis.pneumonia : diagnosis.covid) ?? 0) * 100}% prediction accuracy',
              style: regularFont.copyWith(height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
