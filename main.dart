import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
         home: MyHomePage(title: 'APPy',),
      )
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 7,
            shadowColor: Colors.red,
            backgroundColor: Colors.teal,
            leading: Icon(Icons.home, size: 35, color: Colors.lightGreenAccent,),
            title: Text("Home Page !", style: TextStyle(
                color: Colors.tealAccent, fontSize: 20, wordSpacing: 4),),
            bottom: TabBar(indicatorColor: Colors.red,labelColor: Colors.tealAccent,tabs: [
              Tab(text: ("Ball"),
                  icon: Icon(Icons.sports_volleyball_outlined, size: 32, color: Colors.lightGreenAccent,)),
              Tab(text: ("Count"),
                  icon: Icon(
                    Icons.plus_one_outlined, size: 32, color: Colors.lightGreenAccent,)),
              Tab(text: ("Timer"),
                icon: Icon(Icons.timelapse_outlined, size: 32,
                  color: Colors.lightGreenAccent,),),
            ],),
          ),
          body: TabBarView(children: [
            page1(),
            Counter(),
            CountdownTimerApp()
          ]),
        )
    );
  }
}










//pages

//BOUNCE BALL APP PAGE
// ignore: camel_case_types
class page1 extends StatefulWidget {
  @override
  _page1State createState() => _page1State();
}
// ignore: camel_case_types
class _page1State extends State<page1> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation firstAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this
    );

    firstAnimation = Tween(
        begin: 150.0,
        end: 0.0
    ).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Curves.bounceOut)
    );

    animationController.addListener(() {
      setState(() {
      }
      );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Column(

        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: firstAnimation.value),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle
                  ),
                  child: IconButton(onPressed: (){animationController.reverse();},
                    icon: Icon(Icons.sports_volleyball,color: Colors.yellowAccent,size: 138,),
                  )
                )]
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        animationController.forward();}
          ,child: Icon(Icons.adjust_sharp,color: Colors.black,),
          splashColor: Colors.teal,backgroundColor: Colors.lightGreenAccent),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        elevation: 10,

        child: Container(
          height: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}



//Counter APP PAGE
class Counter extends StatefulWidget {
  Counter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',style:
            TextStyle(color: Colors.blueGrey,fontSize: 20,fontWeight: FontWeight.bold),
            ),
            Text(
              '$_counter',style:
                TextStyle(color: Colors.yellowAccent,fontSize: 28,fontWeight: FontWeight.bold))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.teal,
        backgroundColor: Colors.lightGreenAccent,
        onPressed: _incrementCounter,
        elevation: 10,
        child: Icon(Icons.add,color: Colors.black,),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: Colors.teal,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}



//TIMER APP PAGE
class CountdownTimerApp extends StatefulWidget {
  @override
  _CountdownTimerAppState createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  Timer timer;
  var minute = 0;
  var seconds = 0;
  int totalTime;

  void startTimer() {
    final oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      totalTime = minute * 60 + seconds;
      setState(() {
        if (totalTime < 1) {
          timer.cancel();
        } else {
          if (seconds == 0) minute -= 1;
          totalTime -= 1;
          seconds = (totalTime % 60);
        }
      });
    });
  }

  void setSeconds(value) {
    setState(() {
      seconds = value;
    });
  }

  void setMinutes(value) {
    setState(() {
      minute = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.yellow),
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Center(
          child: Text(
            '$minute:$seconds',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.teal,
          backgroundColor: Colors.lightGreenAccent,
          onPressed: () {
            showDialog(
              context: context,
              child: SimpleDialog(
                backgroundColor: Colors.blueGrey,
                contentPadding: EdgeInsets.all(15),
                children: [
                  Text('Set your time',style: TextStyle(color: Colors.yellowAccent),),
                  DropdownButton<int>(
                    dropdownColor: Colors.blueGrey,
                    value: minute,
                    icon: Text('Minute',style: TextStyle(color: Colors.yellowAccent)),
                    items: List.generate(60, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index.toString(),style: TextStyle(color: Colors.yellowAccent)),
                      );
                    }),
                    onChanged: setMinutes,
                  ),
                  DropdownButton<int>(
                    dropdownColor: Colors.blueGrey,
                    value: seconds,
                    icon: Text('Seconds',style: TextStyle(color: Colors.yellowAccent)),
                    items: List.generate(60, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index.toString(),style: TextStyle(color: Colors.yellowAccent)),
                      );
                    }),
                    onChanged: setSeconds,
                  ),
                  SizedBox(height: 15),
                  OutlinedButton(
                    child: Text('Start',style: TextStyle(color: Colors.lightGreenAccent,fontWeight: FontWeight.bold)),
                    onPressed: () {
                      startTimer();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          },
          child: Icon(Icons.alarm_add_outlined,color: Colors.black,),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            color: Colors.teal,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}

