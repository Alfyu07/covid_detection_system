part of 'pages.dart';

class DetailsDisease extends StatelessWidget {
  final Disease disease;
  const DetailsDisease({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              color: const Color(0xffEDEDED),
              height: 350,
            ),
            Image.asset(
              disease.imageUrl ?? "",
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                const SizedBox(height: 328),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // * Header
                      buildHeader(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Text(
                          'Coronavirus atau disebut juga dengan virus corona merupakan keluarga besar virus yang mengakibatkan terjadinya infeksi saluran pernapasan atas ringan hingga sedang, seperti penyakit flu.  Banyak orang terinfeksi virus ini, setidaknya satu kali dalam hidupnya.',
                          style: lightFont,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // *Gejala
                      if (disease.name != "Paru Normal")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: edge,
                              ),
                              child: Text(
                                'Gejala',
                                style: mediumFont.copyWith(fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 8),
                            buildGejala(),
                            const SizedBox(height: 16),
                          ],
                        )
                      else
                        Container(),

                      //* Pencegahan
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Text(
                          disease.name == "Paru Normal"
                              ? "Menjaga Paru Sehat"
                              : 'Pencegahan',
                          style: mediumFont.copyWith(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 8),
                      buildPencegahan(),
                      const SizedBox(height: 16),
                      //* Location
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Text(
                          'Gambar CT Scan',
                          style: mediumFont.copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      buildPhotos(context),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Container(
                  width: 40,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    icon: const ImageIcon(
                      AssetImage('assets/arrow_back_black.png'),
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: edge,
        right: edge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            disease.name ?? "null",
            style: mediumFont.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget buildGejala() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < disease.gejala!.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: edge),
              child: Column(
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(disease.gejalaImgUrl![i]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      disease.gejala![i]!,
                      style: regularFont.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildPhotos(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.builder(
        itemCount: disease.ctScanUrl == null ? 0 : disease.ctScanUrl!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            final Image image = Image(
              image: AssetImage(disease.ctScanUrl![index] ?? ""),
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZoomPage(
                  image: image,
                  tag: "$index",
                ),
              ),
            );
          },
          child: Hero(
            tag: '$index',
            child: Container(
              width: 110,
              height: 88,
              margin: const EdgeInsets.only(left: edge),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(disease.ctScanUrl![index] ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPencegahan() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < disease.pencegahan!.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: edge),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(disease.pencegahanUrl![i]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    disease.pencegahan![i]!,
                    style: regularFont.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
