import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:hawker_geo/core/model/role_enum.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/core/persistence/firestore/call_repo.dart';
import 'package:hawker_geo/core/persistence/firestore/user_repo.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/core/utils/constants.dart';
import 'package:hawker_geo/core/utils/util.dart';
import 'package:hawker_geo/ui/home/home_controller.dart';
import 'package:hawker_geo/ui/shared/floating_switch_widget.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/model/user.dart';
import '../../styles/text.dart';
import 'home_page.dart';

class HomeWidget extends State<HomePage> {
  final HomeController _controller = HomeController();
  final MapController mapController = MapController();
  final Util util = Util();

  var callsDocs = [];
  var hawkersList = <User>[];
  LatLng? userLocation;
  bool hawkerGps = false;
  User? hawkerCalled;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _getUser();
  }

  _getUser() async {
    // util.generateHawker(10);
    await _controller.checkUser();
    if (_controller.getUserRole() != null && _controller.getUserRole() == RoleEnum.ROLE_HAWKER) {
      _startFirestoreListener();
      _startLocationListener();
    }
  }

  _startFirestoreListener() {
    FirebaseFirestore.instance.collection(CallRepo.REPO_NAME).snapshots().listen((event) {
      setState(() {
        callsDocs = event.docs;
      });
    });
  }

  _startLocationListener() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 25,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
      if (position != null) {
        setState(() {
          userLocation = LatLng(position.latitude, position.longitude);
        });
        mapController.move(userLocation!, 17);
        if (hawkerGps) {
          _controller.sendHawkerLocation(userLocation!);
        }
      }
    });
  }

  Widget _getFloatingButton(BuildContext context) {
    if (_controller.isLoggedIn()) {
      RoleEnum? role = _controller.getUserRole();

      if (role == RoleEnum.ROLE_HAWKER) {
        return _floatingSwitchButton(context);
      } else if (role == RoleEnum.ROLE_CUSTOMER) {
        return _floatingCallButton();
      }
    }
    return _floatingLoginButton(context);
  }

  Widget _floatingCallButton() {
    return FloatingActionButton(
      onPressed: () async {
        var hawkerCalled = await _controller.createCall(context, hawkersList, userLocation!);
        setState(() {
          this.hawkerCalled = hawkerCalled;
        });
        // var index = hawkers.indexWhere((element) => element.email == hawkerCalled.email);
        // if(index != -1){
        //   i
        // }
      },
      child: util.gradientIcon(45, Icons.campaign),
      backgroundColor: Colors.white,
    );
  }

  Widget _floatingSwitchButton(BuildContext context) {
    return FloatingSwitch(
      onEnable: () {
        hawkerGps = true;
        _showQuickSnack("GPS ativado", context);
      },
      onDisable: () {
        _controller.clearHawkerPosition();
        hawkerGps = false;
        _showQuickSnack("GPS desativado", context);
      },
      icon: Icons.gps_fixed,
    );
  }

  Widget _floatingLoginButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        _controller.goToRegister(context);
        // await _controller.showLoginModal(context).then((_) {
        //   _getUserLocation();
        //   _getUser();
        //   setState(() {});
        // });
      },
      child: util.gradientIcon(45, Icons.campaign),
      backgroundColor: Colors.white,
    );
  }

  _showQuickSnack(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  _getUserLocation() async {
    await _controller.getClientLocation().then((value) {
      setState(() {
        userLocation = value;
      });
      mapController.onReady.then((value) => mapController.move(userLocation!, 17));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(UserRepo.REPO_NAME).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else {
          hawkersList = _controller.docsToUserList(snapshot.data!.docs);
          return Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: userLocation ?? BRAZIL_LAT_LONG,
                  zoom: 4,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: MAP_URL_TEMPLATE,
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return const Text(
                        MAP_COPYRIGHT,
                        style: openStreetMapCopyright,
                      );
                    },
                  ),
                  MarkerLayerOptions(
                    markers: _getMarkers(hawkersList),
                  ),
                ],
              ),
              Scaffold(
                drawer: Drawer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            kPrimaryColor,
                            kSecondColor,
                          ],
                          stops: [0, 0.55],
                        )),
                        child: !_controller.isLoggedIn()
                            ? null
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.grey, shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 50,
                                      )),
                                  Text(
                                    _controller.user!.name!,
                                    style: const TextStyle(fontSize: 28, color: Colors.white),
                                  ),
                                  Text(_controller.user!.email!,
                                      style: const TextStyle(fontSize: 18, color: Colors.white)),
                                ],
                              ),
                      ),
                      !_controller.isLoggedIn()
                          ? Container()
                          : SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: TextButton.icon(
                                  onPressed: () async {
                                    _controller.logout().then((_) {
                                      _getUserLocation();
                                      _getUser();
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  icon: const Icon(Icons.logout),
                                  label: const Text(
                                    "Sair",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            )
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  shadowColor: Colors.transparent,
                ),
                backgroundColor: Colors.transparent,
                floatingActionButton: _getFloatingButton(context),
              ),
              _receiveCall(context),
            ],
          );
        }
      },
    );
  }

  Widget _receiveCall(BuildContext context) {
    var calls = _controller.docsToCallsList(callsDocs);
    Widget widget = Container();
    for (var call in calls) {
      if (_controller.user != null && call.receiver!.email == _controller.user!.email) {
        if (call.endTime!.isAfter(DateTime.now()) && call.status != StatusEnum.I) {
          debugPrint("Encontrou receiver ${call.receiver.email}");
          widget = Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => null,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        border: Border.all(width: 5, color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(500)),
                    child:
                        util.gradientIcon(400, Icons.campaign, startGradient: 0, endGradient: 0.5),
                  ),
                ),
              ));
          // FlutterRingtonePlayer.play(
          //   android: AndroidSounds.alarm,
          //   // android: AndroidSounds.ringtone,
          //   ios: IosSounds.glass,
          //   looping: true,
          //   // Android only - API >= 28
          //   volume: 1,
          //   // Android only - API >= 28
          //   asAlarm: false, // Android only - all APIs
          // );
          break;
        }
      }
    }
    return widget;
  }

  List<Marker> _getMarkers(List<User> hawkers) {
    var markers = <Marker>[];

    //Provisório
    if (userLocation != null) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: userLocation!,
          builder: (ctx) => const Icon(
            Icons.place,
            color: Colors.red,
            size: 50,
          ),
        ),
      );

      for (var hawker in hawkers) {
        if (hawker.position != null) {
          if (_controller.user == null || hawker.email != _controller.user!.email) {
            if ((userLocation!.latitude - hawker.position!.latitude).abs() < HAWKER_LOOK_RANGE &&
                (userLocation!.longitude - hawker.position!.longitude).abs() < HAWKER_LOOK_RANGE) {
              markers.add(Marker(
                width: 80.0,
                height: 80.0,
                point: hawker.position!,
                builder: (ctx) => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child: Transform.scale(
                    scale: 0.5,
                    child: Image.asset(
                      hawker.hawkerCategory != null
                          ? HawkerCategoryEnumExtension.categoryIcon(hawker.hawkerCategory!)
                          : AppImages.categoryBread,
                    ),
                  ),
                ),
              ));
            }
          }
        }
      }
    }
    return markers;
  }
}
