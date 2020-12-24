import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Trip.dart';
import 'package:ninja_trips/screens/details.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<Widget> _tripTiles = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    // Only run this function when build started running
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      _addTrips();
    });
  }

  void _addTrips() {
    // get data from db
    List<Trip> _trips = [
      Trip(title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.png'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'city.png'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.png'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.png'),
    ];

    // This future is used for intentionally delaying animation of the each newly
    // added listTile. By passing Future.Delay() on then cause it wait until duration
    // completes before adding new listTile,
    Future _future = Future(() {});

    _trips.forEach((Trip trip) {
      _future = _future.then((_) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          _tripTiles.add(_buildTile(trip));
          // We need to explicitely tell flutter that we added a new tile
          // so that animation can keep track of every new listTile.
          // as a index to InsertItem:
          // lets say first listTile added length will be 1 so, index will be 0

          _listKey.currentState.insertItem(
            _tripTiles.length - 1,
            duration: Duration(milliseconds: 500),
          );
        });
      });
    });
  }

  Widget _buildTile(Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(trip: trip)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${trip.nights} nights',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text(trip.title, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'image-tag-${trip.img}',
          child: Image.asset(
            'images/${trip.img}',
            height: 50.0,
          ),
        ),
      ),
      trailing: Text('₹${trip.price}'),
    );
  }

  // Offset(1,0) for list tile means its positin in x asis is completely moved by its width pixels
  // Offset(0,0) means its origin position
  Tween<Offset> _offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        initialItemCount: _tripTiles.length,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: animation.drive(_offset),
            child: _tripTiles[index],
          );
        });
  }
}
