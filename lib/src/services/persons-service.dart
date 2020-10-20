import 'package:haweyati_supplier_driver_app/model/common/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class PersonsService extends HaweyatiService<PersonModel> {
  @override
  PersonModel parse(Map<String, dynamic> item) => PersonModel.fromJson(item['profile'] ?? item);

  Future<PersonModel> getSignedInPerson() async {
    return await this.getOne('auth/profile');
  }

  Future<PersonModel> getPersonByContact(String contact) async {
    return await this.getOne('persons/contact/$contact');
  }

}
