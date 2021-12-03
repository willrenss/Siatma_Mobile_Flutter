import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/api/dhs_api.dart';
import 'package:siatma_mobile/api/formevaluasi_api.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/api/khs_api.dart';
import 'package:siatma_mobile/api/mahasiswa_api.dart';
import 'package:siatma_mobile/api/pembayaran_api.dart';
import 'package:siatma_mobile/api/presensi_api.dart';
import 'package:siatma_mobile/api/semester_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/view/DashboardScreen.dart';
import 'package:siatma_mobile/view/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Siatma Mobile', // id
    'Siatma Mobile Notification',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = Scaffold(
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome !",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w700,
              )),
          Text("SIATMA MOBILE",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    ),
    backgroundColor: darkColor2,
  );
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    if (token != '0')
      setState(() {
        // Provider.of<MahasiswaP>(context, listen: false).fetchMahasiswa();

        this.page = DashboardScreen(true);
      });
    else
      setState(() {
        this.page = LoginScreen();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<KartuHS>(create: (_) => new KartuHS()),
        ChangeNotifierProvider<Info>(create: (_) => new Info()),
        ChangeNotifierProvider<MahasiswaP>(create: (_) => new MahasiswaP()),
        ChangeNotifierProvider<AkademikSemester>(
            create: (_) => new AkademikSemester()),
        ChangeNotifierProvider<PresensiP>(create: (_) => new PresensiP()),
        ChangeNotifierProvider<SemesterJadwal>(
            create: (_) => new SemesterJadwal()),
        ChangeNotifierProvider<JadwalKP>(create: (_) => new JadwalKP()),
        ChangeNotifierProvider<JadwalHariIni>(
            create: (_) => new JadwalHariIni()),
        ChangeNotifierProvider<FormEP>(create: (_) => new FormEP()),
        ChangeNotifierProvider<DetailJawabanEP>(
            create: (_) => new DetailJawabanEP()),
        ChangeNotifierProvider<PertanyaanEP>(create: (_) => new PertanyaanEP()),
        ChangeNotifierProvider<JadwalUP>(create: (_) => new JadwalUP()),
        ChangeNotifierProvider<MatakuliahEP>(create: (_) => new MatakuliahEP()),
        ChangeNotifierProvider<DaftarHS>(create: (_) => new DaftarHS()),
        ChangeNotifierProvider<IPSP>(create: (_) => new IPSP()),
        ChangeNotifierProvider<SKSMATP>(create: (_) => new SKSMATP()),
        ChangeNotifierProvider<WaktuUP>(create: (_) => new WaktuUP()),
        ChangeNotifierProvider<WaktuKP>(create: (_) => new WaktuKP()),
        ChangeNotifierProvider<PembayaranP>(create: (_) => new PembayaranP()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.blue[900],
        home: this.page,
      ),
    );
  }
}
