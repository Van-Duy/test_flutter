import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start02/page/auth/auth_page.dart';
import 'package:start02/page/category/category.dart';
import 'package:start02/page/home/home.dart';
import 'package:start02/page/product/product.dart';
import 'package:start02/providers/auth_provider.dart';
import 'package:start02/providers/category_provider.dart';
import 'package:start02/providers/slider_provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SliderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routerName,
        routes: {
          HomePage.routerName: (context) => const HomePage(),
          CategoryPage.routerName: (context) => const CategoryPage(),
          ProductPage.routerName: (context) => const ProductPage(),
          AuthPage.routerName: (context) => AuthPage(),
        },
      ),
    ),
  );
}
