import 'package:flutter/material.dart';
import '../../components/common/bottomNavItem.dart';
import '../../components/common/no_div_expansion_tile.dart';

// ignore: use_key_in_widget_constructors
class Layout extends StatefulWidget{
    @override
    _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout>{
    // 选中底部导航栏下标
    int _actInx = 0;

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.blue,
                elevation: 0.0, //导航栏阴影
                centerTitle: true,
                title: _actInx==4?null:Text(titles[_actInx],style: TextStyle(color: Colors.white)),
                actions: _actInx!=4?null:<Widget>[
                    IconButton(icon: Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: (){
                        Navigator.pushNamed(context, 'setting');
                    },)
                ],
                leading: _actInx!=0?null:Builder(builder: (context) {
                    return IconButton(
                        icon: Icon(Icons.menu, color: Colors.white), //自定义图标
                        onPressed: () {
                            // 打开抽屉菜单  
                            Scaffold.of(context).openDrawer(); 
                        },
                    );
                }),
            ),
            body: pages[_actInx],
            // bottomNavigationBar: BottomNavigationBar(
            //     items: bottomNavBarItems,
            //     onTap: _changePage,
            //     currentIndex: _actInx,
            //     fixedColor: Colors.blue,
            //     iconSize: 25.0,
            //     selectedFontSize:12.0, //选中时的大小
            //     unselectedFontSize:12.0, //未选中时的大小
            //     type: BottomNavigationBarType.fixed, //底部显示方式
            // ),
            drawer: _actInx!=0?null:Drawer(
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                        // UnitDrawerHeader(color: color),
                        // _buildItem(context, TolyIcon.icon_them, '应用设置', UnitRouter.setting),
                        // _buildItem(context, TolyIcon.icon_layout, '数据管理', UnitRouter.data_manage),
                        Divider(height: 1),
                        _buildFlutterUnit(context),
                        _buildItem(context, 'Dart 手册', ''),
                        Divider(height: 1),
                        // _buildItem(context, Icons.info, '关于应用', UnitRouter.about_app),
                        // _buildItem(context, TolyIcon.icon_kafei, '联系本王', UnitRouter.about_me),
                    ],
                ),
            ),
            drawerEdgeDragWidth: 0.0, //禁止手势侧滑出Drawer
            floatingActionButton: _actInx!=0?null:FloatingActionButton(
                child: Icon(Icons.airplanemode_active,size: 28.0,color: Colors.white),
                onPressed: (){},
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
    void _changePage(int inx){
        setState(() {
            if(inx != this._actInx){
                _actInx = inx;
            }
        });
    }
}