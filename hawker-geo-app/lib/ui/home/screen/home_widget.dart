import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:hawker_geo/core/model/role_enum.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/core/persistence/firestore/call_repo.dart';
import 'package:hawker_geo/core/persistence/firestore/user_repository.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/core/utils/constants.dart';
import 'package:hawker_geo/core/utils/util.dart';
import 'package:hawker_geo/ui/home/home_controller.dart';
import 'package:hawker_geo/ui/home/screen/components/hawker_details_widget.dart';
import 'package:hawker_geo/ui/home/screen/components/home_drawer_widget.dart';
import 'package:hawker_geo/ui/shared/floating_switch_widget.dart';
import 'package:hawker_geo/ui/shared/loading_widget.dart';
import 'package:hawker_geo/ui/shared/shared_pop_ups.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/model/user.dart';
import '../../styles/text.dart';
import 'home_page.dart';

class HomeWidget extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _controller = HomeController();
  final MapController mapController = MapController();
  final Util util = Util();

  DateTime? currentBackPressTime;

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
    // util.generateHawker(5);
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
        var calls = _controller.docsToCallsList(callsDocs);
        // Widget widget = Container();
        for (var call in calls) {
          if (_controller.user != null && call.receiver!.email == _controller.user!.email) {
            if (call.endTime!.isAfter(DateTime.now()) && call.status != StatusEnum.I) {
              debugPrint("Encontrou receiver ${call.receiver.email}");
              SharedPopUps().genericPopUp(context,
                  title: "Chamado!!",
                  description: "Você recebeu um chamado!",
                  acceptButtonText: "OK",
                  acceptButtonOnPressed: () => Navigator.of(context).pop());
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
    var locationButton = FloatingActionButton(
      onPressed: () async {
        await _ratingPopUp(context);
      },
      backgroundColor: kPrimaryLightColor.withOpacity(0.8),
      child: Icon(Icons.my_location_sharp, color: Colors.red.withOpacity(0.8)),
    );
    if (_controller.isLoggedIn()) {
      RoleEnum? role = _controller.getUserRole();

      if (role == RoleEnum.ROLE_HAWKER) {
        return _floatingSwitchButton(context);
      } else if (role == RoleEnum.ROLE_CUSTOMER) {
        return _floatingCallButton();
      }
    }
    return locationButton;
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
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if ((currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > const Duration(seconds: 2))) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: "Para sair toque 2 vezes voltar");
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: HomeDrawerWidget(
          user: _controller.user,
          isLogged: _controller.isLoggedIn(),
          registerOnPressed: () => _controller.goToRegister(context),
          logoutOnPressed: () async {
            _controller.logout().then((_) {
              _getUserLocation();
              _getUser();
              setState(() {});
              _scaffoldKey.currentState?.closeDrawer();
            });
          },
          loginOnPressed: () async {
            await _controller.showLoginModal(context).then((_) {
              _getUserLocation();
              _getUser();
              setState(() {});
            });
          },
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(UserRepository.REPO_NAME).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const LoadingWidget();
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
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: _getFloatingButton(context),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: IconButton(
                        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                        icon: const Icon(Icons.menu)),
                  ),
                  // _receiveCall(context),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  _receiveCall(BuildContext context) {
    var calls = _controller.docsToCallsList(callsDocs);
    // Widget widget = Container();
    for (var call in calls) {
      if (_controller.user != null && call.receiver!.email == _controller.user!.email) {
        if (call.endTime!.isAfter(DateTime.now()) && call.status != StatusEnum.I) {
          debugPrint("Encontrou receiver ${call.receiver.email}");
          SharedPopUps().genericPopUp(context,
              title: "Chamado!!",
              description: "Você recebeu um chamado!",
              acceptButtonText: "OK",
              acceptButtonOnPressed: () => Navigator.of(context).pop());
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
    // return widget;
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
                    scale: 0.6,
                    child: Material(
                      color: kThirdColor.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () => _showHawkerDetails(context, hawker),
                        child: Image.asset(
                          hawker.hawkerDetails?.categories != null
                              ? HawkerCategoryEnumExtension.categoryIcon(hawker.hawkerDetails!
                                  .categories!.first) // TODO - está pegando first da category
                              : AppImages.categoryBread,
                          scale: 0.7,
                        ),
                      ),
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

  _showHawkerDetails(BuildContext context, User hawker) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return HawkerDetailsWidget(
          hawker: hawker,
          callButtonOnPressed: () => SharedPopUps().genericPopUp(context,
              title: "Criar chamado",
              description: "Realmente deseja criar um chamado para esse vendedor?",
              acceptButtonText: "Sim",
              cancelButtonText: "Não", acceptButtonOnPressed: () {
            _controller.callHawker(context, hawker, userLocation!);
            Fluttertoast.showToast(msg: "Chamando vendedor...");
            Navigator.of(context).pop();
          }),
        );
      },
    );
  }

  _acceptPopUp(BuildContext context) async {
    // TODO - componentizar
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Recebendo chamado de:",
                        style: boldTitle.copyWith(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://www.masslive.com/resizer/kNl3qvErgJ3B0Cu-WSBWFYc1B8Q=/arc-anglerfish-arc2-prod-advancelocal/public/W5HI6Y4DINDTNP76R6CLA5IWRU.jpeg")),
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: kPrimaryLightColor,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),

                          const Text("Usuário Cliente 001",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                          // IconButton(
                          //     onPressed: callButtonOnPressed,
                          //     icon: const GradientIcon(
                          //       icon: Icons.campaign,
                          //       rectSize: 26,
                          //       iconSize: 30,
                          //     ))
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Avaliação geral:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            ignoreGestures: true,
                            minRating: 1,
                            itemSize: 25,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: kFourthLightColor,
                            ),
                            onRatingUpdate: (rating) => 0,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryLightColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    iconSize: 40,
                                    splashRadius: 50,
                                  ),
                                ),
                                Text(
                                  "Aceitar",
                                  style: boldTitle.copyWith(fontSize: 15),
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: kSecondDarkColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    iconSize: 40,
                                    splashRadius: 50,
                                  ),
                                ),
                                Text(
                                  "Negar",
                                  style: boldTitle.copyWith(fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  _ratingPopUp(BuildContext context) async {
    // TODO - componentizar
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Nos conte como foi o atendimento!",
                        textAlign: TextAlign.center,
                        style: boldTitle.copyWith(fontSize: 20),
                      ),
                      const Divider(color: Colors.black, height: 20, endIndent: 20, thickness: 1),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://www.masslive.com/resizer/kNl3qvErgJ3B0Cu-WSBWFYc1B8Q=/arc-anglerfish-arc2-prod-advancelocal/public/W5HI6Y4DINDTNP76R6CLA5IWRU.jpeg")),
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: kPrimaryLightColor,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),

                          const Text("Usuário Cliente 001",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                          // IconButton(
                          //     onPressed: callButtonOnPressed,
                          //     icon: const GradientIcon(
                          //       icon: Icons.campaign,
                          //       rectSize: 26,
                          //       iconSize: 30,
                          //     ))
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Nota:",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            itemSize: 35,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: kFourthLightColor,
                            ),
                            onRatingUpdate: (rating) => 0,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Descrição:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          color: Colors.grey.withOpacity(0.2),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              maxLines: 4, //or null
                              decoration: InputDecoration.collapsed(
                                  hintText: "Comente sobre o atendimento...",
                                  // fillColor: Colors.grey.withOpacity(0.3),
                                  ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Atendimento rápido",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Boa conversa",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
