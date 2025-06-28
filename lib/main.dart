import 'package:flutter/material.dart';
import 'package:odyss/core/providers/theme_provider.dart';
import 'package:odyss/core/theme.dart';
import 'package:odyss/routes/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Supabase.initialize(
      url: 'https://vxsikirblhcmcjmsoyvz.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4c2lraXJibGhjbWNqbXNveXZ6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0NzYxNDQ1NSwiZXhwIjoyMDYzMTkwNDU1fQ.c04bo4Kcpjfv4M0R2wxr8hkWJVnnmpggz12th4ZfQGA',
    );
    runApp(const ProviderScope(child: MyApp()));
  } catch (e) {
    // Optionally log or show an error screen
    print('Supabase initialization failed: $e');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Odyss',
      theme: AppTheme.lightTheme,
      //darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
