import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class PersonsService extends HaweyatiService<Profile> {
  @override
  Profile parse(Map<String, dynamic> item) => Profile.fromJson(item['profile'] ?? item);

  Future<Profile> getSignedInPerson() async {
    return await this.getOne('auth/profile');
  }

  Future<Profile> getPersonByContact(String contact) async {
    return await this.getOne('persons/contact/$contact');
  }

}
