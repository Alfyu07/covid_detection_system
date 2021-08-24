part of 'widgets.dart';

class SortItem extends StatelessWidget {
  final bool isActive;
  final String title;
  const SortItem({Key? key, this.isActive = false, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Container(
        height: 28,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: primaryColor,
        ),
        child: Text(title, style: whiteMediumFont.copyWith(fontSize: 12)),
      );
    } else {
      return Container(
        height: 28,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          title,
          style: mediumFont.copyWith(fontSize: 12, color: primaryColor),
        ),
      );
    }
  }
}
