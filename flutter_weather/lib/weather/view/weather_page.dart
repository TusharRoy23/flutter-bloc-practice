import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/search/search.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/theme/cubit/theme_cubit.dart';
import 'package:flutter_weather/weather/cubit/weather_cubit.dart';
import 'package:flutter_weather/weather/widgets/widgets.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(
                  context.read<WeatherCubit>(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child:
            BlocConsumer<WeatherCubit, WeatherState>(builder: (context, state) {
          switch (state.status) {
            case WeatherStatus.initial:
              return const WeatherEmpty();
            case WeatherStatus.loading:
              return const WeatherLoading();
            case WeatherStatus.success:
              return WeatherPopulated(
                weather: state.weatherCls,
                units: state.temperatureUnits,
                onRefresh: () {
                  return context.read<WeatherCubit>().refreshWeather();
                },
              );
            case WeatherStatus.failure:
            default:
              return const WeatherError();
          }
        }, listener: (context, state) {
          if (state.status.isSuccess) {
            context.read<ThemeCubit>().updateTheme(state.weatherCls);
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
