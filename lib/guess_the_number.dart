import 'package:flutter/material.dart';
import 'dart:math';

class MyGuess extends StatefulWidget {
  const MyGuess({super.key});

  @override
  State<MyGuess> createState() => _MyGuessState();
}

class _MyGuessState extends State<MyGuess> {
  final _text = TextEditingController();
  bool _isPlay = false;
  int iRan() {
    var random = Random();
    int r = random.nextInt(21);
    return r;
  }

  void onClickOver(int num, int randomNum) {
    String str;
    int num = int.parse(_text.text);
    if (num.toString().isEmpty) {
      str = "Enter the Number";
    } else if (num > 20) {
      str = "Number is out of Range";
    } else if (num < randomNum) {
      str = 'Enter a Higher Number';
    } else if (num > randomNum) {
      str = 'Enter a Lesser Number';
    } else {
      str = 'You got it Now!';
      showDialog(
          context: context,
          builder: (context) => Container(
              color: const Color.fromARGB(255, 238, 167, 162),
              height: 200,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      str.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _isPlay = false;
                            });
                          },
                          child: const Text('Play Again')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: const Text('Exit')),
                    ],
                  )
                ],
              )));
      setState(() {
        _isPlay = true;
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
    if (num == randomNum) {
      setState(() {
        iRan();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int r = iRan();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess The Number'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Form(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _text,
              decoration: const InputDecoration(
                  helperText: 'Enter number below 20',
                  hintText: 'Enter number below 20',
                  border: OutlineInputBorder()),
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                onClickOver(int.parse(_text.text), r);
              },
              child: const Text('Check')),
          const SizedBox(
            height: 20,
          ),
          _isPlay == true
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isPlay = false;
                      iRan();
                    });
                  },
                  child: const Text('Play Again'))
              : const Text(""),
          // _isPlay==true ? showDialog(context: context, builder: (context)=> Card())
        ],
      ),
    );
  }
}
