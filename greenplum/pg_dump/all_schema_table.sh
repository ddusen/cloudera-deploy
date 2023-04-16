psql zdyf --echo-all -c "SELECT table_schema || '.' || table_name AS table_full_name FROM information_schema.tables"  --output=all_schema_table.out
