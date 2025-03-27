import 'package:flutter/material.dart';

void nothing() {}

class HystoryDrawer extends StatelessWidget {
  const HystoryDrawer({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: FlutterLogo(size: 100,)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'completed_list');
            },
            child: Text('Таблица решённых билетов'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'learn_dialog');
            },
            child: Text('Учить'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'test_dialog');
            },
            child: Text('Проверка'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back,size: 30,),
                Text('Назад на главную'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
