import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 앱 시작 부분
void main() {
  runApp(const MyApp());
}

// 시작 클래스, 머티리얼 디자인 앱 생성
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  @override
  _BmiMainState createState() {
    return _BmiMainState();
  }
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>();

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: '키'),
                controller: _heightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return '키를 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: '몸무게'),
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BmiResult(
                                  double.parse(_heightController.text.trim()),
                                  double.parse(
                                      _weightController.text.trim()))));
                    }
                  },
                  child: Text('결과'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;

  BmiResult(this.height, this.weight); // 키 몸무게 받는 생성자

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height /100) * (height / 100));
    print('bmi: $bmi');

    String _calcBmi(double bmi) {
      var result = '저체중';
      if(bmi >= 35) {
        result = '고도비만';
      } else if(bmi >= 30) {
        result = '2단계 비만';
      } else if(bmi >= 25) {
        result = '1단계 비만';
      } else if(bmi >=23) {
        result = '과체중';
      } else if(bmi >= 18.5) {
        result = '정상 체중';
      }
      return result;
    }

    Widget _buildIcon(double bmi) {
      if(bmi >=23) {
        return Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.red,
          size: 100,
        );
      } else if(bmi >= 18.5) {
        return Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.green,
          size: 100,
        );
      } else {
        return Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.orange,
          size: 100,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _calcBmi(bmi),
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 16,
            ),
            _buildIcon(bmi)
          ],
        ),
      ),
    );
  }
}
