part of 'widgets.dart';

class ProgressBar extends StatelessWidget {
  final double width;
  final double value;
  final Color color;
  const ProgressBar({
    Key? key,
    this.width = 188,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: width,
      child: Stack(
        children: [
          Container(
            height: 16,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffF6F3F0),
            ),
          ),
          Container(
            height: 16,
            width: value * width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
