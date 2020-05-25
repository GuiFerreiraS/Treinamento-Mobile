import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController capController = TextEditingController();

  int _maxcap = 0;
  int _people = 0;

  String _infoText = "Informe Capacidade";

  void _changePeople(int delta) {
    setState(() {
      int _vagas;
      _people += delta;
      if (_people < 0) {
        _people = 0;
      }
      _vagas = _maxcap - _people;
      if (_maxcap <= 0) {
        _infoText = "Informe Capacidade";
      } else if (_people < _maxcap) {
        if (_vagas == 1) {
          _infoText = "Pode entrar! $_vagas vaga";
        } else {
          _infoText = "Pode entrar! $_vagas vagas";
        }
      } else {
        _vagas=-_vagas;
        if(_vagas==0){
            _infoText = "Lotado!!!";
        }
        else{
          _infoText = "Lotado!! $_vagas acima da cap.";
        }
      }
      capController.text = "$_maxcap";
    });
  }

  void _changecap(void i) {
    setState(() {
      _maxcap = int.parse(capController.text);
      if (_maxcap > 0) {
        _infoText = "Pode entrar!";
      }
      FocusScopeNode currentFocus = FocusScope.of(context);

      if(!currentFocus.hasPrimaryFocus){
        currentFocus.unfocus();
      }
    });
  }

  void _resetFields() {
    setState(() {
      _maxcap = 0;
      _people = 0;
      capController.text = "";
      _infoText = "Informe Capacidade";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contador"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (_resetFields),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/lanchonete.jpeg",
            fit: BoxFit.cover,
            height: 700.0,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Pessoas: $_people",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text(
                            "+1",
                            style: TextStyle(fontSize: 40.0, color: Colors.red),
                          ),
                          onPressed: () {
                            _changePeople(1);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text(
                            "-1",
                            style: TextStyle(fontSize: 40.0, color: Colors.red),
                          ),
                          onPressed: () {
                            _changePeople(-1);
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                        fontSize: 30.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Capacidade:",
                        labelStyle: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 25.0),
                      controller: capController,
                    ),
                  ),
                  Container(
                      child: RaisedButton(
                    onPressed: () {
                      _changecap(0);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

