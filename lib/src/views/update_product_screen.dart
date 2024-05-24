import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../constant/colors.dart';
import '../data_model/product_model.dart';
import '../widgets/custom_text_field.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel product;
  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _updateProductInProgress = false;
  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _unitPriceTEController.text = widget.product.unitPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _productCodeTEController.text = widget.product.productCode ?? '';
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth =  MediaQuery.of(context).size.width;
    final screenHeight =  MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Update Product Screen'),

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
                  visible: _updateProductInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator(color: kPrimaryColor,),),
                  child: ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _updateProduct();
                    }},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: kBlackColor,
                          minimumSize: Size(screenWidth, 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                      child: const Text('Update Product')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    String _updateProductUrl =
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';

    Map<String, String> inputData = {
      "Img": _imageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };
    Uri uri = Uri.parse(_updateProductUrl);
    Response response = await post(uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product has been updated')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product update failed! Try again.')),
      );
    }
  }
}
