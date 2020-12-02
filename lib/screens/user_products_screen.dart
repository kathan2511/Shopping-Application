import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_products_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Products>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.purple),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Consumer<Products>(
            builder: (ctx, productsData, _) => Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (ctx, i) => UserProductItem(
                  id: productsData.items[i].id,
                  title: productsData.items[i].title,
                  imageUrl: productsData.items[i].imageUrl,
                ),
                itemCount: productsData.items.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
