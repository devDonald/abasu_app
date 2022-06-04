import 'dart:io';

import 'package:abasu_app/core/constants/text_constants.dart';
import 'package:abasu_app/features/admin/helpers/contract_db.dart';
import 'package:abasu_app/features/profile/models/requests_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../../../core/constants/contants.dart';
import '../../../../core/themes/theme_colors.dart';
import '../../../../core/widgets/add_photo_buttons.dart';
import '../../../../core/widgets/customFullScreenDialog.dart';
import '../../../../core/widgets/primary_button.dart';

class SubmitContract extends StatefulWidget {
  static const String id = 'SubmitContract';
  const SubmitContract({Key? key}) : super(key: key);

  @override
  _SubmitContractState createState() => _SubmitContractState();
}

class _SubmitContractState extends State<SubmitContract> {
  String error = '';
  String subCategoryOption = "";
  bool isPhotoAdded = false;
  bool uploading = false;
  final _description = TextEditingController();
  final _workTitle = TextEditingController();
  final _duration = TextEditingController();
  final _budget = TextEditingController();
  final _address = TextEditingController();

  final FocusNode focusNode = FocusNode();
  final _picker = ImagePicker();
  List<File> _image = [];
  List<String> _imageNames = [];
  String? _category;

  clearPhoto() {
    setState(() {
      isPhotoAdded = false;
    });
  }

  chooseImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
      _imageNames.add(File(pickedFile.path).path.split('/').last);
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  TwilioFlutter? twilioFlutter;

  void _uploadWork() async {
    try {
      if (_image.isNotEmpty) {
        CustomFullScreenDialog.showDialog();
        List<String> url = await ContractDB().uploadFile(_image);
        final RequestModel model = RequestModel(
          workDescription: _description.text.trim(),
          category: _category,
          workTitle: _workTitle.text,
          images: url,
          imagesNames: _imageNames,
          createdAt: createdAt,
          timestamp: timestamp,
          duration: _duration.text,
          budget: int.parse(_budget.text),
          status: 'New Contract',
          artisanId: auth.currentUser!.uid,
        );
        await ContractDB.hireAbasu(model);
        //sendSms(widget.number);
        //sendSms('09015210517');
        CustomFullScreenDialog.cancelDialog();
      } else {
        errorToastMessage(msg: 'Please Upload Sample of contract');
      }

      Navigator.of(context).pop();
    } catch (e) {}
    //bodyValue.clear();
  }

  // void sendSms(receiverNo) async {
  //   twilioFlutter!.sendSMS(
  //       toNumber: '+234$receiverNo',
  //       messageBody:
  //           'Hello ${widget.artisanName}, A new Work Request has been sent to you on Abasu App, quickly go and respond to it now');
  // }

  @override
  void initState() {
    // twilioFlutter = TwilioFlutter(
    //     accountSid: 'AC2c97294f03b32072aee28f9672656a98',
    //     authToken: '800f521338481b407a4fd3b09e2668a4',
    //     twilioNumber: '+2348036795246');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: const Text(
          'Submit Contract to Abasu',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(0.0, 2.5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PostLabel(label: 'Contract Title'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                minLines: 1,
                maxLines: 3, //fix
                controller: _workTitle,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Contract Description'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                minLines: 1,
                maxLines: 8, //fix
                controller: _description,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Contract Duration'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                enableSuggestions: true,
                decoration: const InputDecoration(hintText: 'e.g 3 months'),
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                minLines: 1,
                maxLines: 1, //fix
                controller: _duration,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Your Contract Budget (₦)'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                autofocus: true,
                enableSuggestions: true,
                decoration: const InputDecoration(hintText: 'e.g 80,000'),
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                minLines: 1,
                maxLines: 1, //fix
                controller: _budget,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(
                label: 'Contract Category',
              ),
              const SizedBox(height: 9.5),
              Row(
                children: [
                  const SizedBox(width: 8),
                  DropDown(
                    showUnderline: true,
                    items: artisanCategory,
                    hint: const Text("Contract Category"),
                    icon: const Icon(
                      Icons.expand_more,
                      color: Colors.red,
                    ),
                    onChanged: (dynamic value) {
                      _category = value!;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Contract Location'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                minLines: 1,
                maxLines: 3, //fix
                controller: _address,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Attach Project Sample or Design'),
              const SizedBox(height: 16.5),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _image.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Center(
                                      child: IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () => !uploading
                                              ? chooseImage()
                                              : null),
                                    )
                                  : AddPhotoWidget(
                                      onClearTap: () {
                                        setState(() {
                                          print("index $index");
                                          _image.removeAt(index - 1);
                                        });
                                      },
                                      isPhotoAdded: true,
                                      fileImage: Container(
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(
                                                    _image[index - 1]),
                                                fit: BoxFit.cover)),
                                      ));
                            }),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: PrimaryButton(
                  width: 150,
                  height: 36.5,
                  blurRadius: 3.0,
                  roundedEdge: 5.0,
                  color: ThemeColors.primaryColor,
                  buttonTitle: 'Submit Contract',
                  onTap: () {
                    if (validateRequest(_workTitle.text, _description.text,
                        _category, _budget.text, _duration.text)) {
                      _uploadWork();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Abasu Artisan Hiring Policy',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.5),
                  Text(
                    hiringPolicy,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ));
  }
}

class PostTextFeild extends StatelessWidget {
  const PostTextFeild(
      {Key? key,
      required this.hint,
      required this.height,
      required this.maxLines,
      required this.textController,
      required bool isBorder,
      required this.capitalization})
      : super(key: key);
  final String hint;
  final double height;
  final int maxLines;
  final TextEditingController textController;
  final TextCapitalization capitalization;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        maxLines: maxLines,
        textCapitalization: capitalization,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        controller: textController,
      ),
    );
  }
}

class PostLabel extends StatelessWidget {
  const PostLabel({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
