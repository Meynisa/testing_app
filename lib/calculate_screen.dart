import 'constant.dart';
import 'widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculateScreen extends StatefulWidget {
  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  int value = 1;
  TextEditingController _txtController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _txtController.text = '$value';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculate Your Receipt'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/img_14.jpg',
            ),
            bodyText('Start Calculate Your Receipt by Press the Button'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => _calculateWidget()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _calculateWidget(){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculate Now'),
      ),
      body: _cardCalculator(context),
    );
  }

  Widget _cardCalculator(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/img_4.png',
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          headlineText('Calculate Your Receipt'),
          SizedBox(height: 50),
          bodyText('Number of People'),
          SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  value = int.parse(_txtController.text);
                  value != 0 ? value-- : null ;
                  print("min : $value");
                  _txtController.text = '$value';
                },
                padding: EdgeInsets.zero,
                color: SwatchColor.kPurpleGreyColor,
              ),
              Expanded(
                child: TextFormField(
                  controller: _txtController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: SwatchColor.kDarkGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: SwatchColor.kPeachColor,
                        ),
                        borderRadius: BorderRadius.circular(25)),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: '',
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    value = int.parse(_txtController.text);
                    value++;
                    print("add : $value");
                    _txtController.text = '$value';
                  },
                  padding: EdgeInsets.zero,
                  color: SwatchColor.kPurpleGreyColor),
            ],
          ),
          SizedBox(height: 20),
          textFieldPayment('Total', TextInputType.number),
          SizedBox(height: 20),
          textFieldPayment('Delivery Fee', TextInputType.number),
          SizedBox(height: 20),
          textFieldPayment('Tax', TextInputType.number),
          SizedBox(height: 20),
          textFieldPayment('Discount', TextInputType.number),
          SizedBox(height: 50),
          Container(
            height: 50,
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                Filter filter = Filter('value');
                // Navigator.pop(context, 'value nya = 1');
              },
              child: dynamicText('Calculate'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class Filter {
  String filterPlafon = 'nsdkjfs';
  var filterLokasi = List<int>();
  var filterTenor = List<int>();
  var filterSkor = List<int>();
  var filterSector = List<int>();

  Filter(this.filterPlafon);
}
