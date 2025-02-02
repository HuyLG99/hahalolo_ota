import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/customer_information_model.dart';
import 'infor_input_customer_widget.dart';

class FormValidation extends StatefulWidget {
  const FormValidation({
    super.key,
  });

  @override
  State<FormValidation> createState() => FormValidationState();
}

class FormValidationState extends State<FormValidation> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController(text: 'Le');

  final lastNameController = TextEditingController(text: 'HUY');

  final emailController = TextEditingController(text: 'Lehuy154@gmail.com');

  final phoneController = TextEditingController(text: '03899123139');

  final addressController =
      TextEditingController(text: '4000,Ung Van Khiem,Ho Chi Minh');

  CustomerInformationModel textInputValue = CustomerInformationModel();
  void loadDataForm() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      if (formKey.currentState!.validate()) {
        formKey.currentState?.save();
        firstNameController.text = prefs.getString('firstName') ?? '';
        prefs.setString('firstName', firstNameController.text ?? '');
        lastNameController.text = prefs.getString('lastName') ?? '';
        prefs.setString('lastName', lastNameController.text ?? '');
        emailController.text = prefs.getString('email') ?? '';
        prefs.setString('email', emailController.text ?? '');
        phoneController.text = prefs.getString('phone') ?? '';
        prefs.setString('phone', phoneController.text ?? '');
        addressController.text = prefs.getString('address') ?? '';
        prefs.setString('address', addressController.text ?? '');
      }
    });
  }

  void setCheckFirstNameNull(bool value, String firstName) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('checkFirstNameValidate_key', value);
    prefs.setString('firstName', firstName ?? '');
  }

  void setCheckLastNameNull(bool value, String lastName) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('checkLastNameValidate_key', value);
    prefs.setString('lastName', lastName ?? '');
  }

  void setCheckEmailNull(bool value, String email) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('checkEmailValidate_key', value);
    prefs.setString('email', email ?? '');
  }

  void setCheckPhoneNull(bool value, String phone) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('checkPhoneValidate_key', value);
    prefs.setString('phone', phone ?? '');
  }

  void setCheckAddressNull(bool value, String address) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('checkAddressValidate_key', value);
    prefs.setString('address', address ?? '');
  }

  bool isValidateFirstNameNull = false;
  bool isValidateLastNameNull = false;
  bool isValidatePhoneNull = false;
  bool isValidateEmailNameNull = false;
  bool isValidateAddressNameNull = false;
  void checkStatusValidate() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      isValidateFirstNameNull = prefs.getBool('checkFirstNameValidate2_key')!;
      isValidateLastNameNull = prefs.getBool('checkLastNameValidate2_key')!;
      isValidateEmailNameNull = prefs.getBool('checkEmailValidate2_key')!;
      isValidatePhoneNull = prefs.getBool('checkPhoneValidate2_key')!;
      isValidateAddressNameNull = prefs.getBool('checkAddressValidate2_key')!;
    });
    if (isValidateFirstNameNull == true &&
        isValidateLastNameNull == true &&
        isValidateEmailNameNull == true &&
        isValidatePhoneNull == true &&
        isValidateAddressNameNull == true) {}
  }

  Future scrollItem() async {
    final context = formKey.currentContext!;
    await Scrollable.ensureVisible(
      context,
      curve: Curves.ease,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDataForm();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Họ *',
              border: InputBorder.none,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                //allow upper and lower case alphabets and space
                scrollItem();
                setCheckFirstNameNull(true, value);
                return "Enter Correct Name";
              } else {
                setCheckFirstNameNull(false, value);
                return null;
              }
            },
            onChanged: (value) {
              setCheckFirstNameNull(false, value);
            },
            onSaved: (value) async {
              // textInputValue.firstName = value;
            },
          ),
          const DotWidget(
            dashColor: Colors.grey,
            dashHeight: 1,
            dashWidth: 5,
          ),
          TextFormField(
            controller: lastNameController,
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Tên đệm và tên *',
              border: InputBorder.none,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                //allow upper and lower case alphabets and space
                scrollItem();
                setCheckLastNameNull(true, value);
                return "Enter Correct Name";
              } else {
                setCheckLastNameNull(false, value);
                return null;
              }
            },
            onSaved: (value) {
              // textInputValue.lastName = value;
            },
          ),
          const DotWidget(
            dashColor: Colors.grey,
            dashHeight: 1,
            dashWidth: 5,
          ),
          const RadioButtonWidget(),
          const DotWidget(
            dashColor: Colors.grey,
            dashHeight: 1,
            dashWidth: 5,
          ),
          TextFormField(
            controller: emailController,
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Email * ',
              border: InputBorder.none,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty ||
                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                scrollItem();
                setCheckEmailNull(true, value);
                return "Enter Correct Email Address";
              } else {
                setCheckEmailNull(false, value);
                return null;
              }
            },
            onSaved: (value) {
              // textInputValue.email = value;
            },
          ),
          const DotWidget(
            dashColor: Colors.grey,
            dashHeight: 1,
            dashWidth: 5,
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    '+84',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: phoneController,
                      autovalidateMode: AutovalidateMode.always,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        labelText: 'Số điện thoại *',
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                .hasMatch(value)) {
                          scrollItem();
                          setCheckPhoneNull(true, value);
                          return "Enter Correct Phone Number";
                        } else {
                          setCheckPhoneNull(false, value);
                          return null;
                        }
                      },
                      onSaved: (value) {
                        // textInputValue.phone = value;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const DotWidget(
            dashColor: Colors.grey,
            dashHeight: 1,
            dashWidth: 5,
          ),
          TextFormField(
            controller: addressController,
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Địa chỉ * ',
              border: InputBorder.none,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                scrollItem();
                setCheckAddressNull(true, value);
                return "Enter Correct Address";
              } else {
                setCheckAddressNull(false, value);
                return null;
              }
            },
            onSaved: (value) {
              // textInputValue.address = value;
            },
          ),
          const DotWidget(
            dashColor: Colors.grey,
            dashHeight: 1,
            dashWidth: 5,
          ),
        ],
      ),
    );
  }
}
