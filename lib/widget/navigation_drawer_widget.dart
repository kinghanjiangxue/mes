import 'package:mes/data/drawer_items.dart';
import 'package:mes/model/drawer_item.dart';
import 'package:mes/page/deployment_page.dart';
import 'package:mes/page/get_started_page.dart';
import 'package:mes/page/performance_page.dart';
import 'package:mes/page/resources_page.dart';
import 'package:mes/page/samples_page.dart';
import 'package:mes/page/testing_page.dart';
import 'package:mes/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/no_div_expansion_tile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        child: Container(
          color: Color(0xFF1a2f45),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                color: Colors.white12,
                child: buildHeader(isCollapsed),
              ),
              Divider(height: 1),
              _buildFlutterUnit(context),
              _buildItem(context, 'Dart 手册', ''),
              Divider(height: 1),
              const SizedBox(height: 24),
              buildList(items: itemsFirst, isCollapsed: isCollapsed),
              const SizedBox(height: 24),
              Divider(color: Colors.white70),
              const SizedBox(height: 24),
              buildList(
                indexOffset: itemsFirst.length,
                items: itemsSecond,
                isCollapsed: isCollapsed,
              ),
              Spacer(),
              buildCollapseIcon(context, isCollapsed),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlutterUnit(BuildContext context) => NoBorderExpansionTile(
    backgroundColor: Colors.white70,
    leading: Icon(
      Icons.extension,
      color: Theme.of(context).primaryColor,
    ),
    title: const Text(
      'Flutter 集录',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.blue,
          fontSize: 18.0,
          height: 1.2,
          fontFamily: "Courier",
          // background: ,
          decoration:TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed
      ),

    ),
    children: <Widget>[
      _buildItem(context,  '属性集录', ''),
      _buildItem(context,  '绘画集录', 'UnitRouter.galley'),
      _buildItem(context,  '布局集录', 'UnitRouter.layout'),
      _buildItem(context,  '要点集录', ''),
    ],
  );

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, indexOffset + index),
          );
        },
      );

  void selectItem(BuildContext context, int index) {
    final navigateTo = (page) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));

    Navigator.of(context).pop();

    switch (index) {
      case 0:
        navigateTo(GetStartedPage());
        break;
      case 1:
        navigateTo(SamplesPage());
        break;
      case 2:
        navigateTo(TestingPage());
        break;
      case 3:
        navigateTo(PerformancePage());
        break;
      case 4:
        navigateTo(DeploymentPage());
        break;
      case 5:
        navigateTo(ResourcesPage());
        break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final leading = Icon(icon, color: color);

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(text, style: TextStyle(color: color, fontSize: 16)),
              onTap: onClicked,
            ),
    );
  }

  Widget _buildItem(
      BuildContext context, String title, String linkTo,{VoidCallback? onTap}) =>
      ListTile(
        leading: Icon(
          Icons.error,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
        trailing:
        Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
        onTap: () {
          if (linkTo != null && linkTo.isNotEmpty) {
            print("object");
            Navigator.of(context).pushNamed(linkTo);
            if(onTap!=null) onTap();

          }
        },
      );

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon, color: Colors.white),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);

            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? FlutterLogo(size: 48)
      : Row(
          children: [
            const SizedBox(width: 24),
            FlutterLogo(size: 48),
            const SizedBox(width: 16),
            Text(
              'Flutter',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ],
        );
}
