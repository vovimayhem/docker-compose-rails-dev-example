#! /bin/bash
echo "Initialization file at:";
echo " - [compose-project]/volumes/postgres/docker-entrypoint-initdb.d/03_create_project_databases.sh";
echo "Operation: CREATING PROJECT DATABASES";

gosu postgres postgres --single <<-EOSQL
   CREATE DATABASE my_app_development;
   CREATE DATABASE my_app_test;
EOSQL

echo "";
echo "PROJECT DATABASES CREATED";
