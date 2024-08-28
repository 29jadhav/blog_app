import 'package:blog_app/core/utils/date_format.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogDetailsPage extends StatelessWidget {
  static const blogDetailsPage = "blog_details_page";
  const BlogDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Blog blog = ModalRoute.of(context)!.settings.arguments as Blog;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text("by ${blog.posterName!}"),
              Text(dateFormat(blog.updatedTime)),
              Center(
                child: SizedBox(
                  height: 150,
                  child: ClipRRect(
                    child: Image.network(
                      blog.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                blog.content,
                style: const TextStyle(height: 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
