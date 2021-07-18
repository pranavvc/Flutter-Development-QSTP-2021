import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
import 'package:flutter/material.dart';

void main() {
return(runApp(MaterialApp(
  home: Homepage()
)));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> Questions = ["How did you like our service?",
                            "How did you appreciate the sanitation?",
                            "How was the sound quality?",
                            "How was the lighting?",
                            "How likely are you to recommend us to your friends?",
                            "How likely are you to come back here?",
                            ];
  final PageController controller = PageController(initialPage: 0);
  double _currentSliderValue = 1;
  int sum = 0;
  int bottomSelectedIndex = 0;
  int _currentPage = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      for(var j in Questions)
        BottomNavigationBarItem(
            backgroundColor: Colors.cyan[100],
            icon: new Icon(Icons.circle,size: 8),
            title: new Text('')
        ),

    ];
  }


  @override

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 80, right: 80),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
          ),
          child: BottomNavigationBar(
            elevation: 0,
             type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.grey[850],
            showSelectedLabels: false,
            currentIndex: bottomSelectedIndex,
            items: buildBottomNavBarItems(),
          ),
        ),
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
          title: Text("Feedback App",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: true,
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          physics: RightBlockedScrollPhysics(),
          children: <Widget>[
            for (var i in Questions)
              Center(
                child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 320.0),
                        child: Text("$i",
                          textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),),
                      ),
                      Container(
                        child: SizedBox(height: 35,),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Slider(
                        activeColor: Colors.blue,
                        value: _currentSliderValue,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                        ),
                      ),
                      (i==Questions[5]) ? Padding(
                        padding: const EdgeInsets.all(45.0),
                        child: (
                            RaisedButton(onPressed: (){setState(() {
                          sum += _currentSliderValue.toInt();
                        }); Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => result(sum)),
                        );},child: Text('Submit', style: TextStyle(color: Colors.white),),color: Colors.grey[850], )),
                      ) : Container()

          ])
                ),

              ],
          onPageChanged: (index) {
          setState(() {
            sum += _currentSliderValue.toInt();
            bottomSelectedIndex = index;
            print(sum.toString());
            _currentSliderValue = 1;
          });
          (index==5)?(FloatingActionButtonLocation.miniCenterTop):(null)
          ;}
        ),
      floatingActionButton: FloatingActionButton(onPressed: () { controller.nextPage(duration: Duration(milliseconds:300 ), curve: Curves.fastLinearToSlowEaseIn); },
          child: Icon(Icons.navigate_next),
        backgroundColor: Colors.grey[850],
          hoverElevation: 0,
        ),
      ),
    );

  }

}

class result extends StatelessWidget {
  final int sum;
  const result(this.sum, {Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
          title: Text("Result"),
        ),
        body: Center(
          child : Column(
            children: [
              Container(
                child: SizedBox(height: 155,),
              ),
              Container(
                child: (sum<11) ? (Text("We are sorry for your inconvenience",
                  style: TextStyle(fontSize: 25, color: Colors.redAccent[400]), )) : ((sum<21) ? (Text(" Hope we serve you better next time",
                style: TextStyle(fontSize: 25, color: Colors.yellowAccent[700]),)) : Text("We hope you come back next time.",
                style: TextStyle(fontSize: 25, color: Colors.greenAccent[700]),)),),
              Container(
                child: SizedBox(height: 100,),
              ),
              ElevatedButton.icon(onPressed: () {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
      ); // Navigate back to first route when tapped.
      }, icon: const Icon(Icons.refresh), label: Text('Fill again'))
            ],
          )
        ),
      ),
    );
  }
}
class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: SizedBox(height: 200,)),
              Expanded(
                child: SizedBox(height: 100,
                child: Text("Feedback App",
                              style: TextStyle( fontWeight: FontWeight.bold,
                                letterSpacing: 2.0, fontSize: 50),),),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: ClipOval(child: Image.asset('assets/customer-feedback.png')),
                ),
              ),
              Expanded(child: SizedBox(height: 10,)),
              Expanded(
                child: FloatingActionButton(onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                ); // Navigate back to first route when tapped.
                    ;}, child: Text("START",), backgroundColor: Colors.redAccent,

                ),
              )
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}






