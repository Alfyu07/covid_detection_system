part of 'widgets.dart';

class DiseaseCard extends StatelessWidget {
  final Image image;
  final String name;

  const DiseaseCard({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91,
      height: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff7090B0).withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 16),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image,
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: lightFont.copyWith(color: primaryColor, fontSize: 12),
          )
        ],
      ),
    );
  }
}
