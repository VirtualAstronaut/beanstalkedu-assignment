import 'package:beanstalkedu_assignment/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ArticleContainer extends ConsumerStatefulWidget {
  const ArticleContainer({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleContainerState();
}

class _ArticleContainerState extends ConsumerState<ArticleContainer> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      margin: const EdgeInsets.all(9),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.articleModel.urlToImage,
              height: 25.h,
              width: 100.w,
              errorBuilder: (context, error, stackTrace) => SizedBox(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                    height: 25.h,
                    width: 100.w,
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 75.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.articleModel.title.trim(),
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: colorScheme.onPrimaryContainer),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          widget.articleModel.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: colorScheme.onPrimaryContainer),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_outlined))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                if (widget.articleModel.source?.name != null)
                  Chip(
                    label: Text(
                      widget.articleModel.source!.name,
                      style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 10.sp),
                    ),
                    backgroundColor: colorScheme.inversePrimary,
                  ),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    DateFormat('dd/MM/yyyy')
                        .format(widget.articleModel.publishedAt),
                    style: TextStyle(
                        color: colorScheme.onPrimaryContainer, fontSize: 10.sp),
                  ),
                  backgroundColor: colorScheme.inversePrimary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
