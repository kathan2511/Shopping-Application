import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_panel.dart';

import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/user_products_screen.dart';
import './providers/orders.dart';
import './screens/edit_products_screen.dart';
import './providers/auth.dart';
import 'screens/sign_up.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          builder: (context, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          // initialBuilder: () => Orders<>(),
          builder: (context, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            darkTheme: ThemeData.dark(),
            home: LoginPage(),
            routes: {
              '/signup': (BuildContext context) => new SignupPage(),
              ProductsOverviewScreen.routeName: (ctx) =>
                  ProductsOverviewScreen(),
                  UserPanel.routeName: (ctx) =>
                  UserPanel(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }),
      ),
    );
  }
}
