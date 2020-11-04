import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LiveScrollableView<T> extends StatefulWidget {
  final Widget header,noDataChild;
  final String title, subtitle, loadingMessage, noDataMessage;
  final Future<List<T>> Function() loader;
  final Widget Function(BuildContext context, T data) builder;

  LiveScrollableViewState _state;

  LiveScrollableView({
    Key key,
    this.title,
    this.header,
    this.subtitle,
    this.noDataChild,
    this.loadingMessage,
    this.noDataMessage,
    @required this.loader,
    @required this.builder
  }): assert(loader != null),
        assert(builder != null) , super(key: key);

  Future reload() {
    return _state.loadDataAgain();
  }

  @override
  LiveScrollableViewState<T> createState() {
    _state = LiveScrollableViewState<T>();
    return _state;
  }
}

class LiveScrollableViewState<T> extends State<LiveScrollableView<T>> {
  var _scrollToTop = false;
  Future<List<T>> _future;
  bool _allowRefresh = false;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _future = widget.loader()..then((value) {
      if (!_allowRefresh) setState(() => _allowRefresh = true);
    })..catchError((error) {
      setState(() => _allowRefresh = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _scrollToTop ? FloatingActionButton(
          elevation: 8,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey.shade600,
          child: Icon(Icons.arrow_upward),
          onPressed: () async {
            setState(() => _scrollToTop = false);
            await _controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
          },
        ) : null,
      body: NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            if (notification.metrics.pixels > 500) {
              if (!_scrollToTop) setState(() => _scrollToTop = true);
            } else {
              if (_scrollToTop) setState(() => _scrollToTop = false);
            }

            return true;
          },
        child: CustomScrollView(
          controller: _controller,
            slivers: [
          if (_allowRefresh)
            CupertinoSliverRefreshControl(

              onRefresh: () => loadDataAgain(),
            ),

          if (widget.header != null)
            SliverToBoxAdapter(child: widget.header),

          if (widget.title != null)
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

          if (widget.subtitle != null)
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 250),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 35,
                                height: 35,
                                child: CircularProgressIndicator(strokeWidth: 2)
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text(widget.loadingMessage ?? 'Locating Services'),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    if (snapshot.data is List) {
                      if ((snapshot.data as List).isEmpty)
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                            child: widget.noDataChild ?? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(child: Icon(Icons.search,size: 60,) ),
                                Center(child: Text(widget.noDataMessage ?? "No Results",style: TextStyle(color: Colors.grey,fontSize: 22),)),
                              ],
                            ),
                          ),
                        );
                    }
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
        ]),
      ),
    );
  }

  loadDataAgain() async {
    _future = widget.loader();
    await _future;

    setState(() {});
  }
}
