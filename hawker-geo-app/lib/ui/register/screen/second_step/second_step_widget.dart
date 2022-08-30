/*
 * Created by Kairo Amorim on 30/08/2022 17:04
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 17:04
 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawker_geo/core/model/gender_enum.dart';
import 'package:hawker_geo/core/utils/permissions_utils.dart';
import 'package:hawker_geo/ui/register/register_controller.dart';
import 'package:hawker_geo/ui/register/screen/components/icon_galery.dart';
import 'package:hawker_geo/ui/register/screen/components/register_dropdown_button.dart';
import 'package:hawker_geo/ui/register/screen/components/register_text_field.dart';
import 'package:hawker_geo/ui/shared/custom-behavior.dart';
import 'package:hawker_geo/ui/shared/default_next_button.dart';
import 'package:hawker_geo/ui/shared/formatters/phone_input_formatter.dart';
import 'package:hawker_geo/ui/shared/function_widgets.dart';
import 'package:hawker_geo/ui/shared/gradient_icon.dart';
import 'package:hawker_geo/ui/shared/shared_pop_ups.dart';
import 'package:hawker_geo/ui/shared/validators.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:image_picker/image_picker.dart';

import 'second_step_page.dart';

class RegisterSecondStepWidget extends State<RegisterSecondStepPage> {
  final _controller = RegisterController();
  final _validators = Validators();

  dynamic _image;
  File? _imageFile;
  String? imageBase64;

  @override
  void initState() {
    _controller.user = widget.user;
    _controller.user.gender = GenderEnum.values.first;
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = false;
        await SharedPopUps().genericPopUp(
          context,
          title: "Deseja sair?",
          description: "Você poderá continuar o cadastro mais tarde.",
          acceptButtonText: "Sim",
          acceptButtonOnPressed: () {
            canPop = true;
            Navigator.of(context).pop();
          },
          cancelButtonText: "Não",
          cancelButtonOnPressed: () {
            canPop = false;
            Navigator.of(context).pop();
          },
        );

        return Future.value(canPop);
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Stack(alignment: Alignment.center, fit: StackFit.loose, children: [
                Align(
                  alignment: Alignment.center,
                  child: IconGallery(
                    borderColor: kPrimaryColor,
                    borderWidth: 3,
                    padding: EdgeInsets.all(6),
                    disabled: false,
                    icon: Icons.account_circle_sharp.codePoint,
                    image: _image,
                    onPressed: () {},
                    buttonSize: Size(90, 90),
                    iconSize: 70,
                  ),
                ),
                Positioned(
                  right: 105,
                  bottom: -3,
                  child: ElevatedButton(
                    onPressed: () {
                      _showModalBottomSheet(context);
                    },
                    child: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      shape: CircleBorder(),
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: 20,
              ),
              // const Center(child: Text("Registre-se", style: boldTitle)),
              RegisterTextField(
                  hintText: "Apelido",
                  icon: Icons.person,
                  onChanged: (value) {
                    _controller.user.name = value;
                  }),
              RegisterTextField(
                  hintText: "Celular",
                  icon: Icons.email,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, PhoneInputFormatter()],
                  validator: (value) => _validators.phoneValidator(value),
                  onChanged: (value) {
                    var number = value.replaceAll(" ", "");
                    number = number.replaceAll(RegExp(r'[^0-9]'), "");
                    _controller.user.phoneNumber = number;
                  }),
              _genderDropdown(),
              DefaultNextButton(
                "FINALIZAR",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FunctionWidgets().showLoading(context);
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _genderDropdown() {
    return RegisterDropdownButton<GenderEnum>(
      value: _controller.user.gender,
      items: GenderEnum.values.map<DropdownMenuItem<GenderEnum>>((GenderEnum value) {
        return DropdownMenuItem<GenderEnum>(
          value: value,
          child: Row(
            children: [
              GradientIcon(
                  icon: GenderEnumExtension.genderIcon(value),
                  rectSize: 30,
                  gradientColors: const [Colors.lightGreen, Color.fromARGB(255, 42, 159, 45)]),
              const SizedBox(width: 10),
              Text(GenderEnumExtension.getEnumName(value)),
            ],
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _controller.user.gender = newValue!;
        });
      },
    );
  }

  _showModalBottomSheet(BuildContext context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * .2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))),
            child: ScrollConfiguration(
              behavior: CustomBehavior(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                      icon: Icon(
                        Icons.image,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        _getImage(ImageSource.gallery);
                        Navigator.of(context).pop(_image);
                      },
                      label: Text(
                        "Galeria",
                        style: TextStyle(color: kPrimaryColor),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                      icon: Icon(
                        Icons.camera_alt,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        _getImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      label: Text("Camera", style: TextStyle(color: kPrimaryColor))),
                ],
              ),
            ),
          );
        });
  }

  Future _getImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      this.getCamera(source);
    } else if (source == ImageSource.gallery) {
      this.getGallery(source);
    }
  }

  void getGallery(ImageSource source) async {
    if (await PermissionsUtils.checkPermissionPhoto()) {
      final image = await ImagePicker().getImage(source: source);
      if (image != null) {
        setState(() {
          _image = File(image.path);
          _imageFile = _image;
          imageBase64 = base64Encode(_image!.readAsBytesSync());
        });
      }
    }
  }

  void getCamera(ImageSource source) async {
    if (await PermissionsUtils.checkPermissionCamera()) {
      final image = await ImagePicker().getImage(source: source);
      if (image != null) {
        setState(() {
          _image = File(image.path);
          _imageFile = _image;
          imageBase64 = base64Encode(_image!.readAsBytesSync());
        });
      }
    }
  }
}