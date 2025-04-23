import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashSCR(),
      title: 'QURAN APP',
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashSCR extends StatefulWidget {
  const SplashSCR({super.key});

  @override
  State<SplashSCR> createState() => _SplashSCRState();
}

class _SplashSCRState extends State<SplashSCR> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuranAppScreen(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/quran.png"),
      ),
    );
  }
}

class QuranAppScreen extends StatefulWidget {
  const QuranAppScreen({super.key});

  @override
  State<QuranAppScreen> createState() => _QuranAppScreenState();
}

class _QuranAppScreenState extends State<QuranAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QURAN APP'),
        backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      ),
      body: ListView.builder(
        itemCount: 114,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailsurah(index + 1),
                  ));
            },
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(quran.getSurahNameArabic(index + 1) +
                "|" +
                quran.getSurahName(index + 1)),
            subtitle: Text(quran.getSurahNameEnglish(index + 1),
                style: GoogleFonts.amiri()),
            trailing: Column(
              children: [
                quran.getPlaceOfRevelation(index + 1) == "Makkah"
                    ? Image.asset(
                        "assets/kaaba.png",
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        "assets/madina.png",
                        width: 30,
                        height: 30,
                      ),
                      Text('verses'+quran.getVerseCount(index+1).toString())
              ],
            ),
          );
        },
      ),
    );
  }
}

class Detailsurah extends StatefulWidget {
  var correctsurah;
  Detailsurah(this.correctsurah, {super.key});
  @override
  State<Detailsurah> createState() => _DetailsurahState();
}

class _DetailsurahState extends State<Detailsurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(quran.getSurahName(widget.correctsurah)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(widget.correctsurah),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  quran.getVerse(
                      widget.correctsurah, verseEndSymbol: true, index + 1),
                  textAlign: TextAlign.right,
                  style: GoogleFonts.amiri(),
                ),
                subtitle: Text(
                  quran.getVerseTranslation(widget.correctsurah, index + 1,
                      translation: quran.Translation.urdu),
                  textDirection: TextDirection.rtl,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
