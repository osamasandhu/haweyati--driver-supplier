import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class ServiceListItem extends StatelessWidget {
  final String name;
  final String image;
  final Function onTap;
  final bool assetImage;

  ServiceListItem({
    this.image,
    @required this.name,
    @required this.onTap,
    this.assetImage = false,
  }): assert(name != null),
      assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.grey.shade100
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),

      child: ListTile(
        onTap: onTap,
        leading: this.assetImage ?
          Image.asset(image, width: 60):
          Image.network(HaweyatiService.resolveImage(image), width: 60),

        title: Text(name),
        trailing: Icon(CupertinoIcons.right_chevron),
      ),
    );
  }
}
