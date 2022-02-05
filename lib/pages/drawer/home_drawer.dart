// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:produlacmovil/components/app_theme.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

import '../loginPage.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    /*drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.inicio,
        labelName: 'Inicio',
        icon: FaIcon(FontAwesomeIcons.home),
      ),
      DrawerList(
        index: DrawerIndex.animales,
        labelName: 'Animales',
        icon: FaIcon(FontAwesomeIcons.paw),
      ),
      DrawerList(
        index: DrawerIndex.produccion,
        labelName: 'Produccion',
        icon: FaIcon(FontAwesomeIcons.pollH),
      ),
      DrawerList(
        index: DrawerIndex.ventas,
        labelName: 'Ventas',
        icon: FaIcon(FontAwesomeIcons.notesMedical),
      ),
      DrawerList(
        index: DrawerIndex.ingresos,
        labelName: 'Ingresos',
        icon: FaIcon(FontAwesomeIcons.chartLine),
      ),
      DrawerList(
        index: DrawerIndex.administrar,
        labelName: 'Administrar',
        icon: FaIcon(FontAwesomeIcons.userCog),
      ),
    ];*/
    if (rol_id_usuario_logeado == "1") {
      drawerList = <DrawerList>[
        DrawerList(
          index: DrawerIndex.inicio,
          labelName: 'Inicio',
          icon: FaIcon(FontAwesomeIcons.home),
        ),
        DrawerList(
          index: DrawerIndex.animales,
          labelName: 'Animales',
          icon: FaIcon(FontAwesomeIcons.paw),
        ),
        DrawerList(
          index: DrawerIndex.administrar,
          labelName: 'Administrar',
          icon: FaIcon(FontAwesomeIcons.userCog),
        ),
      ];
    } else {
      if (rol_id_usuario_logeado == "2") {
        drawerList = <DrawerList>[
          DrawerList(
            index: DrawerIndex.inicio,
            labelName: 'Inicio',
            icon: FaIcon(FontAwesomeIcons.home),
          ),
          DrawerList(
            index: DrawerIndex.animales,
            labelName: 'Animales',
            icon: FaIcon(FontAwesomeIcons.paw),
          ),
          DrawerList(
            index: DrawerIndex.produccion,
            labelName: 'Produccion',
            icon: FaIcon(FontAwesomeIcons.pollH),
          ),
          DrawerList(
            index: DrawerIndex.ventas,
            labelName: 'Ventas',
            icon: FaIcon(FontAwesomeIcons.notesMedical),
          ),
          DrawerList(
            index: DrawerIndex.ingresos,
            labelName: 'Ingresos',
            icon: FaIcon(FontAwesomeIcons.chartLine),
          ),
          DrawerList(
            index: DrawerIndex.administrar,
            labelName: 'Administrar',
            icon: FaIcon(FontAwesomeIcons.userCog),
          ),
        ];
      } else {
        if (rol_id_usuario_logeado == "3") {
          drawerList = <DrawerList>[
            DrawerList(
              index: DrawerIndex.inicio,
              labelName: 'Inicio',
              icon: FaIcon(FontAwesomeIcons.home),
            ),
            DrawerList(
              index: DrawerIndex.animales,
              labelName: 'Animales',
              icon: FaIcon(FontAwesomeIcons.paw),
            ),
            DrawerList(
              index: DrawerIndex.administrar,
              labelName: 'Administrar',
              icon: FaIcon(FontAwesomeIcons.userCog),
            ),
          ];
        } else {
          if (rol_id_usuario_logeado == "4") {
            drawerList = <DrawerList>[
              DrawerList(
                index: DrawerIndex.inicio,
                labelName: 'Inicio',
                icon: FaIcon(FontAwesomeIcons.home),
              ),
              DrawerList(
                index: DrawerIndex.animales,
                labelName: 'Animales',
                icon: FaIcon(FontAwesomeIcons.paw),
              ),
              DrawerList(
                index: DrawerIndex.produccion,
                labelName: 'Produccion',
                icon: FaIcon(FontAwesomeIcons.pollH),
              ),
              DrawerList(
                index: DrawerIndex.administrar,
                labelName: 'Administrar',
                icon: FaIcon(FontAwesomeIcons.userCog),
              ),
            ];
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onWillPop();
      },
      child: Scaffold(
        backgroundColor: AppTheme.notWhite.withOpacity(0.5),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              //padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: widget.iconAnimationController!,
                      builder: (BuildContext context, Widget? child) {
                        return ScaleTransition(
                          scale: AlwaysStoppedAnimation<double>(1.0 -
                              (widget.iconAnimationController!.value) * 0.2),
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                        begin: 0.0, end: 24.0)
                                    .animate(CurvedAnimation(
                                        parent: widget.iconAnimationController!,
                                        curve: Curves.fastOutSlowIn))
                                    .value /
                                360),
                            child: Container(
                              height: 170,
                              width: 120,                              
                              child: ListView(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 70.0,
                                      backgroundImage:NetworkImage(per_imagen_usuario_logeado))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        per_nombre_apellido_usuario_logeado,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount: drawerList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return inkwell(drawerList![index]);
                },
              ),
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Cerrar Sesion',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppTheme.darkText,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  onTap: () {
                    onTapped(
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onTapped(Future<Object?> pushReplacement) {
    print('Doing Something...'); // Print to console.
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Salir'),
            content: Text('¿Esta seguro que desea salir?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('Si')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);                  
                },
                child: Text('No'),
              )
            ],
          );
        });
    return shouldPop ?? false;
  }
}

enum DrawerIndex {
  inicio,
  animales,
  produccion,
  ventas,
  ingresos,
  administrar,
  salir,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  FaIcon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
