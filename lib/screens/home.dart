import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    try {
      data = data.isNotEmpty
          ? data
          : ModalRoute.of(context)!.settings.arguments as Map;
    } catch (e) {
      data = {
        'location': 'No Location',
        'flag': '',
        'time': '00:00',
        'isDayTime': true
      };
    }

    String backgroundImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? backgroundColor =
        data['isDayTime'] ? Colors.blue : Colors.indigo[900];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$backgroundImage'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 128.0, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'location': result['location'],
                      'flag': result['flag'],
                      'time': result['time'],
                      'isDayTime': result['isDayTime']
                    };
                  });
                },
                icon: Icon(Icons.edit_location, color: Colors.grey[300]),
                label: Text('Edit Location',
                    style: TextStyle(color: Colors.grey[300])),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 28.0,
                        letterSpacing: 2.0),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(color: Colors.grey[300], fontSize: 66.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
