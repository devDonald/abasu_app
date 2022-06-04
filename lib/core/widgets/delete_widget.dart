import 'package:flutter/material.dart';

import '../themes/theme_colors.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({
    Key? key,
    required this.delete,
    required this.onEdit,
    required this.editable,
  }) : super(key: key);
  final Function() delete, onEdit;
  final bool editable;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.delete,
                  size: 17,
                  color: ThemeColors.primaryGreyColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: delete,
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: ThemeColors.brownishGrey,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
            value: 1,
          ),
        );
        (editable)
            ? list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.reply,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onEdit,
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              )
            : Container();
        return list;
      },
      icon: const Icon(
        Icons.more_vert,
        size: 20,
        color: ThemeColors.primaryGreyColor,
      ),
    );
  }
}

class RespondWidget extends StatelessWidget {
  const RespondWidget({
    Key? key,
    required this.delete,
    required this.onEdit,
    required this.editable,
  }) : super(key: key);
  final Function() delete, onEdit;
  final bool editable;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.delete,
                  size: 17,
                  color: ThemeColors.primaryGreyColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: delete,
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: ThemeColors.brownishGrey,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
            value: 1,
          ),
        );
        (editable)
            ? list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.reply,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onEdit,
                        child: const Text(
                          "Update Status",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              )
            : Container();
        return list;
      },
      icon: const Icon(
        Icons.more_vert,
        size: 20,
        color: ThemeColors.primaryGreyColor,
      ),
    );
  }
}
