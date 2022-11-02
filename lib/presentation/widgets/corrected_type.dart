part of 'widgets.dart';

class CorrectedType extends StatelessWidget {
  final String result;
  const CorrectedType({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(
                result == "Normal"
                    ? 'assets/tipe_normal.png'
                    : result == "Pneumonia"
                        ? "assets/tipe_pneumonia.png"
                        : result == "Covid 19"
                            ? "assets/tipe_covid.png"
                            : "assets/tipe_other.jpg",
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          result == "Normal"
              ? 'Normal'
              : result == "Pneumonia"
                  ? "Pneumonia"
                  : result == "Covid 19"
                      ? "Covid 19"
                      : result,
          style: regularFont.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
