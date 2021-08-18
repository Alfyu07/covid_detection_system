part of 'widgets.dart';

class CarouselItem extends StatelessWidget {
  final AssetImage image;
  final String title;
  final String subtitle;
  const CarouselItem({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 110,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 13.0, left: 14, right: 14, bottom: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    title,
                    style: whiteMediumFont.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 200,
                  child: Text(
                    subtitle,
                    style: whiteLightFont.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.24,
                      height: 1.8,
                    ),
                    maxLines: 2,
                  ),
                )
              ],
            )
          ].reversed.toList(),
        ),
      ),
    );
  }
}
