import 'dart:io';

import 'package:dory/pages/add_medicine/add_alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dory/components/dory_constants.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'components/add_page_widget.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final TextEditingController _medicineNameController = TextEditingController();
  File? _medicineImage;

  @override
  //화면이 꺼질 때 dispose해주기.
  void dispose() {
    super.dispose();
    _medicineNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const CloseButton()),
      body: AddPageBody(
        children: [
          Text('어떤 약이에요?', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: largeSpace),
          Center(
            //changeImageFile쪽에서 받아오기.
            child: MedicineImageButton(
              changeImageFile: (File? value) {
                _medicineImage = value;
              },
            ),
          ),
          const SizedBox(height: largeSpace + regularSpace),
          Text('약 이름', style: Theme.of(context).textTheme.subtitle1),
          TextFormField(
            controller: _medicineNameController,
            maxLength: 20,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
                hintText: '복용할 약 이름을 기입해주세요.',
                hintStyle: Theme.of(context).textTheme.bodyText2,
                contentPadding: textFieldContentPadding),
            onChanged: (_) {
              setState(() {});
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
                onPressed: _medicineNameController.text.isEmpty
                    ? null
                    : onAddAlarmPage,
                child: const Text('다음'),
                style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.subtitle1)),
          ),
        ),
      ),
    );
  }

  void onAddAlarmPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAlarmPage(
                medicineImage: _medicineImage,
                medicineName: _medicineNameController.text)));
  }
}

class MedicineImageButton extends StatefulWidget {
  const MedicineImageButton({Key? key, required this.changeImageFile})
      : super(key: key);

  //자식 클래스의 것을 상위 클래스가 가져다 사용할 때 사용.
  final ValueChanged<File?> changeImageFile;

  @override
  State<MedicineImageButton> createState() => _MedicineImageButtonState();
}

class _MedicineImageButtonState extends State<MedicineImageButton> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 40,
        child: CupertinoButton(
          padding: _pickedImage == null ? null : EdgeInsets.zero,
          onPressed: _showBottomSheet,
          child: _pickedImage == null
              ? const Icon(CupertinoIcons.photo_camera_solid,
                  size: 30, color: Colors.white)
              : CircleAvatar(
                  foregroundImage: FileImage(_pickedImage!),
                  radius: 40,
                ),
        ));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickImageBottomSheet(
              onPressedCamera: () => _onPressed(ImageSource.camera),
              onPressedGallery: () => _onPressed(ImageSource.gallery));
        });
  }

  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((xfile) {
      if (xfile == null) return;
      setState(() {
        _pickedImage = File(xfile.path);
        widget.changeImageFile(_pickedImage);
      });
      Navigator.maybePop(context);
    });
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {Key? key, required this.onPressedCamera, required this.onPressedGallery})
      : super(key: key);

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: onPressedCamera,
                child: Text('카메라로 촬영'),
              ),
              TextButton(
                onPressed: onPressedGallery,
                child: Text('앨범에서 가져오기'),
              )
            ],
          )),
    );
  }
}
