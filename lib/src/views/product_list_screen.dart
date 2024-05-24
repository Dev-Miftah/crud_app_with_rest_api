import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud_app_with_rest_api_assignment13/src/constant/colors.dart';
import 'package:crud_app_with_rest_api_assignment13/src/views/add_product_screen.dart';
import 'package:crud_app_with_rest_api_assignment13/src/views/update_product_screen.dart';
import 'package:crud_app_with_rest_api_assignment13/src/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../data_model/product_model.dart';
import '../widgets/product_card-decoration.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getProductInProgress = false;
  List<ProductModel> productList = [];
  @override
  void initState() {
    super.initState();
    _getProductList();
  }
  @override
  Widget build(BuildContext context) {
  final screenWidth =  MediaQuery.of(context).size.width;
  final screenHeight =  MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud App'),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Visibility(
            visible: _getProductInProgress == false,
            replacement: const Center(child: ShimmerWidget()),
            child: ListView.builder(
              itemCount: productList.length,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    width: screenWidth,
                    decoration: productCardDecoration(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                            image: DecorationImage(image: CachedNetworkImageProvider(productList[index].image??''), fit: BoxFit.fill)
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Text(productList[index].productName ?? '',
                                  style: const TextStyle(
                                      fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                ),
                                Text('Unit Price: ${productList[index].unitPrice}',
                                style: const TextStyle(fontSize: 14),
                                ),
                                Text('Quantity: ${productList[index].quantity}',
                                style: const TextStyle(fontSize: 14),
                                ),
                                Text('Total Price: ${productList[index].totalPrice}',
                                style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: ()async{
                              final result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => UpdateProductScreen(product: productList[index])));
                              if(result == true){
                                _getProductList();
                              }
                            },
                                icon: const Icon(Icons.edit)),
                            IconButton(onPressed: (){
                              _showDeleteConfirmationDialog(productList[index].id.toString());
                            },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddProductScreen()));
              if(result == true){
                _getProductList();
                setState(() {});
              }
            },
          child: const Icon(Icons.add),
        ),
    );
  }

  Future<void> _getProductList()async{
    _getProductInProgress = true;
    setState(() {});
    productList.clear();
    const String _getProductListUrl = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri =Uri.parse(_getProductListUrl);
    Response response = await get(uri);
    if (response.statusCode ==200){
      final decodeData = jsonDecode(response.body);
      final jsonProductList = decodeData['data'];
      for (Map<String,dynamic> json in jsonProductList){
        ProductModel productModel = ProductModel.fromJson(json);
        productList.add(productModel);
        print(response.body);
      }
      _getProductInProgress = false;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:Text('Product loading failed! Try & Refresh again.')
      ));
    }
  }
  Future<void> _deleteProduct(String productId) async {
    _getProductInProgress = true;
    setState(() {});
    String _deleteProductUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';
    Uri uri = Uri.parse(_deleteProductUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _getProductInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Delete product failed! Try again.')),
      );
    }
  }

  void _showDeleteConfirmationDialog(String productId){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text('Are you sure'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            setState(() {});
          },
              child: const Text('Cancel')),
          TextButton(onPressed: (){
            _deleteProduct(productId);
            Navigator.pop(context);
          },
              child: const Text('Yes delete')),
        ],
      );
    },);
  }
}
