###
  Sqlite3中sql语句的几种写法。
  // Directly in the function arguments.
  db.run("UPDATE tbl SET name = ? WHERE id = ?", "bar", 2);
  // As an array.
  db.run("UPDATE tbl SET name = ? WHERE id = ?", [ "bar", 2 ]);
  // As an object with named parameters.
  db.run("UPDATE tbl SET name = $name WHERE id = $id", {
    $id: 2,
    $name: "bar"
  });
  db.run("UPDATE tbl SET name = ?5 WHERE id = ?", {
    1: 2,
    5: "bar"
  });
###
sqlite3 = require('sqlite3').verbose()
appConfig = require('./../config/appConfig')
db = null

# 连接数据库
openDb = (fn) ->
  db = new sqlite3.Database(appConfig.dbFilePath, sqlite3.OPEN_READWRITE, (err)->
    if err
      throw err
    console.log('Connection db successfully!')
    # 打开数据库成功之后，执行脚本
    fn()
  )

# 执行无返回值sql语句
exports.executeSql = (sql, params, fn) ->
  params = params || []
  openDb(->
    db.run(sql, params, (err)->
      fn(err)
      db.close()
    )
  )
# 单行记录，单个值查询
exports.executeScalar = (sql, params, fn) ->
  params = params || []
  openDb(->
    db.get(sql, params, (err, row)->
      fn(err, row)
      db.close()
    )
  )

# 执行结果集查询，返回结果数组
exports.executeQuery = (sql ,params, fn) ->
  params = params || []
  openDb(->
    db.all(sql, params, (err, rows)->
      fn(err, rows)
      db.close()
    )
  )

# 执行SQL命令，无参数
exports.execSql = (sql, fn) ->
  openDb(->
    db.exec(sql, (err)->
      fn(err)
      db.close()
    )
  )
