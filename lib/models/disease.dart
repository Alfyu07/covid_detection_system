class Disease {
  /// class Disease -> model untuk penyakit yang dideteksi
  /// [name]  -> string untuk nama penyakit
  /// [description] -> string untuk deskripsi penyakit
  /// [imageUrl] -> String path gambar
  /// [gejala] -> list of string yang berisikan gejala gejala dari penyakit tsb
  /// [gejalaImgUrl]
  ///
  final String? name;
  final String? description;
  final String? imageUrl;
  final List<String?>? gejala;
  final List<String?>? gejalaImgUrl;
  final List<String?>? pencegahan;
  final List<String?>? pencegahanUrl;
  final List<String?>? ctScanUrl;

  Disease(this.name, this.description, this.gejala, this.gejalaImgUrl,
      this.pencegahan, this.pencegahanUrl, this.ctScanUrl, this.imageUrl);
}

final diseases = [
  Disease(
    "Corona Virus Disease",
    "Coronavirus atau disebut juga dengan virus corona merupakan keluarga besar virus yang mengakibatkan terjadinya infeksi saluran pernapasan atas ringan hingga sedang, seperti penyakit flu.  Banyak orang terinfeksi virus ini, setidaknya satu kali dalam hidupnya.",
    ["Mual", "Batuk", "Demam", "Sakit kepala", "Nafas pendek"],
    [
      'assets/gejala_mual_covid.png',
      'assets/gejala_batuk_covid.png',
      'assets/gejala_demam_covid.png',
      'assets/gejala_sakit kepala_covid.png',
      'assets/gejala_batuk_covid.png',
      'assets/gejala_nafas pendek.png',
    ],
    ["Cuci tangan", "Jaga jarak", "Memakai Masker", "Dirumah aja"],
    [
      "assets/cuci tangan.png",
      "assets/jaga jarak.png",
      "assets/memakai masker.png",
      "assets/dirumah aja.png"
    ],
    ["assets/ct_covid1.png", "assets/ct_covid2.png", "assets/ct_covid3.png"],
    "assets/tipe_covid.png",
  ),
  Disease(
    "Pneumonia",
    "Pneumonia adalah peradangan pada kantung udara di paru-paru yang disebabkan oleh infeksi bakteri, virus maupun jamur. Pneumonia juga dikenal dengan istilah paru-paru basah.\nPada pneumonia, kantung udara bisa berisi cairan atau nanah. Infeksi dapat mengancam nyawa siapa pun, terutama pada bayi, anak-anak, dan lansia di atas 65 tahun.",
    ["Sakit dada", "Pusing", "Demam", "Batuk", "Kulit pucat"],
    [
      'assets/gejala_sakit dada_pneumonia.png',
      'assets/gejala_pusing_pneumonia.png',
      'assets/gejala_demam_pneumonia.png',
      'assets/gejala_batuk_pneumonia.png',
      'assets/gejala_kulit pucat_pneumonia.png',
    ],
    ["Cuci tangan", "Jaga jarak", "Memakai Masker", "Makanan sehat"],
    [
      "assets/cuci tangan.png",
      "assets/jaga jarak.png",
      "assets/memakai masker.png",
      "assets/dirumah aja.png"
    ],
    [
      "assets/ct_pneumonia1.png",
      "assets/ct_pneumonia2.png",
      "assets/ct_pneumonia3.png"
    ],
    "assets/tipe_pneumonia.png",
  ),
  Disease(
    "Paru Normal",
    "Paru-paru merupakan organ yang sangat berperan dalam sistem pernapasan bagi manusia. Paru-paru yang sehat mampu menyediakan oksigen dalam jumlah besar untuk darah sehingga memberikan dampak bagus bagi tubuh agar bisa bekerja dan melakukan aktifitas dengan baik. ",
    ["Sakit dada", "Pusing", "Demam", "Batuk", "Kulit pucat"],
    [],
    ["Antioksidan", "Berolahraga", "Tidak merokok"],
    [
      "assets/antioksidan.png",
      "assets/berolahraga.png",
      "assets/tidak merokok.png",
    ],
    ["assets/ct_normal1.png", "assets/ct_normal2.png", "assets/ct_normal3.png"],
    "assets/tipe_normal.png",
  )
];
