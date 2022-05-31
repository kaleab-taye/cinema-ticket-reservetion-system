import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/movie/movie.dart';

import '../models/movie.dart';

class AddUpdateMovie extends StatefulWidget {
  static const routeName = 'movieAddUpdate';
  final MovieArgument args;

  AddUpdateMovie({this.args});
  @override
  _AddUpdateMovieState createState() => _AddUpdateMovieState();
}

class _AddUpdateMovieState extends State<AddUpdateMovie> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _movie = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${widget.args.edit ? "Edit Movie Detail" : "Add New Movie"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.movie.imageUrl : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter image url';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Image Url'),
                  onSaved: (value) {
                    setState(() {
                      this._movie["imageUrl"] = value;
                    });
                  }),
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.movie.title : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter movie title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Movie Title'),
                  onSaved: (value) {
                    this._movie["title"] = value;
                  }),
              TextFormField(
                  initialValue: widget.args.edit
                      ? widget.args.movie.casts.toString()
                      : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the casts';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Casts'),
                  onSaved: (value) {
                    setState(() {
                      this._movie["casts"] = int.parse(value);
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.movie.description : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter movie description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Movie Description'),
                  onSaved: (value) {
                    setState(() {
                      this._movie["description"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final MovieEvent event = widget.args.edit
                          ? MovieUpdate(
                              Movie(
                                id: widget.args.movie.id,
                                imageUrl: this._movie["imageUrl"],
                                title: this._movie["title"],
                                casts: this._movie["casts"],
                                description: this._movie["description"],
                              ),
                            )
                          : MovieCreate(
                              Movie(
                                imageUrl: this._movie["imageUrl"],
                                title: this._movie["title"],
                                casts: this._movie["casts"],
                                description: this._movie["description"],
                              ),
                            );
                      BlocProvider.of<MovieBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MoviesList.routeName, (route) => false);
                    }
                  },
                  label: Text('SAVE'),
                  icon: Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
