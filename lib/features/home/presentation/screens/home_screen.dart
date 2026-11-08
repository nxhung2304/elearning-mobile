import 'package:elearning_mobile/app/logger/app_logger.dart';
import 'package:elearning_mobile/core/exceptions/app_exception.dart';
import 'package:elearning_mobile/features/home/data/models/course_category.dart';
import 'package:elearning_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:elearning_mobile/features/home/presentation/widgets/course_search_bar.dart';
import 'package:elearning_mobile/shared/widgets/loading/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CourseLevel { beginner, intermediate, advanced }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  final ValueNotifier<CourseLevel?> selectedLevel = ValueNotifier<CourseLevel?>(
    null,
  );

  List<CourseCategory> _courseCategories = [];
  CourseCategory _selectedCategory = CourseCategory(id: 0, name: 'Tất cả');

  @override
  Widget build(BuildContext context) {
    final homeController = ref.read(homeControllerProvider.notifier);
    final signInState = ref.watch(homeControllerProvider);

    ref.listen(homeControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final text = error is AppException ? error.message : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(text)));
        },
        data: (categories) {
          _courseCategories = categories;
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title: Transform(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: Text("Khoá học", style: TextStyle(color: Colors.black)),
        ),
      ),
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: signInState.isLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(26, 28, 26, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search
                CourseSearchBar(
                  controller: searchController,
                  onChanged: (value) {
                    AppLogger.info('Search input: $value');
                  },
                ),

                // Course Level bottom sheet
                OutlinedButton.icon(
                  onPressed: () {
                    _showLevelsSheet(context, selectedLevel);
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                  label: const Text('Cấp độ'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                // Filter cateogry chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _courseCategories.map((category) {
                      final isSelected =
                          _selectedCategory.name == category.name;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(category.name),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                              AppLogger.info(
                                'Selected category: ${category.name}',
                              );
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Course list: border top / bottom
                // Loading more
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLevelsSheet(
    BuildContext context,
    ValueNotifier<CourseLevel?> selectedLevel,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ValueListenableBuilder<CourseLevel?>(
          valueListenable: selectedLevel,
          builder: (context, currentLevel, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Chọn cấp độ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...CourseLevel.values.map((level) {
                  final labels = {
                    CourseLevel.beginner: 'Cơ bản',
                    CourseLevel.intermediate: 'Trung cấp',
                    CourseLevel.advanced: 'Nâng cao',
                  };

                  return RadioListTile<CourseLevel>(
                    title: Text(labels[level]!),
                    value: level,
                    groupValue: currentLevel,
                    onChanged: (value) {
                      selectedLevel.value = value;
                      AppLogger.info('Selected level: ${labels[value]}');
                    },
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }
}
