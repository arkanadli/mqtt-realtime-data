import 'package:flutter/material.dart';
import 'package:mqtt/MqttHandler/mqttHandler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MqttHandler mqttHandler = MqttHandler();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mqttHandler.connect();
  }

  @override
  Widget build(BuildContext context) {
    mqttHandler.publishMessage('IM HERE!');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 6,
                child: ValueListenableBuilder<String>(
                  builder: (BuildContext context, String value, Widget? child) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Data from topic asharilabs/suhu :',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ValueListenableBuilder<String>(
                            builder: (BuildContext context, String value,
                                Widget? child) {
                              if (value.isNotEmpty) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(value,
                                        style: const TextStyle(
                                            color: Colors.deepPurpleAccent,
                                            fontSize: 35))
                                  ],
                                );
                              }
                              return const Text('Waiting to capturing data..');
                            },
                            valueListenable: mqttHandler.data,
                          )
                        ],
                      ),
                    );
                  },
                  valueListenable: mqttHandler.data,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
