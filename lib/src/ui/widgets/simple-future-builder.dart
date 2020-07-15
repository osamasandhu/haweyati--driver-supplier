import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleFutureBuilder<T> extends FutureBuilder<T> {
  SimpleFutureBuilder({
    @required BuildContext context,

    @required Future<T> future,
    @required Widget noneChild,
    @required Widget noDataChild,
    @required Widget activeChild,
    @required Widget waitingChild,
    @required Widget unknownChild,

    @required Function(String) errorBuilder,
    @required Function(AsyncSnapshot<T>) builder,
  }): super(
    future: future,

    builder: (context, AsyncSnapshot<T> snapshot) {
      if (snapshot.hasData) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return noneChild;
          case ConnectionState.waiting:
            return waitingChild;
          case ConnectionState.active:
            return activeChild;
          case ConnectionState.done:
            if (snapshot.hasData)
              return builder(snapshot);
            else return noDataChild;
        }
      } else if (snapshot.hasError)
        return errorBuilder(snapshot.error.toString());

      return waitingChild;
    }
  );

  SimpleFutureBuilder.simpler({
    @required Future<T> future,
    @required BuildContext context,
    @required Function(AsyncSnapshot<T>) builder
  }): this(
    context: context,
    future: future,
    noneChild: Text("No Connection was found"),
    noDataChild: Text("No Data was found"),
    unknownChild: Text("Unknown Error Occurred"),
    activeChild: Center(child: CircularProgressIndicator()),
    waitingChild: Center(child: CircularProgressIndicator()),

    errorBuilder: (String error) => Center(child: Container(child:  Text(error),)),
    builder: builder,
  );

  SimpleFutureBuilder.simplerSliver({
    @required Future<T> future,
    @required BuildContext context,
    @required Function(AsyncSnapshot<T>) builder
  }): this(
    context: context,
    future: future,
    noneChild: SliverToBoxAdapter(child: Text("No Connection was found")),
    noDataChild: SliverToBoxAdapter(child: Text("No Data was found")),
    unknownChild: SliverToBoxAdapter(child: Text("Unknown Error Occurred")),
    activeChild: SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
    waitingChild: SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),

    errorBuilder: (String error) => SliverToBoxAdapter(child: Center(child: Container(child: Text(error)
    )
    )
    ),
    builder: builder,
  );
}