import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_counter_cubit/cubits/counter/counter_cubit.dart';
import 'package:my_counter_cubit/other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'My Counter Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('counter is ${state.counter}'),
                );
              },
            );
          } else if (state.counter == -1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return OtherPage();
              }),
            );
          }
        },
        builder: (context, state) {
          return Center(
            //this works without the BlocBuilder
            // child: Text(
            //   '${BlocProvider.of<CounterCubit>(
            //     context,
            //     listen: true,
            //   ).state.counter}',
            //   style: TextStyle(fontSize: 52.0),
            // ),
            child: Text(
              '${state.counter}',
              style: TextStyle(fontSize: 52.0),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // BlocProvider.of<CounterCubit>(context).increment();
              context.read<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              // BlocProvider.of<CounterCubit>(context).decrement();
              context.read<CounterCubit>().decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
