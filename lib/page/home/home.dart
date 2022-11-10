import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start02/const.dart';
import 'package:start02/page/auth/auth_page.dart';
import 'package:start02/page/home/widget/home_category.dart';
import 'package:start02/page/home/widget/home_slider.dart';
import 'package:start02/providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  static const routerName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return auth.isAuth
            ? const Home()
            : FutureBuilder(
                future: auth.autoLogin(),
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshot.data ? const Home() : AuthPage();
                },
              );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                child: Image(image: AssetImage('assets/images/logo.png')),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Home Page'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onTap: () {
                          auth.logout();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          const HomeSlider(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Danh mục sản phẩm',
                  style: fdCategory,
                ),
                Text('Tất cả (4)'),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const HomeCategory(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
