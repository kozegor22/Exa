import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("appname"), Icon(Icons.favorite)],),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(child: Text("Example text")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'hystory_home');
                },
                child: Text("История"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'russian_home');
                  showDialog(
                    context: context,
                    builder:
                        (builder) => AlertDialog(
                          title: Text(
                            "Находится в разработке и не имеет(наверно) функционала",
                          ),
                          content: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ок"),
                          ),
                        ),
                  );
                },
                child: Text("Рус яз"),
              ),
              TextButton(onPressed: () {

                showDialog(
                    context: context,
                    builder:
                        (builder) => AlertDialog(
                          title: Text(
                            "В разработке",
                          ),
                          content: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ок"),
                          ),
                        ),
                  );
              }, child: Text("Бел яз")),
              TextButton(onPressed: () {
                showDialog(
                    context: context,
                    builder:
                        (builder) => AlertDialog(
                          title: Text(
                            "В разработке",
                          ),
                          content: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ок"),
                          ),
                        ),
                  );
              }, child: Text("Матем")),
            ],
          ),
        ],
      ),
    );
  }
}
