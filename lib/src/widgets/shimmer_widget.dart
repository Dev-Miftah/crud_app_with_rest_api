import 'package:crud_app_with_rest_api_assignment13/src/constant/colors.dart';
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
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: kBlackColor.withOpacity(0.2),
                            offset: const Offset(0, 1),
                            spreadRadius: 0.5,
                            blurRadius: 0.8
                        )
                      ]
                  ),
                )),
          );
        });
  }
}
