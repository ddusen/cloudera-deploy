psql --host=10.0.1.181 --port=5432 --dbname=dusen -c "CREATE SCHEMA genncdmvv489_incre_model;"
psql --host=10.0.1.181 --port=5432 --dbname=dusen -f /gpbak/pg_dump_20230414/schemas/genncdmvv489_incre_model.visits_course_record.sql
