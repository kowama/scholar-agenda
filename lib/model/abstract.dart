import 'package:sqflite/sqlite_api.dart';

abstract class Provider<T> {
  Database _database;
  ProviderConfig<T> _config;

  Provider(this._database, this._config)
      : assert(_config != null && _database != null);

  Future createTable() async {
    await _database.execute(_config.createTableSql);
  }

  Future<T> insert(T entity) async {
    var id = await _database.insert(_config.tableName, _config.toMap(entity));
    _config.setIdOf(entity, id);
    return entity;
  }

  Future<List<T>> getAll() async {
    var entities = <T>[];
    List<Map> maps =
        await _database.query(_config.tableName, columns: _config.columns);
    maps.forEach((m) => entities.add(_config.fromMap(m)));
    return entities;
  }

  Future<T> get(int id) async {
    List<Map> maps = await _database.query(_config.tableName,
        columns: _config.columns,
        where: '${_config.columnId} = ?',
        whereArgs: [id]);
    return maps.isNotEmpty ? _config.fromMap(maps.first) : null;
  }

  Future<int> delete(int id) async {
    return await _database.delete(_config.tableName,
        where: '${_config.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(T entity) async {
    return await _database.update(_config.tableName, _config.toMap(entity),
        where: '${_config.columnId} = ?', whereArgs: [_config.getIdOf(entity)]);
  }
}

abstract class ProviderConfig<T> {
  String get tableName;

  String get createTableSql;

  String get columnId;

  List<String> get columns;

  T fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap(T entity);

  int getIdOf(T entity);

  void setIdOf(T entity, int value);
}
