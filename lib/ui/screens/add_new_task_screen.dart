import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/controllers/new_task_section_provider.dart';
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
              child: Consumer<NewTaskSectionProvider>(
                builder: (context, newTaskSectionProvider, child) => Column(
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
                            visible: !newTaskSectionProvider.isCreating,
                            replacement: CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                            child: FilledButton.icon(
                              onPressed: () async {
                                if (_fomKey.currentState!.validate()) {
                                  bool success = await newTaskSectionProvider
                                      .createTodo(
                                        _subjectTEC.text.trim(),
                                        _descriptionTEC.text.trim(),
                                      );
                                  if (success) {
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
                                      newTaskSectionProvider.getErrorMessage!,
                                      ToastType.error,
                                    );
                                  }
                                }
                              },
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subjectTEC.dispose();
    _descriptionTEC.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
