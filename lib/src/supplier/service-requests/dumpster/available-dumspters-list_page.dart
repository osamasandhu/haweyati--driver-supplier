import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/dumpster/model.dart';
import 'package:haweyati_supplier_driver_app/src/services/dumpster-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
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
    return LocalizedView(
      builder: (context,lang) =>
       Scaffold(
        appBar: HaweyatiAppBar(),
        backgroundColor: Colors.white,
        body: LiveScrollableView<Dumpster>(
          title: lang.availableDumpsters,
          subtitle: '',
          loader: ()=> _service.getDumpster(),
          builder: (context,data){
            print(data.name);
            return ServiceListItem(
              onTap: (){},
              name: data.name,
              image: data.image.name,
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          onPressed: () => Navigator.of(context).pushNamed('/dumpster-request')
        ),
      ),
    );
  }
}