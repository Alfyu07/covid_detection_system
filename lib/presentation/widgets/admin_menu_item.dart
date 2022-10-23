part of 'widgets.dart';

class AdminMenuItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AdminMenuItem({
    Key? key,
    required this.iconUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff7090B0).withOpacity(.15),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              iconUrl,
              width: 40,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: mediumFont.copyWith(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: lightFont.copyWith(
                    fontSize: 12,
                    color: blueGreyColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
