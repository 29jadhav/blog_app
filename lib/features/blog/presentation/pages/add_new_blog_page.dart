import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snakbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_content_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static const addNewBlogPage = "add_new_blog_page";
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final blogTitleController = TextEditingController();
  final blogContentController = TextEditingController();
  final categories = ['Business', 'Techonlogy', 'Science', 'Health', 'Sprot'];
  List<String> selectedCategories = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    blogTitleController.dispose();
    blogContentController.dispose();
    super.dispose();
  }

  pickImage() async {
    final fileImage = await selectImage();
    if (fileImage != null) {
      setState(() {
        image = fileImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: uploadBlogToServer,
                icon: const Icon(Icons.done_rounded))
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogBlocState>(
          listener: (context, state) {
            if (state is BlogBlocFailuer) {
              showSnakbar(context, state.errorMessage);
            } else if (state is BlogBlocSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, BlogPage.blogPage, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is BlogBlocLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppPallete.borderColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: image == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select your image",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12),
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  if (selectedCategories
                                      .contains(categories[index])) {
                                    selectedCategories
                                        .remove(categories[index]);
                                  } else {
                                    selectedCategories.add(categories[index]);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(categories[index]),
                                  color: selectedCategories
                                          .contains(categories[index])
                                      ? const MaterialStatePropertyAll(
                                          AppPallete.gradient1)
                                      : null,
                                  side: selectedCategories
                                          .contains(categories[index])
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      BlogContentText(
                          hintText: "Blog Title",
                          controller: blogTitleController),
                      const SizedBox(
                        height: 12,
                      ),
                      BlogContentText(
                        hintText: "Blog Content",
                        controller: blogContentController,
                        mutliline: true,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void uploadBlogToServer() {
    if (formKey.currentState!.validate() &&
        selectedCategories.isNotEmpty &&
        image != null) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            UploadBlogEvent(
                title: blogTitleController.text.trim(),
                content: blogContentController.text.trim(),
                image: image!,
                topics: selectedCategories,
                profileId: userId),
          );
    }
  }
}
