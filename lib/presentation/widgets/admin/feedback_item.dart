part of '../widgets.dart';

class FeedbackItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://media.istockphoto.com/photos/shot-of-a-handsome-young-man-standing-against-a-grey-background-picture-id1335941248?b=1&k=20&m=1335941248&s=170667a&w=0&h=sn_An6VRQBtK3BuHnG1w9UmhTzwTqM3xLnKcqLW-mzw=",
                imageBuilder: (context, imgProvider) => CircleAvatar(
                  radius: 16,
                  foregroundImage: imgProvider,
                ),
                placeholder: (context, _) => const SkeletonContainer.circular(
                  width: 24,
                  height: 24,
                ),
                errorWidget: (context, url, _) =>
                    const SkeletonContainer.circular(
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "John Doe",
                style: mediumFont.copyWith(
                  fontSize: 16,
                  color: blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Arcu turpis aliquam mi egestas sit vitae tortor. Elementum, viverra urna senectus turpis sit eget urna vel.",
            style: regularFont.copyWith(
              fontSize: 14,
              color: const Color(0xff292B39),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "22 Nov 2022",
            style: lightFont.copyWith(
              fontSize: 12,
              color: const Color(0xff8A8B93),
            ),
          ),
        ],
      ),
    );
  }
}
