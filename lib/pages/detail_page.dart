import 'package:carousel_slider/carousel_slider.dart';
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              // carouselController: ,
              itemCount: product.images.length,
              itemBuilder: (context, int index, int pageIndex){
                return ColoredBox(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.network(
                        product.images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                // autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                autoPlayCurve: Curves.bounceOut,
              ),
            ),
            const SizedBox(height: 20),
            Text("Name: ${product.title}"),
            const SizedBox(height: 20),
            Text("Brand: ${product.brand}"),
            const SizedBox(height: 20),
            Text("Price: ${product.price}".toString()),
            const SizedBox(height: 20),
            Text("Description: ${product.description}"),
          ],
        ),
      ),
    );
  }
}
