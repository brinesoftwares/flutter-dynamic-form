import 'package:scoped_model/scoped_model.dart';

class DataState extends Model {
  List _user = [
    {"name": "", "id": ""},
  ];
  List get user => _user;

  void addUser(value) {
    _user.add(value);
    notifyListeners();
  }

  void removeUser(index) {
    _user.removeAt(index);
    notifyListeners();
  }

  void editUser(index, key, value) {
    _user[index][key] = value;
  }
}
