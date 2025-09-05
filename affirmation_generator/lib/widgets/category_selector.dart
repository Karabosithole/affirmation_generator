import 'package:flutter/material.dart';
import '../models/affirmation.dart';

class CategorySelector extends StatefulWidget {
  final List<AffirmationCategory> categories;
  final List<String> selectedCategories;
  final Function(List<String>) onSelectionChanged;
  final bool enableAnimations;

  const CategorySelector({
    Key? key,
    required this.categories,
    required this.selectedCategories,
    required this.onSelectionChanged,
    this.enableAnimations = true,
  }) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    
    if (widget.enableAnimations) {
      _slideController.forward();
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _toggleCategory(String categoryName) {
    setState(() {
      if (widget.selectedCategories.contains(categoryName)) {
        widget.selectedCategories.remove(categoryName);
      } else {
        widget.selectedCategories.add(categoryName);
      }
    });
    widget.onSelectionChanged(List.from(widget.selectedCategories));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            final isSelected = widget.selectedCategories.contains(category.name);
            
            return AnimatedCategoryChip(
              category: category,
              isSelected: isSelected,
              onTap: () => _toggleCategory(category.name),
              enableAnimations: widget.enableAnimations,
            );
          },
        ),
      ),
    );
  }
}

class AnimatedCategoryChip extends StatefulWidget {
  final AffirmationCategory category;
  final bool isSelected;
  final VoidCallback onTap;
  final bool enableAnimations;

  const AnimatedCategoryChip({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.enableAnimations = true,
  }) : super(key: key);

  @override
  _AnimatedCategoryChipState createState() => _AnimatedCategoryChipState();
}

class _AnimatedCategoryChipState extends State<AnimatedCategoryChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableAnimations) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enableAnimations) {
      _controller.reverse();
    }
    widget.onTap();
  }

  void _handleTapCancel() {
    if (widget.enableAnimations) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.enableAnimations ? _scaleAnimation.value : 1.0,
            child: Transform.rotate(
              angle: widget.enableAnimations ? _rotationAnimation.value : 0.0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? Color(int.parse(widget.category.color))
                        : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(int.parse(widget.category.color)),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(int.parse(widget.category.color)).withOpacity(0.3),
                        blurRadius: widget.isSelected ? 8 : 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.category.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.category.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: widget.isSelected ? Colors.white : Color(int.parse(widget.category.color)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
