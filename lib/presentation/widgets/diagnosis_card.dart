part of 'widgets.dart';

class DiagnosisCard extends StatelessWidget {
  final Diagnosis diagnosis;
  const DiagnosisCard({Key? key, required this.diagnosis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: edge, right: edge, bottom: 16),
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 24,
              offset: const Offset(0, 16),
              color: const Color(0xff7090B0).withOpacity(0.15))
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              diagnosis.imgUrl ?? "",
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                diagnosis.id,
                style: mediumFont,
              ),
              Text(
                (diagnosis.date == null)
                    ? "null"
                    : DateFormat.yMMMd().format(diagnosis.date!),
                style: lightFont.copyWith(
                    fontSize: 12, color: blueGreyColor, height: 1.2),
              ),
              const SizedBox(height: 8),
              if (diagnosis.result == 'Normal')
                Text(
                  diagnosis.result ?? "null",
                  style: mediumFont.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                )
              else
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Infected by ',
                      style: lightFont,
                    ),
                    TextSpan(
                      text: diagnosis.result,
                      style: mediumFont.copyWith(
                          fontWeight: FontWeight.w600, color: primaryColor),
                    ),
                  ]),
                )
            ],
          )
        ],
      ),
    );
  }
}
