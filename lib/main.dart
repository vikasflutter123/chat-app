import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Utils/app_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await _initializeFirebaseData();

  runApp(const ProviderScope(child: SlackCloneApp()));
}

Future<void> _initializeFirebaseData() async {
  try {

    final channelsSnapshot = await FirebaseFirestore.instance
        .collection('channels')
        .limit(1)
        .get();

    if (channelsSnapshot.docs.isEmpty) {

      await _createDefaultChannels();
    }
  } catch (e) {
    print('Error checking Firebase data: $e');
  }
}

Future<void> _createDefaultChannels() async {
  try {
    final channels = [
      {
        'name': '#general',
        'description': 'Company-wide announcements and work-based matters',
        'isPrivate': false,
        'memberCount': 1,
        'unreadCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'lastActivity': FieldValue.serverTimestamp(),
      },
      {
        'name': '#random',
        'description': 'Non-work banter and water cooler conversation',
        'isPrivate': false,
        'memberCount': 1,
        'unreadCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'lastActivity': FieldValue.serverTimestamp(),
      },
    ];

    for (final channel in channels) {
      await FirebaseFirestore.instance
          .collection('channels')
          .add(channel);
    }

    print('Default channels created');
  } catch (e) {
    print('Error creating channels: $e');
  }
}

class SlackCloneApp extends StatelessWidget {
  const SlackCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slack Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A154B),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: const Color(0xFF36C5F0),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A154B),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF1A1D21),
        scaffoldBackgroundColor: const Color(0xFF1A1D21),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF611F69),
          secondary: Color(0xFF36C5F0),
          surface: Color(0xFF2D2D2D),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1D21),
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const AppRouter(),
    );
  }
}


