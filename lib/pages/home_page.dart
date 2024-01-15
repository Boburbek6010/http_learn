import 'package:flutter/material.dart';
import 'package:http_learn/pages/detail_page.dart';
import 'package:http_learn/service/network_service.dart';

import '../models/product_model.dart';

class HomePage extends StatefulWidget {
  static const id = "/home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late ProductModel productModel;

  Future<void> getAllProducts() async {
    String result = await NetworkService.GET(NetworkService.apiGetAllProducts);
    productModel = productModelFromJson(result);
    isLoading = true;
    setState(() {});
  }

  void getInfo(Product product){
    Navigator.pushNamed(context, DetailPage.id, arguments: product);
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
      ),
      body: isLoading
          ? ListView.separated(
              itemBuilder: (_, index) {
                var item = productModel.products[index];
                return MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    getInfo(item);
                  },
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.brand),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${index + 1}.", style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),),
                        const SizedBox(width: 10),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: Image.network(item.thumbnail).image,
                            fit: BoxFit.cover,
                          )),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return const Divider();
              },
              itemCount: productModel.products.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
