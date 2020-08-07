import 'package:dynamicForm/states/data_state.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nameController = List<TextEditingController>();
  final _idController = List<TextEditingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Dynamic Form"),
      ),
      body: new ScopedModelDescendant<DataState>(
        builder: (context, _, model) => SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: _buildFields(model.user.length),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      model.addUser({"product_id": "", "price": ""});
                    },
                    child: RichText(
                      text: TextSpan(
                        text: '+ ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Add new',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserList()),
          );
        },
        child: Text("Submit"),
      ),
    );
  }

  List<Widget> _buildFields(int length) {
    DataState _dataState = ScopedModel.of<DataState>(context);
    _idController.clear();
    _nameController.clear();
    for (int i = 0; i < length; i++) {
      final id = _dataState.user[i]["name"];
      final price = _dataState.user[i]["id"];
      _idController.add(TextEditingController(text: id));
      _nameController.add(TextEditingController(text: price));
    }
    return List<Widget>.generate(
      length,
      (i) => _productEdit(i, _idController[i], _nameController[i]),
    );
  }

  Widget _productEdit(index, idController, priceController) {
    DataState _dataState = ScopedModel.of<DataState>(context);
    print(index);
    print(_dataState.user.length);
    print(index + 1 == _dataState.user.length);

    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "${index + 1}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            )),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: idController,
                onChanged: (value) {
                  _dataState.editUser(index, "name", value);
                },
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: "Name",
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: new BorderSide(color: Colors.teal)),
                  contentPadding: EdgeInsets.only(left: 12, bottom: 12),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: priceController,
                onChanged: (value) {
                  _dataState.editUser(index, "id", value);
                },
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: "ID",
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: new BorderSide(color: Colors.teal)),
                  contentPadding: EdgeInsets.only(left: 10, bottom: 12),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
              padding: new EdgeInsets.all(0.0),
              icon: Icon(
                Icons.delete,
                size: 16,
                color: Colors.red,
              ),
              onPressed: () {
                _dataState.removeUser(index);
              }),
        ),
      ],
    );
  }
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Dynamic Form"),
      ),
      body: new ScopedModelDescendant<DataState>(
        builder: (context, _, model) => SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < model.user.length; i++)
                ListTile(
                  title: Text(model.user[i]["name"]),
                  subtitle: Text(model.user[i]["id"]),
                )
            ],
          ),
        ),
      ),
    );
  }
}
