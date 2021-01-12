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
    String noDataMessage,
    @required Function(String) errorBuilder,
    @required Function(T) builder,
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
              if (snapshot.hasData) {
                if (snapshot.data is List) {
                  if ((snapshot.data as List).isEmpty)
                    return noDataChild ?? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(child: Icon(Icons.search,size: 60,) ),
                        Center(child: Text(noDataMessage ?? "No Results",style: TextStyle(color: Colors.grey,fontSize: 22),)),
                      ],
                    );
                }
                return builder(snapshot.data);
              } else return noDataChild;
          }
        } else if (snapshot.hasError)
          //   print(snapshot.error);
          return errorBuilder(snapshot.error.toString());

        return waitingChild;
      }
  );

  SimpleFutureBuilder.simpler({
    @required Future<T> future,
    @required BuildContext context,
    Widget noDataChild,
    String noDataMessage,
    @required Function(T) builder
  }): this(
    context: context,
    future: future,
    noDataMessage : noDataMessage,
    noneChild: Text("No Connection was found"),
    noDataChild: noDataChild ?? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(child: Icon(Icons.search,size: 60,) ),
        Center(child: Text(noDataMessage ?? "No Results",style: TextStyle(color: Colors.grey,fontSize: 22),)),
      ],
    ),
    unknownChild: Text("Unknown Error Occurred"),
    activeChild: Center(child: CircularProgressIndicator()),
    waitingChild: Center(child: CircularProgressIndicator()),
    errorBuilder: (String error) => Center(child: Container(child:  Text(error),)),
    builder: builder,
  );

  SimpleFutureBuilder.simplerSliver({
    @required Future<T> future,
    @required BuildContext context,
    String noDataMessage,
    @required Function(T) builder
  }): this(
    context: context,
    future: future,
    noDataMessage : noDataMessage,
    noneChild: SliverToBoxAdapter(child: Text("No Connection was found")),
    noDataChild: SliverToBoxAdapter(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(child: Icon(Icons.search,size: 60,color: Color(0xff313f53),) ),
        Center(child: Text(noDataMessage ?? "No Results",style: TextStyle(color: Colors.grey,fontSize: 22),)),
      ],
    )),
    unknownChild: SliverToBoxAdapter(child: Text("Unknown Error Occurred")),
    activeChild: SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
    waitingChild: SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),

    errorBuilder: (String error) => SliverToBoxAdapter(child: Center(child: Container(child: Text(error)))),
    builder: builder,
  );
}