import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
    final ServiceItemViewModel data;

    ServiceItem({Key? key, required this.data}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            alignment: Alignment.center,
            child: Column(
                children: <Widget>[
                    IconButton(
                        icon: this.data.icon,
                        onPressed: (){},
                    ),
                    Text(this.data.title,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF666666),
                        ),
                    ),
                ],
            ),
        );
    }
}

class ServiceItemViewModel {
    final Icon icon;
    final String title;
    const ServiceItemViewModel({
        required this.icon,
        required this.title,
    });
}