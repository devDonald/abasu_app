import 'package:abasu_app/core/widgets/display_event.dart';
import 'package:abasu_app/features/admin/admin_contract/admin_previous_contracts.dart';
import 'package:abasu_app/features/contracts/submit_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/text_constants.dart';

class Contracts extends StatelessWidget {
  const Contracts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.5,
          bottom: 10.0,
        ),
        padding: const EdgeInsets.only(
          left: 10.5,
          right: 23.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(color: Colors.blueGrey, offset: Offset(0.0, 2.5)),
          ],
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const SizedBox(
              height: 2.5,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                abasuContract,
                style: TextStyle(color: Colors.black87, fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 10.5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const ViewAttachedImage(
                      image: AssetImage('images/abasu.jpg'),
                      text: 'Abasu Konsult Limited CAC Document',
                      url: '',
                    ));
              },
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'View Our CAC Document',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 10.5,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0.0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: Container(
            height: 70.0,
            decoration: const BoxDecoration(
                // color: Theme.of(context).primaryColor
                ),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const AdminPreviousContract(isAdmin: false));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: (screenSize.width - 20) / 2,
                    child: const Text(
                      'View Previous Contracts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                      width: (screenSize.width - 50) / 2,
                      child: RaisedButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        child: const Text("Submit Contracts"),
                        onPressed: () {
                          Get.to(() => const SubmitContract());
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
