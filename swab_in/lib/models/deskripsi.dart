import 'package:flutter/material.dart';

class About {
  final String name;
  final String image;
  final String description;
  final List<Color> colors;

  About(
      {required this.name,
      required this.image,
      required this.description,
      required this.colors});
}

List isicard = [
  About(
      name: "Swab.in",
      image: "assets/images/logo.png",
      description:
          "Mobilitas merupakan kebutuhan dari setiap individu. Namun, di zaman pandemi ini, setiap orang yang akan melakukan mobilitas, khususnya dari satu daerah ke daerah lain dengan menggunakan transportasi umum memerlukan adanya surat bebas covid-19. Terlebih, masa berlaku surat bebas covid-19 pun umumnya tidak berlangsung lama. Selain itu, vaksinasi merupakan hal yang wajib dilakukan untuk melakukan mobilitas. Dalam hal ini, masalah yang sering dijumpai bagi individu yang ingin melakukan pemeriksaan bebas covid-19 adalah minimnya informasi mengenai tempat pemeriksaan covid-19 yang akan dituju maupun ingin dituju. Selain itu, masalah lain yang ditemui adalah beredarnya berita hoaks mengenai vaksin. Oleh karena itu, diperlukan adanya forum diskusi sebagai wadah untuk berbagi dan bertanya mengenai tempat pemeriksaan covid-19 dan edukasi mengenai vaksin covid-19. Dengan aplikasi ini, kami bertekad untuk membantu pemerintah dalam melakukan edukasi terkait vaksin maupun membantu masyarakat yang ingin melakukan pemeriksaan covid-19 dengan cara memberikan ruang diskusi terkait tempat pemeriksaan covid-19 sehingga pengguna dapat membantu satu sama lain terkait informasi suatu tempat covid-19.",
      colors: [Colors.blue.shade700, Colors.blue.shade900])
];
