import 'package:ecom_mini/data/app_database.dart';
import 'package:ecom_mini/data/remote/product_api_service.dart';
import 'package:ecom_mini/repository/product_repository.dart';
import 'package:ecom_mini/view/home/home_view.dart';
import 'package:ecom_mini/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const EcomMiniApp());
}

class EcomMiniApp extends StatelessWidget {
  const EcomMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appDatabase = AppDatabase();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final productDao = ProductDao(appDatabase);
            final repository = ProductRepository(
              ProductApiService(),
              appDatabase,
              productDao,
            );
            return ProductViewModel(repository);
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyEcom',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
