import 'package:flutter/material.dart';
import 'src/modules/address/address_page.dart';
import 'src/modules/cep/cep_page.dart';
import 'src/modules/history/history_page.dart';
import 'src/modules/home/home_page.dart';
import 'src/routes/app_routes.dart';
import 'src/shared/colors/app_colors.dart';
import 'src/shared/storage/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const FastLocationApp());
}

class FastLocationApp extends StatelessWidget {
  const FastLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastLocation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.searchByCep: (_) => const CepPage(),
        AppRoutes.searchByAddress: (_) => const AddressPage(),
        AppRoutes.history: (_) => const HistoryPage(),
      },
    );
  }
}
