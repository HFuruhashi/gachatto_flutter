import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart'; // ステップ2で作成したモデルをインポート

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MyApp(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Provider Example")),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context, counter, child) => Text('${counter.count}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CounterModel>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

// import 'dart:io';
// import 'database_helper.dart';  // データベースヘルパーをインポート
// import 'package:file_picker/file_picker.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primaryColor: Colors.pink[100],           // プライマリカラー
//         colorScheme: ThemeData().colorScheme.copyWith(
//           primary: Colors.pink[100],
//           secondary: Colors.pinkAccent[100],     // セカンダリカラー（旧アクセントカラー）
//         ),
//       ),
//       home: SignInScreen(),
//     );
//   }
// }
//
// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final dbHelper = DatabaseHelper.instance;
//   String _username = '';
//   String _password = '';
//   String? _errorMessage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('サインイン')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(_errorMessage ?? "", style: TextStyle(color: Colors.red)),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'ユーザー名'),
//                 onSaved: (value) {
//                   _username = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'パスワード'),
//                 obscureText: true,
//                 onSaved: (value) {
//                   _password = value!;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 child: Text('サインイン'),
//                 onPressed: _signIn,
//               ),
//               SizedBox(height: 15),
//               InkWell(
//                 child: Text('アカウントを持っていない？サインアップ'),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignUpScreen()),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   _signIn() async {
//     _formKey.currentState!.save();
//     int? userId = await dbHelper.validateUser(_username, _password);
//     if (userId != null && userId > 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
//       );
//     } else {
//       setState(() {
//         _errorMessage = "ユーザー名またはパスワードが間違っています";
//       });
//     }
//   }
// }
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final dbHelper = DatabaseHelper.instance;
//   String _username = '';
//   String _password = '';
//   String? _errorMessage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('サインアップ')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(_errorMessage ?? "", style: TextStyle(color: Colors.red)),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'ユーザー名'),
//                   onSaved: (value) {
//                     _username = value!;
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'ユーザー名を入力してください';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'パスワード'),
//                   obscureText: true,
//                   onSaved: (value) {
//                     _password = value!;
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'パスワードを入力してください';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   child: Text('サインアップ'),
//                   onPressed: _signUp,
//                 ),
//                 SizedBox(height: 15),
//                 InkWell(
//                   child: Text('すでにアカウントを持っていますか？サインイン'),
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => SignInScreen()),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _signUp() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//
//       int? userId = await dbHelper.insertUser(_username, _password);
//       if (userId != null && userId > 0) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
//         );
//       } else {
//         setState(() {
//           _errorMessage = "ユーザーの作成に失敗しました";
//         });
//       }
//     }
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   final int userId; // ユーザーIDを保存するための変数
//
//   HomeScreen({required this.userId}); // コンストラクタでユーザーIDを受け取る
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   late List<Widget> _children;
//
//   @override
//   void initState() {
//     super.initState();
//     _children = [
//       FeedTab(),
//       ListTab(),
//       UploadTab(),
//       ChatTab(),
//       AccountTab(userId: widget.userId) // widget.userIdを使用して親ウィジェットからのユーザーIDにアクセス
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _children[_currentIndex],
//       appBar: AppBar(
//         title: Text('Gachatto'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: CustomSearchDelegate(),  // TODO: 検索デリゲートの実装
//               );
//             },
//           )
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: onTabTapped,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
//           BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'List'),
//           BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Upload'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
//         ],
//         selectedItemColor: Colors.pinkAccent[100],   // 選択されているアイテムの色
//         unselectedItemColor: Colors.pink[100], // 選択されていないアイテムの色
//       ),
//     );
//   }
//
//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }
//
// class CustomSearchDelegate extends SearchDelegate<String?> {
//   final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // 右側に表示されるアクションのリスト (例: クリアボタン)
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           showSuggestions(context);
//         },
//       )
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     // 左側に表示されるウィジェット (例: 戻るボタン)
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // この部分ではデータベースから検索結果を取得して表示することが考えられます。
//     // 今回はサンプルとして、クエリそのものを表示します。
//     return Center(
//       child: Text(query),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // 検索クエリに基づいてデータベースからサジェスチョンを取得する部分を実装します。
//     // TODO: _databaseHelperから適切なメソッドを呼び出して、クエリに基づいたサジェスチョンを取得する。
//     // 以下は静的なサジェスチョンのサンプルです。
//     final suggestions = ["Sample 1", "Sample 2", "Sample 3"]; // この部分をデータベースからの取得に置き換えることが考えられます。
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(suggestions[index]),
//           onTap: () {
//             query = suggestions[index];
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
//
// class FeedTab extends StatefulWidget {
//   @override
//   _FeedTabState createState() => _FeedTabState();
// }
//
// class _FeedTabState extends State<FeedTab> {
//   bool isLiked = false;
//   bool isDisliked = false;
//   final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
//   String? _workTitle;  // 作品タイトル
//   String? _authorName; // 作者名
//
//   @override
//   void initState() {
//     super.initState();
//     _loadFeedData();
//   }
//
//   _loadFeedData() async {
//     // ここではデモのため、最初の作品の情報を取得しています。
//     // 実際のアプリでは、フィードに表示する作品のリストや条件に合わせてデータを取得します。
//     Map<String, dynamic>? work = await _databaseHelper.getWork(1);
//     if (work != null) {
//       setState(() {
//         _workTitle = work['title'];
//         _authorName = work['authorName']; // カラム名は適切に変更してください
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 150,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.pink[100],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Icon(Icons.music_note, size: 100, color: Colors.pinkAccent[100]),
//                 ),
//                 SizedBox(height: 20),
//                 Text(_workTitle ?? '作品タイトル', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 Text(_authorName ?? '作者名'),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           isLiked = !isLiked;
//                           if (isDisliked) {
//                             isDisliked = !isDisliked;
//                           }
//                         });
//                         // TODO: いいね/いいね解除の状態をデータベースに反映する処理を追加
//                       },
//                       icon: Icon(
//                         isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
//                         color: Colors.pinkAccent[100],
//                       ),
//                       iconSize: 30,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           isDisliked = !isDisliked;
//                           if (isLiked) {
//                             isLiked = !isLiked;
//                           }
//                         });
//                         // TODO: いいね/いいね解除の状態をデータベースに反映する処理を追加
//                       },
//                       icon: Icon(
//                         isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
//                         color: Colors.pinkAccent[100],
//                       ),
//                       iconSize: 30,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 40,
//             right: 20,
//             child: IconButton(
//               icon: Icon(Icons.notifications_none, color: Colors.pinkAccent[100]),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => NotificationsPage()),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class NotificationsPage extends StatefulWidget {
//   @override
//   _NotificationsPageState createState() => _NotificationsPageState();
// }
//
// class _NotificationsPageState extends State<NotificationsPage> {
//   late Future<List<Map<String, dynamic>>> notifications;
//
//   @override
//   void initState() {
//     super.initState();
//     notifications = DatabaseHelper.instance.getNotifications();  // DatabaseHelperから通知情報を取得
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notification'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: notifications,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(title: Text(snapshot.data![index]['message'].toString()));  // 'message'はデータベースの通知テーブルのカラム名として仮定
//                 },
//               );
//             } else {
//               return Center(child: Text('No notifications available.'));
//             }
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
//
// class DetailPage extends StatefulWidget {
//   final int index;
//
//   DetailPage({required this.index});
//
//   @override
//   _DetailPageState createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   // LikeボタンとDislikeボタンの状態を持つ変数を追加
//   bool isLiked = false;
//   bool isDisliked = false;
//   Map<String, dynamic>? workDetails;
//   final dbHelper = DatabaseHelper.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchWorkDetails();
//   }
//
//   _fetchWorkDetails() async {
//     final details = await dbHelper.getWork(widget.index);
//     setState(() {
//       workDetails = details;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Post Detail'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.pink[100],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(Icons.music_note, size: 100, color: Colors.pinkAccent[100]),
//             ),
//             SizedBox(height: 20),
//             Text('作品タイトル: ${workDetails?['title'] ?? 'Loading...'}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             Text('作者名: ${workDetails?['author'] ?? 'Loading...'}'),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isLiked = !isLiked;
//                       if (isDisliked) {
//                         isDisliked = !isDisliked;
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
//                     color: Colors.pinkAccent[100],
//                   ),
//                   iconSize: 30,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isDisliked = !isDisliked;
//                       if (isLiked) {
//                         isLiked = !isLiked;
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
//                     color: Colors.pinkAccent[100],
//                   ),
//                   iconSize: 30,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Listのタイプを示すEnum
// enum ListType {
//   liked,
//   disliked,
// }
//
// class ListDetailPage extends StatefulWidget {
//   final String title;
//   final List<Map<String, dynamic>> works; // 追加
//
//   ListDetailPage({required this.title, required this.works}); // パラメータを追加
//
//   @override
//   _ListDetailPageState createState() => _ListDetailPageState();
// }
//
// class _ListDetailPageState extends State<ListDetailPage> {
//   List<Map<String, dynamic>>? works;
//   final dbHelper = DatabaseHelper.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchWorks();
//   }
//
//   _fetchWorks() async {
//     // TODO: データベースから「いいね」または「いいねしない」を押した作品のリストを取得するロジックを実装します。
//     // 以下は仮のロジックです。
//     List<Map<String, dynamic>>? fetchedWorks;
//     if (widget.title == "Liked") {
//       fetchedWorks = await dbHelper.getLikedWorks();
//     } else if (widget.title == "Disliked") {
//       fetchedWorks = await dbHelper.getDislikedWorks();
//     }
//
//     setState(() {
//       works = fetchedWorks;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10.0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//           childAspectRatio: 0.7,
//         ),
//         itemCount: works?.length ?? 0,
//         itemBuilder: (context, index) {
//           final work = works![index];
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FeedDetailPage(index: index, title: work['title']),  // title を作品のタイトルに設定
//                 ),
//               );
//             },
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Card(
//                   color: Colors.pink[100],
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Icon(Icons.music_note, color: Colors.pinkAccent[100], size: 50.0),
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(work['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0), overflow: TextOverflow.ellipsis),
//                 SizedBox(height: 2),
//                 Text(work['author'], style: TextStyle(fontSize: 10.0), overflow: TextOverflow.ellipsis),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class FeedDetailPage extends StatefulWidget {
//   final int index;
//   final String title;
//
//   FeedDetailPage({required this.index, required this.title});
//
//   @override
//   _FeedDetailPageState createState() => _FeedDetailPageState();
// }
//
// class _FeedDetailPageState extends State<FeedDetailPage> {
//   bool isLiked = false;
//   bool isDisliked = false;
//   Map<String, dynamic>? workDetail;
//
//   final dbHelper = DatabaseHelper.instance;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Get work details from the database
//     _getWorkDetails();
//
//     // 高評価リストから開いた場合は高評価状態にする
//     if (widget.title == "高評価リスト") {
//       isLiked = true;
//     }
//     // 低評価リストから開いた場合は低評価状態にする
//     else if (widget.title == "低評価リスト") {
//       isDisliked = true;
//     }
//   }
//
//   _getWorkDetails() async {
//     var details = await dbHelper.getWork(widget.index);
//     setState(() {
//       workDetail = details;
//     });
//   }
//
//   void _showCollabRequestModal() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('コラボリクエスト'),
//           content: Text('本当にコラボしますか？'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('いいえ'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('はい'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChatScreen(authorName: "Author ${widget.index}", workTitle: "Post ${widget.index}"),
//                   ),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feed Detail'),
//         backgroundColor: Colors.pink[100],
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_none),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationsPage()),
//               );
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.pink[100],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(Icons.music_note, size: 100, color: Colors.pinkAccent[100]),
//             ),
//             SizedBox(height: 20),
//             Text(workDetail?['title'] ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             Text(workDetail?['authorName'] ?? ''),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isLiked = !isLiked;
//                       if (isDisliked) {
//                         isDisliked = !isDisliked;
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
//                     color: Colors.pinkAccent[100],
//                   ),
//                   iconSize: 30,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isDisliked = !isDisliked;
//                       if (isLiked) {
//                         isLiked = !isLiked;
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
//                     color: Colors.pinkAccent[100],
//                   ),
//                   iconSize: 30,
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             if (widget.title != "低評価リスト")
//               ElevatedButton(
//                 child: Text('コラボリクエスト'),
//                 onPressed: _showCollabRequestModal,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ChatScreenの修正
// class ChatScreen extends StatelessWidget {
//   final String authorName;  // 作者名
//   final String workTitle;   // 作品名
//
//   ChatScreen({required this.authorName, required this.workTitle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('チャット'),
//         backgroundColor: Colors.pinkAccent[100],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               '$workTitleにコラボリクエストを送信しました',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // 他のチャットの内容やUIをここに追加します
//         ],
//       ),
//     );
//   }
// }
//
// class ListTab extends StatefulWidget {
//   @override
//   _ListTabState createState() => _ListTabState();
// }
//
// class _ListTabState extends State<ListTab> {
//   final dbHelper = DatabaseHelper.instance;  // DatabaseHelperのインスタンスを作成
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.count(
//         crossAxisCount: 2, // ２列のグリッド
//         children: [
//           GestureDetector(
//             onTap: () async {
//               // 高評価された作品のリストをデータベースから取得する処理を追加
//               var likedWorks = await dbHelper.getLikedWorks();
//               Navigator.push(context, MaterialPageRoute(builder: (context) => ListDetailPage(title: '高評価リスト', works: likedWorks)));
//             },
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Icon(Icons.thumb_up, size: 50, color: Colors.pinkAccent[100]),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text('高評価リスト'),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () async {
//               // 低評価された作品のリストをデータベースから取得する処理を追加
//               var dislikedWorks = await dbHelper.getDislikedWorks();
//               Navigator.push(context, MaterialPageRoute(builder: (context) => ListDetailPage(title: '低評価リスト', works: dislikedWorks)));
//             },
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Icon(Icons.thumb_down, size: 50, color: Colors.pinkAccent[100]),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text('低評価リスト'),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               // 新しいリストをデータベースに追加する処理を追加 (具体的な処理は詳細に応じて変更が必要)
//               // dbHelper.addNewList();
//             },
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Icon(Icons.add, size: 50, color: Colors.pinkAccent[100]),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text('リストを追加'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class UploadTab extends StatefulWidget {
//   @override
//   _UploadTabState createState() => _UploadTabState();
// }
//
// class _UploadTabState extends State<UploadTab> {
//   final _formKey = GlobalKey<FormState>();
//   String _workName = '';
//   String _collabWorkName = '';
//   String? _fileType;
//   File? _uploadedFile;
//
//   final dbHelper = DatabaseHelper.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: '作品名'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return '作品名を入力してください';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _workName = value!;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'コラボする作品'),
//                 onSaved: (value) {
//                   _collabWorkName = value!;
//                 },
//               ),
//               SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 items: [
//                   DropdownMenuItem(value: '音声ファイル', child: Text('音声ファイル')),
//                   DropdownMenuItem(value: '画像ファイル', child: Text('画像ファイル')),
//                   DropdownMenuItem(value: '動画ファイル', child: Text('動画ファイル')),
//                 ],
//                 hint: Text('作品のファイルタイプを選択'),
//                 onChanged: (value) {
//                   setState(() {
//                     _fileType = value;
//                   });
//                 },
//                 onSaved: (value) {
//                   _fileType = value;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//                   if (result != null) {
//                     _uploadedFile = File(result.files.single.path!);
//                     print('File path: ${_uploadedFile!.path}');
//                   } else {
//                     print('User canceled file picker');
//                   }
//                 },
//                 child: Text('ファイルをアップロード'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//
//                     final Map<String, dynamic> row = {
//                       DatabaseHelper.columnWorkName: _workName,
//                       DatabaseHelper.columnFileType: _fileType ?? ''
//                     };
//                     final id = await dbHelper.insert(row, DatabaseHelper.tableUpload);
//
//                     print('作品名: $_workName');
//                     print('コラボする作品: $_collabWorkName');
//                     print('ファイルタイプ: $_fileType');
//                     print('inserted row id: $id');
//                   }
//                 },
//                 child: Text('投稿'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChatTab extends StatefulWidget {
//   @override
//   _ChatTabState createState() => _ChatTabState();
// }
//
// class _ChatTabState extends State<ChatTab> {
//   final dbHelper = DatabaseHelper.instance;
//   Future<List<Map<String, dynamic>>>? _chatItemsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _chatItemsFuture = _fetchChatItems();
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchChatItems() async {
//     return await dbHelper.getAllChats();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _chatItemsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             return Center(child: Text('エラーが発生しました'));
//           }
//
//           final chatItems = snapshot.data!;
//           return GridView.builder(
//             padding: EdgeInsets.all(16.0),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 16.0,
//               mainAxisSpacing: 16.0,
//             ),
//             itemCount: chatItems.length,
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatDetailScreen(chatIndex: index),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Flexible(
//                       child: AspectRatio(
//                         aspectRatio: 1,
//                         child: Card(
//                           color: Colors.pink[100],
//                           child: Icon(
//                             Icons.person,
//                             color: Colors.pinkAccent[100],
//                             size: 50,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       chatItems[index]['name'],  // データベースのカラム名を適切に変更してください
//                       style: TextStyle(fontSize: 12),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());  // データを待っている間に表示するローディングインジケータ
//         }
//       },
//     );
//   }
// }
//
// void _showBlockDialog(BuildContext context, int index) {
//   final dbHelper = DatabaseHelper.instance;
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('ブロック'),
//         content: Text('Chat $index をブロックしますか？'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('キャンセル'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text('ブロック'),
//             onPressed: () async {
//               await dbHelper.blockChat(index);
//               print('Blocked Chat $index');
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
//
// class ChatDetailScreen extends StatefulWidget {
//   final int chatIndex;
//
//   ChatDetailScreen({required this.chatIndex});
//
//   @override
//   _ChatDetailScreenState createState() => _ChatDetailScreenState();
// }
//
// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   List<String> messages = [];
//   TextEditingController _controller = TextEditingController();
//   final dbHelper = DatabaseHelper.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }
//
//   _loadMessages() async {
//     List<Map<String, dynamic>> result = await dbHelper.getMessages(widget.chatIndex);
//     setState(() {
//       messages = result.map((e) => e['message'] as String).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat ${widget.chatIndex}'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(messages[index]),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Enter your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () async {
//                     if (_controller.text.isNotEmpty) {
//                       await dbHelper.saveMessage(widget.chatIndex, _controller.text);
//                       setState(() {
//                         messages.add(_controller.text);
//                         _controller.clear();
//                       });
//                     }
//                   },
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class AccountTab extends StatefulWidget {
//   final int userId;
//
//   AccountTab({required this.userId});
//
//   @override
//   _AccountTabState createState() => _AccountTabState();
// }
//
// class _AccountTabState extends State<AccountTab> {
//   late Future<int> totalUploads;
//   late Future<int> totalLikes;
//   late Future<List<Map<String, dynamic>>> uploadedWorks;
//   late Future<Map<String, dynamic>?> userInfo;
//
//   final dbHelper = DatabaseHelper.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     int loggedInUserId = widget.userId;  // ここで渡されたuserIdを使用します
//
//     totalUploads = dbHelper.getUserTotalUploads(loggedInUserId);
//     totalLikes = dbHelper.getUserTotalLikes(loggedInUserId);
//     uploadedWorks = dbHelper.getUserUploads(loggedInUserId);
//     userInfo = dbHelper.getUser(loggedInUserId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<Map<String, dynamic>?>(
//         future: userInfo,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data == null) {
//             return CircularProgressIndicator();
//           }
//
//           String username = snapshot.data!['username'].toString();
//
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.pink[100],
//                       radius: 50,
//                       child: Icon(Icons.person, size: 50, color: Colors.pinkAccent[100]),
//                     ),
//                     SizedBox(height: 10),
//                     Text(username, style: TextStyle(fontSize: 20)),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         FutureBuilder<int>(
//                           future: totalUploads,
//                           builder: (context, snapshot) {
//                             return Column(
//                               children: [
//                                 Text('Total Uploads'),
//                                 Text(snapshot.data?.toString() ?? "0"),
//                               ],
//                             );
//                           },
//                         ),
//                         FutureBuilder<int>(
//                           future: totalLikes,
//                           builder: (context, snapshot) {
//                             return Column(
//                               children: [
//                                 Text('Total Likes'),
//                                 Text(snapshot.data?.toString() ?? "0"),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: FutureBuilder<List<Map<String, dynamic>>>(
//                   future: uploadedWorks,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//                       return GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 10,
//                         ),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           final work = snapshot.data![index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AccountDetailScreen(itemIndex: index),
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: AspectRatio(
//                                     aspectRatio: 1.0,
//                                     child: Card(
//                                       color: Colors.pink[100],
//                                       child: Center(
//                                         child: Icon(Icons.music_note, color: Colors.pinkAccent[100]),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 3),
//                                 FittedBox(child: Text(work['workName'].toString())),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     } else {
//                       return Text("新しい作品を投稿しましょう！");
//                     }
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class AccountDetailScreen extends StatefulWidget {
//   final int itemIndex;
//
//   AccountDetailScreen({required this.itemIndex});
//
//   @override
//   _AccountDetailScreenState createState() => _AccountDetailScreenState();
// }
//
// class _AccountDetailScreenState extends State<AccountDetailScreen> {
//   Map<String, dynamic>? workDetails;
//   String? authorName;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchWorkDetails();
//   }
//
//   _fetchWorkDetails() async {
//     final data = await DatabaseHelper.instance.getWork(widget.itemIndex);
//     if (data != null) {
//       final authorData = await DatabaseHelper.instance.getUser(data['userId']);
//       setState(() {
//         workDetails = data;
//         authorName = authorData?['username'];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(workDetails != null ? workDetails!['workName'] : 'Loading...'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.pink[100],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(Icons.music_note, size: 100, color: Colors.pinkAccent[100]),
//             ),
//             SizedBox(height: 20),
//             Text(workDetails != null ? workDetails!['workName'] : 'Loading...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             Text(authorName ?? 'Loading...'), // 修正部分: データベースからの作者名を表示
//           ],
//         ),
//       ),
//     );
//   }
// }

class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // ウィジェットに変更を通知
  }
}
