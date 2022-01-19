echo "DB Scheme and Data extractor"
echo "============================"
read -p "Enter the database name: " dbname

# Check if database is not empty

if [ -z "$dbname" ]; then
    echo "Database name cannot be empty"
    exit 1
fi
read -p "Enter the database user: " dbuser
# Check if database user is not empty
if [ -z "$dbuser" ]; then
    echo "Database user cannot be empty"
    exit 1
fi
read -p "Enter the database password: " dbpass
# Check if database password is not empty
if [ -z "$dbpass" ]; then
    echo "Database password cannot be empty"
    exit 1
fi
read -p "Enter the database table: " dbtable


# Check if the database exists
if [ -z "$(mysql -u $dbuser -p$dbpass -e "SHOW DATABASES LIKE '$dbname'" | grep $dbname)" ]; then
    echo "Database $dbname does not exist"
    exit 1
fi

# Check if the table exists
if [ -z "$(mysql -u $dbuser -p$dbpass -e "SHOW TABLES FROM $dbname LIKE '$dbtable'" | grep $dbtable)" ]; then
    echo "Table $dbtable does not exist"
    exit 1
fi


if [ $db_table -eq ""] ; then
    echo "No table selected from $dbname"
    echo "Extracting entire database on $(pwd)/$dbname.sql"
    mysqldump -u $dbuser -p$dbpass $dbname > $(pwd)/$dbname.sql
else
    echo "Extracting table $dbtable from $dbname on $(pwd)/$dbtable.sql"
    mysqldump -u $dbuser -p$dbpass $dbname $dbtable > $(pwd)/$dbtable.sql
fi

if [ $? -eq 0 ]; then
    echo "Data extracted successfully!"
    exit 0
else
    echo "Error while extracting data!"
    exit 1
fi