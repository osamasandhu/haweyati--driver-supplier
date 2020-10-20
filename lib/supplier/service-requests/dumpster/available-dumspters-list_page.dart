import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/models/dumpster_model.dart';
import 'package:haweyati_supplier_driver_app/model/dumpster-model.dart';
import 'package:haweyati_supplier_driver_app/src/services/dumpster-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_body.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/service-list-item.dart';

class AvailableDumpstersListPage extends StatefulWidget {
  @override
  _AvailableDumpstersListPageState createState() => _AvailableDumpstersListPageState();
}

class _AvailableDumpstersListPageState extends State<AvailableDumpstersListPage> {

  var _service = DumpsterServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(),
      backgroundColor: Colors.white,
      body: LiveScrollableView<Dumpster>(
        title: 'Available Dumpsters',
        subtitle: '',
        loader: ()=> _service.getDumpster(),
        builder: (context,data){
          print(data.size);
          return ServiceListItem(
            onTap: (){},
            name: data.size,
            image: data.image.name,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        onPressed: () => Navigator.of(context).pushNamed('/dumpster-request')
      ),
    );
  }
}