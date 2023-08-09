import 'package:ecommerce_ui_flutter/products/presentation/providers/profiles/profile_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final shipping = ref.watch(profileFormProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              const SizedBox(height: 70),
              textFormField("Full Name", shipping.fullName,
                  onchange:
                      ref.read(profileFormProvider.notifier).onFullNameChange),
              const SizedBox(height: 25),
              textFormField("Address", shipping.address,
                  onchange:
                      ref.read(profileFormProvider.notifier).onAddressChange),
              const SizedBox(height: 25),
              textFormField("City", shipping.city,
                  onchange:
                      ref.read(profileFormProvider.notifier).onCityChange),
              const SizedBox(height: 25),
              textFormField("PostalCode", shipping.postalCode,
                  onchange: ref
                      .read(profileFormProvider.notifier)
                      .onPostalCodeChange),
              const SizedBox(height: 25),
              textFormField("Phone", shipping.phone,
                  onchange:
                      ref.read(profileFormProvider.notifier).onPhoneChange),
              const SizedBox(height: 25),
              textFormField("Country", shipping.country,
                  onchange:
                      ref.read(profileFormProvider.notifier).onCountryChange),
              const SizedBox(height: 55),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(77, 77, 121, 0.247),
                            offset: Offset(0, 6),
                            blurRadius: 22,
                            spreadRadius: -2,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(83, 82, 82, 0.298),
                            offset: Offset(0, 3),
                            blurRadius: 27,
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: OutlinedButton(
                        onPressed: () => context.pop(),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.black45),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(77, 77, 121, 0.247),
                            offset: Offset(0, 6),
                            blurRadius: 22,
                            spreadRadius: -2,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(83, 82, 82, 0.298),
                            offset: Offset(0, 3),
                            blurRadius: 27,
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(profileFormProvider.notifier)
                              .onFormSubmit(
                                context,
                                () => QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Transaction Completed Successfully!',
                                ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 155),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormField(
    String labelText,
    String placeholder, {
    IconData? icon,
    IconData? prefIcon,
    IconData? suffIcon,
    onchange,
  }) {
    return TextFormField(
      onChanged: onchange,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 5)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2)),
        contentPadding: const EdgeInsets.all(10),
        icon: icon == null ? null : Icon(icon),
        prefixIcon: prefIcon == null
            ? null
            : IconButton(onPressed: () {}, icon: Icon(prefIcon)),
        suffixIcon: suffIcon == null
            ? null
            : IconButton(onPressed: () {}, icon: Icon(suffIcon)),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 18, color: Colors.black54),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        // floatingLabelStyle: const TextStyle(
        //     color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
