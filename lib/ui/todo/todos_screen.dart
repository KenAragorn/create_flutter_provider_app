import 'package:flutter/material.dart';
import 'package:create_flutter_provider_app/app_localizations.dart';
import 'package:create_flutter_provider_app/models/todo_model.dart';
import 'package:create_flutter_provider_app/models/user_model.dart';
import 'package:create_flutter_provider_app/providers/auth_provider.dart';
import 'package:create_flutter_provider_app/routes.dart';
import 'package:create_flutter_provider_app/services/firestore_database.dart';
import 'package:create_flutter_provider_app/ui/todo/empty_content.dart';
import 'package:create_flutter_provider_app/ui/todo/todos_extra_actions.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: StreamBuilder(
            stream: authProvider.user,
            builder: (context, snapshot) {
              final UserModel? user = snapshot.data as UserModel?;
              return Text(user != null
                  ? user.email! +
                      " - " +
                      AppLocalizations.of(context).translate("homeAppBarTitle")
                  : AppLocalizations.of(context).translate("homeAppBarTitle"));
            }),
        actions: <Widget>[
          StreamBuilder(
              stream: firestoreDatabase.todosStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TodoModel> todos = snapshot.data as List<TodoModel>;
                  return Visibility(
                      visible: todos.isNotEmpty ? true : false,
                      child: TodosExtraActions());
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.setting);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.create_edit_todo,
          );
        },
      ),
      body: WillPopScope(
          onWillPop: () async => false, child: _buildBodySection(context)),
    );
  }

  Widget _buildBodySection(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
        stream: firestoreDatabase.todosStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TodoModel> todos = snapshot.data as List<TodoModel>;
            if (todos.isNotEmpty) {
              return ListView.separated(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        AppLocalizations.of(context)
                            .translate("todosDismissibleMsgTxt"),
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      )),
                    ),
                    key: Key(todos[index].id),
                    onDismissed: (direction) {
                      firestoreDatabase.deleteTodo(todos[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //_scaffoldKey.currentState!.showSnackBar(SnackBar(

                        backgroundColor: Theme.of(context).appBarTheme.color,
                        content: Text(
                          AppLocalizations.of(context)
                                  .translate("todosSnackBarContent") +
                              todos[index].task,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor),
                        ),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: AppLocalizations.of(context)
                              .translate("todosSnackBarActionLbl"),
                          textColor: Theme.of(context).canvasColor,
                          onPressed: () {
                            firestoreDatabase.setTodo(todos[index]);
                          },
                        ),
                      ));
                    },
                    child: ListTile(
                      leading: Checkbox(
                          value: todos[index].complete,
                          onChanged: (value) {
                            TodoModel todo = TodoModel(
                                id: todos[index].id,
                                task: todos[index].task,
                                extraNote: todos[index].extraNote,
                                complete: value!);
                            firestoreDatabase.setTodo(todo);
                          }),
                      title: Text(todos[index].task),
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.create_edit_todo,
                            arguments: todos[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 0.5);
                },
              );
            } else {
              return EmptyContentWidget(
                subtitle1: AppLocalizations.of(context)
                    .translate("todosEmptyTopMsgDefaultTxt"),
                message: AppLocalizations.of(context)
                    .translate("todosEmptyBottomDefaultMsgTxt"),
                key: Key('EmptyContentWidget'),
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              subtitle1:
                  AppLocalizations.of(context).translate("todosErrorTopMsgTxt"),
              message: AppLocalizations.of(context)
                  .translate("todosErrorBottomMsgTxt"),
              key: Key('EmptyContentWidget'),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
