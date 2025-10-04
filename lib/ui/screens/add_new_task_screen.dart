import 'package:flutter/material.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/refresh_new_screen.dart';
import 'package:todo_app/ui/widgets/app_background.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';
import 'package:todo_app/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static const name = "add_new_task";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _fomKey = GlobalKey<FormState>();
  final TextEditingController _subjectTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppBar(),
      body: AppBackground(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Form(
                    key: _fomKey,
                    child: Column(
                      spacing: 8,
                      children: [
                        TextFormField(
                          controller: _subjectTEC,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(label: Text('Subject')),
                          validator: (value) {
                            if (value!.trim() == "") {
                              return "Must input a todo subject";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUnfocus,
                        ),

                        TextFormField(
                          controller: _descriptionTEC,
                          textInputAction: TextInputAction.done,
                          maxLines: 6,
                          decoration: InputDecoration(
                            label: Text('Description'),
                            alignLabelWithHint: true,
                          ),
                          validator: (value) {
                            if (value!.trim() == "") {
                              return "Must fill the decription of todo!";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUnfocus,
                        ),
                        SizedBox(height: 8),
                        Visibility(
                          visible: !isProcessing,
                          replacement: CircularProgressIndicator(
                            strokeWidth: 5,
                          ),
                          child: FilledButton.icon(
                            onPressed: _addTodo,
                            label: Icon(Icons.add_circle_outline_sharp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTodo() async {
    if (_fomKey.currentState!.validate()) {
      isProcessing = !isProcessing;
      setState(() {});
      Map<String, dynamic> body = {
        "title": _subjectTEC.text,
        "description": _subjectTEC.text,
        "status": "New",
      };

      ApiResponse apiResponse = await ApiCalller.postRequest(
        url: Urls.createTodo,
        body: body,
      );
      if (apiResponse.isuccess) {
        RefreshNewScreen.refresh!.call();

        showSnackBar(
          context,
          "New ToDo added successfully!",
          ToastType.success,
        );
        _descriptionTEC.clear();
        _subjectTEC.clear();
      } else {
        showSnackBar(
          context,
          apiResponse.errorMessage.toString(),
          ToastType.error,
        );
      }
      setState(() {
        isProcessing = !isProcessing;
      });
    }
  }

  @override
  void dispose() {
    _subjectTEC.dispose();
    _descriptionTEC.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
