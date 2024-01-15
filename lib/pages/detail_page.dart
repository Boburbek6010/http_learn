import 'package:flutter/material.dart';
import 'package:http_learn/models/product_model.dart';

class DetailPage extends StatefulWidget {
  static const id = "/detail_page";
  final Product? product;
  const DetailPage({super.key, this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Image.network(product.thumbnail),
          )
        ],
      ),
    );
  }
}
