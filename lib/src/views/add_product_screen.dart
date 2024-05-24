import 'dart:convert';

import 'package:crud_app_with_rest_api_assignment13/src/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../data_model/product_model.dart';
import '../widgets/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _addNewProductInProgress = false;
  List<ProductModel> addProductList = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth =  MediaQuery.of(context).size.width;
    final screenHeight =  MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){Navigator.pop(context, true);},
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                    controller: _nameTEController,
                text: 'Product name',
                validator: (String? value){
                      if(value == null||value.trim().isEmpty){
                        return 'Write your product name';
                      }
                      return null;
                },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: _unitPriceTEController,
                text: 'Unit price',
                validator: (String? value){
                      if(value == null||value.trim().isEmpty){
                        return 'Write your product price';
                      }
                      return null;
                },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: _quantityTEController,
                text: 'Product quantity',
                validator: (String? value){
                      if(value == null||value.trim().isEmpty){
                        return 'Write your product quantity';
                      }
                      return null;
                },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: _totalPriceTEController,
                text: 'Total price',
                validator: (String? value){
                      if(value == null||value.trim().isEmpty){
                        return 'Write your product total price';
                      }
                      return null;
                },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: _imageTEController,
                text: 'Image link',
                validator: (String? value){
                      if(value == null||value.trim().isEmpty){
                        return 'Write your product image link';
                      }
                      return null;
                },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: _productCodeTEController,
                text: 'Product code',
                validator: (String? value){
                      if(value == null||value.trim().isEmpty){
                        return 'Write your product code';
                      }
                      return null;
                },
                ),
                const SizedBox(height: 20),
        
                Visibility(
                  visible: _addNewProductInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator(color: kPrimaryColor,),),
                  child: ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _addProduct();
                    }},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: kBlackColor,
                        minimumSize: Size(screenWidth, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      child: const Text('Add Product')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _addProduct() async {
    _addNewProductInProgress = true;
    setState(() {});
    const String _addNewProductUrl = 'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Uri uri = Uri.parse(_addNewProductUrl);

    Map<String, dynamic> inputData = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };
    Response response = await post(
        uri,
        body: jsonEncode(inputData),
      headers: {'content-type':'application/json'},
    );
    _addNewProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200){
      _nameTEController.clear();
      _unitPriceTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();
      _productCodeTEController.clear();
    } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:Text('Add new product failed! Try again.')
        ));
    }

    // print(response.statusCode);
    // print(response.body);
    // print(response.headers);
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _productCodeTEController.dispose();
    super.dispose();
  }
}
