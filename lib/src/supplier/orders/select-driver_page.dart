import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/drivers_service.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/raised-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';

class SelectDriverPage extends StatefulWidget {
  @override
  _SelectDriverPageState createState() => _SelectDriverPageState();
}

class _SelectDriverPageState extends State<SelectDriverPage> {
  var _service = DriverService();
  Future<List<Driver>> drivers;
  Driver selectedDriver;

  @override
  void initState() {
    super.initState();
    drivers = _service.getDriversBySupplier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableView(
        bottom: RaisedActionButton(
          icon: Icon(CupertinoIcons.checkmark_circle),
          label: 'Proceed',
          onPressed: selectedDriver == null ? null : () {
            Navigator.pop(context,selectedDriver);
          },
        ),
        appBar: AppBar(
          title: Text("Select Driver"),
        ),
        child: SimpleFutureBuilder.simpler(
              context: context,
              future: drivers,
              builder: (List<Driver> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 30),
                    itemBuilder: (context, index) {
                      var _driver = snapshot[index];
                      return RadioListTile(
                        value: _driver,
                        groupValue: selectedDriver,
                        onChanged: (val) {
                          setState(() {
                            selectedDriver = val;
                          });
                        },
                        secondary: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: _driver.profile?.image !=null ? NetworkImage(
                              HaweyatiService.resolveImage(_driver.profile?.image?.name)
                          ) : AssetImage("assets/images/icon.png"),
                        ),
                        title: Text(_driver.profile.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vehicle Type : " + _driver.vehicle.type.name),
                            Text(_driver.location.address ??
                                'Address not specified'),
                          ],
                        ),
                      );
                    });
              }),
      ),
    );
  }
}
