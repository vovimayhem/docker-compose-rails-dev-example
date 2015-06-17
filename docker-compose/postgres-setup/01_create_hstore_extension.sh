# https://github.com/aidanlister/postgres-hstore/blob/master/create_extension.sh
# Because both template1 and the user postgres database have already been created,
# we need to create the hstore extension in template1 and then recreate the postgres database.
#
# Running CREATE EXTENSION in both template1 and postgres can lead to
# the extensions having different eid's.

echo "Initialization file at:";
echo " - [compose-project]/volumes/postgres/docker-entrypoint-initdb.d/01_create_hstore_extension.sh";
echo "Operation: CREATING POSTGRESQL HSTORE EXTENSION";

gosu postgres postgres --single template1 -E <<-EOSQL
  CREATE EXTENSION hstore;
  DROP DATABASE postgres;
  CREATE DATABASE postgres TEMPLATE template1;
EOSQL

echo "";
echo "POSTGRESQL HSTORE EXTENSION CREATED";
