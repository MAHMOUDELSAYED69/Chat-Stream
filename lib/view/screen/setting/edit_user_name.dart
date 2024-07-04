import 'dart:developer';
import 'package:chat_stream/helper/extentions/extentions.dart';
import 'package:chat_stream/view/widget/my_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_stream/helper/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/snackbar.dart';
import '../../../logic/setting/change_name_cubit/change_name_cubit.dart';
import '../../widget/custom_text_field.dart';

class EditUserName extends StatefulWidget {
  const EditUserName({super.key});

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  late TextEditingController _changeNameController;
  @override
  void initState() {
    _changeNameController = TextEditingController();
    super.initState();
  }

  bool _isNameLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocProvider(
                  create: (context) => ChangeNameCubit(),
                  child: BlocConsumer<ChangeNameCubit, ChangeNameState>(
                    listener: (context, state) {
                      if (state is ChangeNameLoading) {
                        _isNameLoading = true;
                      }
                      if (state is ChangeNameSuccess) {
                        _isNameLoading = false;
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      }
                      if (state is ChangeNameFailure) {
                        _isNameLoading = false;
                        customSnackBar(context,
                            "There was an error please try again later!");
                        log(state.message);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomTextFormField(
                            controller: _changeNameController,
                            validator: (value) {
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            title: "Change Name",
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          ColorManager.red)),
                                  child: Text(
                                    "Cancle",
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: ColorManager.white),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  child: _isNameLoading == false
                                      ? Text(
                                          "Save",
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: ColorManager.white),
                                        )
                                      : const MyLoadingIndicator(),
                                  onPressed: () {
                                    if (_changeNameController.text.isNotEmpty) {
                                      context
                                          .read<ChangeNameCubit>()
                                          .changeDisplayName(
                                              name: _changeNameController.text);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showEditAccountBottomSheet(BuildContext context) {
  showModalBottomSheet(
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20))),
    backgroundColor: ColorManager.darkGrey,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const EditUserName();
    },
  );
}
