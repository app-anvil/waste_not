import 'package:flext/flext.dart';
import 'package:flutter/material.dart';

import '../../framework/selectable.dart';
import '../../style/style.dart';
import '../spans.dart';
import 'input.dart';

/// {@template selection_input}
/// This class provides a simple implementation of
/// a input with an optional title and a list of selectable options.
/// The type T must be extends [Selectable] so, the implementation can be
/// generic.
/// Use the getter value to show the String representation of the item.
///
/// {@endtemplate}
class SelectionInput<T extends Selectable> extends StatelessWidget {
  /// {@macro selection_input}
  const SelectionInput({
    required this.onChanged,
    required this.options,
    this.smallTitle = false,
    this.initialValue,
    this.title,
    super.key,
  })  : multiItems = false,
        initialValues = null;

  /// {@macro selection_input}
  const SelectionInput.multi({
    required this.onChanged,
    required this.options,
    this.smallTitle = false,
    this.initialValues,
    this.title,
    super.key,
  })  : multiItems = true,
        initialValue = null;

  /// Indicates the initial value of the selection.
  ///
  /// Use only if the selection support only one choice.
  final T? initialValue;

  /// Indicates the initial values of the selection.
  ///
  /// Use only if the selection support multiple choices.
  final List<T>? initialValues;

  /// Indicates the possible choices for the selection.
  final List<T> options;

  /// Whether the selection supports multiple choices.
  final bool multiItems;

  final String? title;

  final bool smallTitle;

  final void Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    final input = _SelectionInput(
      onChanged: onChanged,
      options: options,
      initialValue: initialValue,
      initialValues: initialValues,
      multiItems: multiItems,
    );
    if (title != null) {
      return InputWithTitle(
        title: title!,
        input: input,
        isSmall: smallTitle,
      );
    }
    return input;
  }
}

class _SelectionInput<T extends Selectable> extends StatefulWidget {
  const _SelectionInput({
    required this.onChanged,
    required this.options,
    required this.multiItems,
    this.initialValue,
    this.initialValues,
    super.key,
  }) : assert(
          (initialValue != null || initialValues != null) ||
              (initialValue == null && initialValues == null),
          'Only one of initialValue and initialValues can be used',
        );

  /// Indicates the initial value of the selection.
  ///
  /// Use only if the selection support only one choice.
  final T? initialValue;

  /// Indicates the initial values of the selection.
  ///
  /// Use only if the selection support multiple choices.
  final List<T>? initialValues;

  /// Whether the selection supports multiple choices.
  final bool multiItems;

  final void Function(T) onChanged;

  final List<T> options;

  @override
  State<_SelectionInput<T>> createState() => __SelectionInputState();
}

class __SelectionInputState<T extends Selectable>
    extends State<_SelectionInput<T>> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  late OverlayEntry? _entry;

  /// Allow the overlay to be attached to the textfield during the scroll.
  late final LayerLink _layerLink;

  /// The selected items. They are used to compose the text of the input
  /// and to indicates if an item is selected or not.
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = [];
    if (widget.initialValue != null) {
      _selectedItems.add(widget.initialValue!);
    }
    if (widget.initialValues != null) {
      _selectedItems.addAll(widget.initialValues!);
    }
    _textController = TextEditingController(
      text: _selectedItems.map((e) => e.value).join('|'),
    );
    _focusNode = FocusNode()..addListener(_onFocus);
    _layerLink = LayerLink();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTap(T element, {required bool isSelected}) {
    if (widget.multiItems) {
      if (isSelected) {
        _selectedItems.remove(element);
      } else {
        _selectedItems.add(element);
      }
      _textController.text = _selectedItems.map((e) => e.value).join('|');
      widget.onChanged(element);
      // list is updated
      setState(() {});
      // rebuild the overlay entry.
      _entry!.markNeedsBuild();
    } else {
      _textController.text = element.value;
      widget.onChanged(element);
      _hideOverlay();
      _focusNode.unfocus();
    }
  }

  void _showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    // Basically the size of the widget inside the build method (textformfield)
    final size = renderBox.size;

    // Get the position of the top left corner.
    // Using layer, the offset of the render box is no longer needed.
    //final offset = renderBox.localToGlobal(Offset.zero);

    _entry = OverlayEntry(
      builder: (ctx) => Positioned(
        //left: offset.dx,
        //top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          // Using layer, the offset of the render box is no longer needed.
          offset: Offset(0, size.height),
          child: _Overlay<T>(
            options: widget.options,
            selectedItems: _selectedItems,
            onTap: _onTap,
            multiItems: widget.multiItems,
          ),
        ),
      ),
    );

    overlay.insert(_entry!);
  }

  void _hideOverlay() {
    _entry?.remove();
    _entry = null;
  }

  /// Shows or hides the overlay.
  void _onFocus() {
    if (_focusNode.hasFocus) {
      _showOverlay(context);
    } else {
      _hideOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        focusNode: _focusNode,
        controller: _textController,
        readOnly: true,
        autocorrect: false,
        enableSuggestions: false,
        textAlignVertical: TextAlignVertical.center,
        style: context.tt.bodyMedium,
        decoration: const InputDecoration().copyWith(
          hintText: 'Select',
          suffixIcon: const UnconstrainedBox(
            child: Icon(
              Icons.expand_more_rounded,
              size: 12,
            ),
          ),
        ),
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          } else {
            _focusNode.requestFocus();
          }
        },
      ),
    );
  }
}

class _Tile<T extends Selectable> extends StatelessWidget {
  const _Tile({
    required this.item,
    required this.isSelected,
    required this.includeRadioIndicator,
    required this.onTap,
    super.key,
  });

  final T item;
  final bool isSelected;

  final bool includeRadioIndicator;

  final void Function(T item, {required bool isSelected}) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(item, isSelected: isSelected),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: const AppStyle().insets.xs,
        ),
        child: Row(
          children: [
            if (includeRadioIndicator) ...[
              SizedBox.square(
                dimension: 20,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.col.primary,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
              HSpan(const AppStyle().insets.xs),
            ],
            Flexible(child: Text(item.value)),
          ],
        ),
      ),
    );
  }
}

class _Overlay<T extends Selectable> extends StatelessWidget {
  const _Overlay({
    required this.options,
    required this.onTap,
    required this.multiItems,
    required this.selectedItems,
    super.key,
  });

  final void Function(T item, {required bool isSelected}) onTap;
  final bool multiItems;

  final List<T> options;

  final List<T> selectedItems;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 150,
            // Make the suggestions list as wide as the input field.
            // The layout builder is the right solution, but in the
            // the tree there are intrinsic constraints.
            maxWidth: MediaQuery.sizeOf(context).width -
                4 * const AppStyle().insets.sm,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.col.primary,
                      width: .5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (ctx, index) {
                    final element = options.elementAt(index);
                    final isSelected = selectedItems.contains(element);
                    return _Tile(
                      item: element,
                      isSelected: isSelected,
                      includeRadioIndicator: multiItems,
                      onTap: onTap,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
