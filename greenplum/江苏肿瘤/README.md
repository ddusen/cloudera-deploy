### 江苏肿瘤

使用 pg_dump 进行一次全量数据的备份。

> 额外备份出schema table列表、表结构信息，便于人工检查核对。

### 1. 备份 schema、table 列表
```bash
./all_schema_table.sh
```

### 2. 备份表结构
- 每个表会生成单独的文件

```bash
./dump_schema.sh
```

### 3. 备份表数据
- 每个表会生成单独的文件

```bash
./dump_data.sh
```

### 4. 还原表
- 需要手动创建 schema 

```bash
psql --host=10.0.1.181 --port=5432 --dbname=dusen -c "CREATE SCHEMA genncdmvv489_incre_model;"
```

- 如果只想还原表结构，通过以下方式（否则，请忽略！）
```bash
psql --host=10.0.1.181 --port=5432 --dbname=dusen -f /gpbak/pg_dump_20230414/schemas/genncdmvv489_incre_model.visits_course_record.sql
```

- 还原数据
```bash
pg_restore --host=10.0.1.181 --port=5432 --dbname=dusen --schema=genncdmvv489_incre_model --table=visits_course_record --verbose /gpbak/pg_dump_20230414/datas/genncdmvv489_incre_model.visits_course_record.data
```
