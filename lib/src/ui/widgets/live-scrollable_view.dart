import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LiveScrollableView<T> extends StatefulWidget {
  final String title, subtitle;
  final Future<List<T>> Function() loader;
  final Widget Function(BuildContext context, T data) builder;

  LiveScrollableView({
    @required this.title,
    @required this.loader,
    @required this.builder,
    @required this.subtitle
  }): assert(title != null),
      assert(loader != null),
      assert(builder != null),
      assert(subtitle != null);

  @override
  _LiveScrollableViewState<T> createState() => _LiveScrollableViewState<T>();
}

class _LiveScrollableViewState<T> extends State<LiveScrollableView<T>> {
  Future<List<T>> _future;
  bool _allowRefresh = false;

  @override
  void initState() {
    super.initState();
    _future = widget.loader()..then((value) {
      if (!_allowRefresh) setState(() => _allowRefresh = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      if (_allowRefresh)
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            _future = widget.loader();
            await _future;

            setState(() {});
          },
        ),

      SliverPadding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
        sliver: SliverToBoxAdapter(child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        )),
      ),

      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        sliver: SliverToBoxAdapter(child: Text(widget.subtitle, textAlign: TextAlign.center)),
      ),

      FutureBuilder<List<T>>(
        future: _future,
        builder: (context, AsyncSnapshot<List<T>> snapshot) {
          if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Text(snapshot.error.toString()),
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return SliverToBoxAdapter(child: Text('No Data was found'));
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (_allowRefresh) {
                return SliverList(delegate: SliverChildBuilderDelegate(
                  (context, i) => widget.builder(context, snapshot.data[i]),
                  childCount: snapshot.data.length
                ));
              } else {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: CircularProgressIndicator(strokeWidth: 2)
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Text('Locating Services'),
                      )
                    ],
                  ),
                );
              }
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                return SliverList(delegate: SliverChildBuilderDelegate(
                  (context, i) => widget.builder(context, snapshot.data[i]),
                  childCount: snapshot.data.length
                ));
              }
          }

          return SliverToBoxAdapter(
            child: Text('No Data was found'),
          );
        },
      )
    ]);
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class LiveScrollableView extends StatefulWidget {
//   final Widget child;
//
//   final String title;
//   final String subtitle;
//
//   final Function onRefresh;
//
//   LiveScrollableView({
//     this.child,
//     this.title,
//     this.subtitle,
//     this.onRefresh,
//   });
//
//   @override
//   _LiveScrollableViewState createState() => _LiveScrollableViewState();
// }

// class _LiveScrollableViewState extends State<LiveScrollableView> {
//   bool _allowRefresh = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(slivers: [
//       if (_allowRefresh)
//         CupertinoSliverRefreshControl(
//           onRefresh: widget.onRefresh,
//         ),
//
//       SliverPadding(
//         padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
//         sliver: SliverToBoxAdapter(child: Text(
//             widget.title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold
//             )
//         )),
//       ),
//
//       SliverPadding(
//         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//         sliver: SliverToBoxAdapter(child: Text(widget.subtitle, textAlign: TextAlign.center)),
//       ),
//       SliverPadding(padding: const EdgeInsets.only(top: 40), sliver: widget.child)
//     ]);
//   }
// }
