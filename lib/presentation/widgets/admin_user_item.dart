part of 'widgets.dart';

class AdminUserItem extends StatelessWidget {
  const AdminUserItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CachedNetworkImage(
            imageUrl:
                "https://media.istockphoto.com/photos/portrait-of-male-doctor-in-white-coat-and-stethoscope-standing-in-picture-id1327024466?b=1&k=20&m=1327024466&s=170667a&w=0&h=vcw4Exhv4pkR8fMVLNXhNESaKq1HbYwJ1iElLlQBxI0=",
            imageBuilder: (context, imgProvider) => CircleAvatar(
              radius: 24,
              backgroundColor: ghostWhiteColor,
              foregroundImage: imgProvider,
            ),
            errorWidget: (context, url, _) => const SkeletonContainer.circular(
              height: 48,
              width: 48,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. John Doe",
                style: mediumFont.copyWith(
                  fontSize: 16,
                  color: blackColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Created on 22 Nov 2022",
                style: lightFont.copyWith(
                  fontSize: 12,
                  color: const Color(0xffBBBBC0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
