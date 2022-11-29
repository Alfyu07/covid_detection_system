part of '../widgets.dart';

class AdminModelItem extends StatelessWidget {
  final EngineModel engineModel;
  final VoidCallback onTap;

  const AdminModelItem({
    Key? key,
    required this.onTap,
    required this.engineModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              "assets/icon_models_menu.png",
              width: 40,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  engineModel.name,
                  style: mediumFont.copyWith(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.yMMMd().format(
                    DateFormat("dd/MM/yyyy").parse(engineModel.createdDate),
                  ),
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
