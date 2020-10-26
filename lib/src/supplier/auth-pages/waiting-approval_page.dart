import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/driver/profile/driver-home_page.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/drivers_service.dart';
import 'package:haweyati_supplier_driver_app/src/services/supplier-Services.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:haweyati_supplier_driver_app/utils/exit-application-dialog.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import '../supplier-homepage.dart';

class WaitingApproval extends StatefulWidget {
  @override
  _WaitingApprovalState createState() => _WaitingApprovalState();
}

class _WaitingApprovalState extends State<WaitingApproval> {

  Future<SupplierModel> supplier;
  Future<Driver> driver;
  var globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    checkStatus();
  }


  checkStatus([bool fromRetry=false]) async {
    if(AppData.isDriver){

      driver = DriverService().getDriver(AppData.driver.sId);
      Driver driv = await driver;
      print(driv.serialize());
      print("serialized");
      if(driv.status == 'Active'){
        await AppData.signIn(driv);
        CustomNavigator.pushReplacement(context, DriverHomePage());
        return;
      }
      else if(driv.status == 'Pending'){
        if(fromRetry){
          Navigator.pop(context);
        }
        showSimpleSnackbar(globalKey, "Your account is being reviewed!");
      }
      else if(driv.status == 'Rejected'){
        if(fromRetry){
          Navigator.pop(context);
        }
        showSimpleSnackbar(globalKey, "Your account has been rejected!",true);
      }
    } else {
      supplier = SupplierServices().supplierProfile(AppData.supplier.person.id);
      SupplierModel sup = await supplier;
      if(sup.status == 'Active'){
        await AppData.signIn(sup);
        CustomNavigator.pushReplacement(context, SupplierHomePage());
      }
      else if(sup.status == 'Pending'){
        if(fromRetry){
          Navigator.pop(context);
        }
        showSimpleSnackbar(globalKey, "Your account is being reviewed!");
      }
      else if(sup.status == 'Rejected'){
        if(fromRetry){
          Navigator.pop(context);
        }
        showSimpleSnackbar(globalKey, "Your account has been rejected!",true);
      }
    }
  }

  String message (String status){
    switch(status){
      case "Pending":
        return 'Your account is being reviewed';
        break;
      case "Rejected":
        return "Your account has been rejected";
        break;
      case "Active":
        return "Your account has been approved";
        break;
      default:
        return "Unknown status";
    }
  }

  Color statusColor (String status){
    switch(status){
      case "Pending":
        return Theme.of(context).accentColor;
        break;
      case "Rejected":
        return Colors.red;
        break;
      case "Active":
       return Colors.green;
        break;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: Scaffold(
        appBar: HaweyatiAppBar(
          actions: [
            IconButton(
                icon: Image.asset(
                  CustomerCareIcon,
                  width: 20,
                  height: 20,
                ),
                onPressed: () => Navigator.of(context).pushNamed('/helpline')
            ),
            IconButton(
                icon: Image.asset(LogoutIcon,scale: 2.5,),
                onPressed: () async {
                  openLoadingDialog(context, "Signing out");
                  await AppData.signOut();
                  CustomNavigator.pushReplacement(context, PreSignInPage());
                }
            ),
          ]
        ),
        key: globalKey,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          child: Icon(CupertinoIcons.refresh,size: 40,),
          foregroundColor: Colors.white,
          onPressed: () async {
            openLoadingDialog(context, "Refreshing status");
            await checkStatus(true);
          },
        ),
          body: DottedBackgroundView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AppData.isSupplier ? SimpleFutureBuilder.simpler(
                  context: context,
                  future: supplier,
                  builder: (SupplierModel supplier){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: statusColor(supplier.status),
                          child: Icon(
                            CupertinoIcons.search,
                            size: 50,
                            color: Colors.white),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          message(supplier.status),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                       supplier.status == 'Rejected' ? Text(
                          "${supplier.message}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ) : SizedBox(),
                      ],
                    );
                  },
                ) : SimpleFutureBuilder.simpler(
                  context: context,
                  future: driver,
                  builder: (Driver driver){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: statusColor(driver.status),
                          child: Icon(
                              CupertinoIcons.search,
                              size: 50,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          message(driver.status),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        driver.status == 'Rejected' ? Text(
                          "${driver.message}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ) : SizedBox(),
                      ],
                    );
                  },
                ),
              ),),
          )
      ),
    );
  }
}
