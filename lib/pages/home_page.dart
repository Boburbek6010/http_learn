import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_learn/models/deleted_product.dart';
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
  // late ProductModel productModel;
  late List<Product> productList;
  // late Product product;
  late DeletedProduct deletedProduct;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();

  TextEditingController updateTitleController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();
  TextEditingController updateDescController = TextEditingController();

  Future<void> getAllProducts() async {
    String result = await NetworkService.GET(NetworkService.apiGetAllProducts);
    productList = productFromJson(result);
    isLoading = true;
    setState(() {});
  }
  
  void showDialogue([Product? product]){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Adding new Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Price",
                ),
                controller: priceController,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                controller: descController,
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: ()async{
                if(titleController.text.length > 2 && priceController.text.isNotEmpty && descController.text.length > 3){
                  Navigator.pop(context);
                  Product product = Product(id: "id", title: titleController.text.trim(), description: descController.text.trim(), price: int.parse(priceController.text.trim()), discountPercentage: 33, rating: 33, stock: 33, brand: "brand", category: "category", thumbnail: "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/2/thumbnail.jpg"]);
                  await NetworkService.POST(NetworkService.apiGetAllProducts, product.toJson());
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //   content: Text("Successfully posted"),
                  // ));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please fill all gaps"),
                    backgroundColor: Colors.red,
                  ),
                  );
                }
                await getAllProducts();
                setState(() {});
              },
              child: const Text("Save"),
            )
          ],
        );
      },
    );
  }
  

  void getInfo(Product product){
    Navigator.pushNamed(context, DetailPage.id, arguments: product);
  }


  //deleting item
  Future<void> deletingItem(int index)async{
    String? result = await NetworkService.DELETE(NetworkService.apiDeleteProduct, index);
    if(result != null){
      // deletedProduct = deletedProductFromJson(result);
      // log(result);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$index item was deleted")));
      await getAllProducts();
      setState(() {});
    }else{
      log("Null");
    }
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
                var item = productList[index];
                return MaterialButton(
                  onLongPress: () async{
                    updateTitleController.text = item.title;
                    updatePriceController.text = item.price.toString();
                    updateDescController.text = item.description;
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: const Text("Updating the product"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: updateTitleController,
                              ),
                              TextField(
                                controller: updatePriceController,
                              ),
                              TextField(
                                controller: updateDescController,
                              ),
                            ],
                          ),
                          actions: [
                            MaterialButton(
                              onPressed: ()async{
                                if(updateTitleController.text.length > 2 && updatePriceController.text.isNotEmpty && updateDescController.text.length > 3){
                                  Navigator.pop(context);
                                  Product product = Product(id: "id", title: updateTitleController.text.trim(), description: updateDescController.text.trim(), price: int.parse(updatePriceController.text.trim()), discountPercentage: 33, rating: 33, stock: 33, brand: "brand", category: "category", thumbnail: "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/2/thumbnail.jpg"]);
                                  await NetworkService.PUT(NetworkService.apiUpdateProduct, product.toJson(), item.id);
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Please fill all gaps"),
                                    backgroundColor: Colors.red,
                                  ),
                                  );
                                }
                                await getAllProducts();
                                setState(() {});
                              },
                              child: const Text("Save"),
                            )
                          ],
                        );
                      },
                    );
                  },
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
                    trailing: IconButton(
                      icon: const Icon(CupertinoIcons.delete),
                      onPressed: ()async{
                        await deletingItem(int.parse(item.id));
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return const Divider();
              },
              itemCount: productList.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialogue(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
