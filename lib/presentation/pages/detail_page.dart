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
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Image.asset('assets/arrow_back_black.png',
                              width: 24),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Diagnostic Result',
                      style: mediumFont,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: diagnosis.result == "Normal"
                      ? Image.asset('assets/emot_smile.png', width: 140)
                      : Image.asset('assets/emot_sad.png', width: 140),
                ),
                const SizedBox(height: edge),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: diagnosis.result == "Normal"
                              ? "They are "
                              : "Infected by ",
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
                              '\nwith ${(diagnosis.normal ?? 0) * 100}% prediction accuracy',
                          style: regularFont.copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
