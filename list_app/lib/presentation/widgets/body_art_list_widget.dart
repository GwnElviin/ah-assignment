import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_app/bloc/art_bloc.dart';
import 'package:list_app/presentation/widgets/art_list_widget.dart';
import 'package:list_app/presentation/widgets/error_widget.dart';

class BodyArtListWidget extends StatelessWidget {
  const BodyArtListWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArtBloc, AllArtState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Loaded successfully"),
          ));
        } else if (state.status.isError) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            // If something went wrong give the user the option to retry
            SnackBar(
                content: InkWell(
              onTap: () {
                context.read<ArtBloc>().add(
                      GetArtObjectsForList(),
                    );
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Something went wrong, Tap to try again"),
              ),
            )),
            //Text("something went wrong"),
          );
        } else if (state.status.isLoading) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Retrieving data"),
          ));
        }
      },
      builder: (context, state) {
        if (state.status != state.status.isSuccess) {
          return ArtListWidget(
            title: title,
            artListObjects: state.artObjects,
          );
        } else if (state.status.isError) {
          return const ErrorResultWidget();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
