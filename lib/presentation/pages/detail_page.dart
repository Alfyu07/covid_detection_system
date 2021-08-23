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
                        Navigator.of(context).pop();
                      },
                      child:
                          Image.asset('assets/arrow_back_black.png', width: 24),
                    ),
                    Text(
                      'Diagnostic Result',
                      style: mediumFont.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: edge),
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
            ),
          ),
        ),
      ),
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
