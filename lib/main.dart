import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? countdownTimer;
  Duration myDuration = DateTime.now().difference(DateTime.utc(2024,3,19,10));
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds + reduceSecondsBy;
      if (seconds > 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    countdownTimer!.cancel();
  }
  List arabicnumber = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  gen(String num){
    String numgen = '';
    for(int i = 0 ; i < num.length ; i++){
      // int index = int.parse(num[i]) > 0 ? int.parse(num[i]):int.parse(num[i])*-1;

      if(num[i] != '-') {
        numgen = numgen + arabicnumber[int.parse(num[i])];
      }

    }
    if(num.length == 2){
      numgen = numgen.toString().padLeft(2, arabicnumber[0]);
    }
    return numgen;
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/man_flag.webp'),
                    ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5)
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(right: 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('يوم العلم\nالسعودي',style: GoogleFonts.tajawal(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),),
                  const SizedBox(height: 20,),
                   Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.rtl,
                     children: [
                       Text('11 مارس',textDirection: TextDirection.rtl,style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontSize: 12,
                      ),),
                      const SizedBox(width: 25,),
                       Text('#يومـالعلم',textDirection: TextDirection.rtl,style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontSize: 12,
                      ),),
                     ],
                   )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 35,
            left: 35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    time(gen(days),'أيام'),
                    Text(':',style: GoogleFonts.tajawal(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    time(gen(hours),'ساعات'),
                    Text(':',style: GoogleFonts.tajawal(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    time(gen(minutes),'دقائق'),
                    Text(':',style: GoogleFonts.tajawal(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    time(gen(seconds),'ثواني'),
                  ],
                ),
                const SizedBox(height: 30,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const FlagKnow()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 88, 58, 1),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    width: double.maxFinite,
                    height: 50,
                    child: Center(
                      child: Text('أعرف أكثر',style: GoogleFonts.tajawal(color: Colors.white,fontSize: 18),),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column time(time,String title) {
    return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$time',style: GoogleFonts.tajawal(color: Colors.white,fontSize: 35),),
                      Text(title,style: GoogleFonts.tajawal(color: Colors.white,fontSize: 18),)
                    ],
                  );
  }
}

class FlagKnow extends StatefulWidget {
  const FlagKnow({super.key});

  @override
  State<FlagKnow> createState() => _FlagKnowState();
}

class _FlagKnowState extends State<FlagKnow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/flag.webp',
              opacity: const AlwaysStoppedAnimation(.1),
              repeat: ImageRepeat.repeat,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 60,),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/flag.webp'),
                        ),
                  ),
                ),
                const SizedBox(height: 80,),
                Text('يوم العلم',style: GoogleFonts.tajawal(color: const Color.fromRGBO(0, 88, 58, 1),fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text('نص الامر الملكي على تحديد يوم العلم جاء انطلاقا من قيمة العلم الوطني الممتدة عبر تاريخ الدولة السعودية منذ تاسيسها في عام 1139 هجرية الموافق 1727 ميلادية . والذي يرمز بشهادة التوحيد التي تتوسطه رسالة السلام والاسلام التي قامت عليها الدولة المباركة ويرمز السيف الى القوة والحكمة و المكانة.',style: GoogleFonts.tajawal(color: Colors.black,fontSize: 15,),textDirection: TextDirection.rtl,),
                const SizedBox(height: 60,),
                Text('قصة العلم',style: GoogleFonts.tajawal(color: const Color.fromRGBO(0, 88, 58, 1),fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text('عرف علم باصالته وعراقته حيث بدأت قصته مع تاسيس الدولة السعودية  عام 1139 هجرية الموافق 1727 ميلادية .  وامتداد للارث العربي و الاسلامي في استخدام الراية والعلم كاحدى مظاهر الدولة .',style: GoogleFonts.tajawal(color: Colors.black,fontSize: 15,),textDirection: TextDirection.rtl,),
                const SizedBox(height: 10,),
                Text('ومنذ ذلك التاريخ وحتى وقتنا الحاضر والعلم لونه أخضر وتتوسطه عبارة التوحيد “ لا اله الا الله محمد رسول الله “ ',style: GoogleFonts.tajawal(color: Colors.black,fontSize: 15,),textDirection: TextDirection.rtl,),

              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 35,
            left: 35,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    const Icon(Icons.ios_share,color: Color.fromRGBO(0, 88, 58, 1),size:20,),
                    const SizedBox(width: 5,),
                    Text('مشاركة الحدث',style: GoogleFonts.tajawal(color: const Color.fromRGBO(0, 88, 58, 1),fontSize: 15,),textDirection: TextDirection.rtl,)
                  ],
                ),
                const SizedBox(height: 6,),
                const Divider(
                  color: Color.fromRGBO(0, 88, 58, 1),
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/instagram.png',scale: 17,color: const Color.fromRGBO(0, 88, 58, 1),),
                    const SizedBox(width: 20,),
                    Image.asset('assets/tik-tok.png',scale: 17,color: const Color.fromRGBO(0, 88, 58, 1)),
                    const SizedBox(width: 20,),
                    Image.asset('assets/twitter.png',scale: 17,color: const Color.fromRGBO(0, 88, 58, 1)),
                    const SizedBox(width: 20,),
                    Image.asset('assets/whatsapp_1.png',scale: 17,color: const Color.fromRGBO(0, 88, 58, 1)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}