import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/constants/enums.dart';
import 'package:todo/logic/bloc/filtered_todos/filtered_todos_bloc.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: Theme.of(context).colorScheme.secondary);
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (_, state) {
        final button = _Button(
          onSelected: (filter) {
            BlocProvider.of<FilteredTodosBloc>(context)
                .add(FilterUpdated(filter));
          },
          activeFilter: state is FilteredTodosLoadSuccess
              ? state.activeFilter
              : VisibilityFilter.desc,
          activeStyle: activeStyle,
          defaultStyle: defaultStyle,
        );
        return button;
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter>? onSelected;
  final VisibilityFilter? activeFilter;
  final TextStyle? activeStyle;
  final TextStyle? defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.desc,
          child: Text(
            'DESC Order',
            style: activeFilter == VisibilityFilter.desc
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.asc,
          child: Text(
            'ASC Order',
            style: activeFilter == VisibilityFilter.asc
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
