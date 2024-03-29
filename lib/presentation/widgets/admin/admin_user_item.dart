part of '../widgets.dart';

class AdminUserItem extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  const AdminUserItem({Key? key, required this.user, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff7090B0).withOpacity(.15),
              blurRadius: 24,
              offset: const Offset(0, 16),
            )
          ],
        ),
        child: Row(
          children: [
            if (user.imgUrl == null || user.imgUrl == "null")
              SizedBox(
                width: 48,
                height: 48,
                child: ClipOval(
                  child: SvgPicture.network(
                    "https://avatars.dicebear.com/api/jdenticon/default.svg",
                    width: 48,
                    placeholderBuilder: (context) {
                      return Container(
                        width: 48,
                        color: ghostWhiteColor,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              CachedNetworkImage(
                imageUrl: user.imgUrl!,
                imageBuilder: (context, imgProvider) => CircleAvatar(
                  radius: 24,
                  backgroundColor: ghostWhiteColor,
                  foregroundImage: imgProvider,
                ),
                placeholder: (context, url) => const SkeletonContainer.circular(
                  height: 48,
                  width: 48,
                ),
                errorWidget: (context, url, _) =>
                    const SkeletonContainer.circular(
                  height: 48,
                  width: 48,
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name}",
                    style: mediumFont.copyWith(
                      fontSize: 16,
                      color: blackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (user.date == null)
                        ? "null"
                        : DateFormat.yMMMd().format(user.date!),
                    style: lightFont.copyWith(
                      fontSize: 12,
                      color: const Color(0xffBBBBC0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
