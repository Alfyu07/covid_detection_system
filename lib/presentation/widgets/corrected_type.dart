part of 'widgets.dart';

class CorrectedType extends StatelessWidget {
  final String result;
  const CorrectedType({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          result == "Normal"
              ? 'assets/tipe_normal.png'
              : result == "Pneumonia"
                  ? "assets/tipe_pneumonia.png"
                  : "assets/tipe_covid.png",
          width: 38,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          result == "Normal"
              ? 'Normal Lungs'
              : result == "Pneumonia"
                  ? "Pneumonia"
                  : "COVID-19",
          style: regularFont.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
