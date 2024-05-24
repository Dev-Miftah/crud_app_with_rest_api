import 'package:crud_app_with_rest_api_assignment13/src/constant/colors.dart';
import 'package:crud_app_with_rest_api_assignment13/src/widgets/product_card-decoration.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.8),
            highlightColor: kPrimaryColor,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(height: 120,
                  decoration: productCardDecoration()
                )),
          );
        });
  }
}
