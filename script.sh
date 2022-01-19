# COLOR VARIABLES
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
YELLOW='\033[1;33m'

echo "${GREEN}[ * ]${NC} DB Scheme and Data extractor"
echo "\n"
echo "${GREEN}[ * ]${NC} Starting..."
echo "\n"

sleep 1

read -p "$(echo $YELLOW"[ ? ] "$NC) Enter database name: " dbname
# Check if database name is not empty
if [ -z "$dbname" ]; then
    echo "${RED}[ * ]${NC} Database name cannot be empty"
    echo "${RED}[ * ]${NC} Exiting..."
    exit 1
fi
read -p "$(echo $YELLOW"[ ? ] "$NC) Enter database user: " dbuser
# Check if database user is not empty
if [ -z "$dbuser" ]; then
    echo "${RED}[ * ]${NC} Database user cannot be empty"
    echo "${RED}[ * ]${NC} Exiting..."
    exit 1
fi
read -p "$(echo $YELLOW"[ ? ] "$NC) Enter database password: " dbpass
# Check if database password is not empty
if [ -z "$dbpass" ]; then
    echo "${RED}[ * ]${NC} Database password cannot be empty"
    echo "${RED}[ * ]${NC} Exiting..."
    exit 1
fi
read -p "$(echo $YELLOW"[ ? ] "$NC) Enter database table: " dbtable


# Check if the database exists
if [ -z "$(mysql -u $dbuser -p$dbpass -e "SHOW DATABASES LIKE '$dbname'" | grep $dbname)" ]; then
    echo "${RED}[ * ]${NC} Database $dbname does not exist"
    exit 1
fi

# Check if the table exists
if [ -z "$(mysql -u $dbuser -p$dbpass -e "SHOW TABLES FROM $dbname LIKE '$dbtable'" | grep $dbtable)" ]; then
    echo "${RED}[ * ]${NC} Table $dbtable does not exist"
    exit 1
fi

if [$dbtable -eq ""] ; then
    echo "${RED}[ * ]${NC} No table selected from $dbname"
    echo "${GREEN}[ * ]${NC} Extracting entire database on $(pwd)/$dbname.sql"
    mysqldump -u $dbuser -p$dbpass $dbname > $(pwd)/$dbname.sql
else
    echo "${GREEN}[ * ]${NC} Extracting table $dbtable from $dbname on $(pwd)/$dbtable.sql"
    mysqldump -u $dbuser -p$dbpass $dbname $dbtable > $(pwd)/$dbtable.sql
fi

if [ $? -eq 0 ]; then
    echo "${GREEN}[ * ]${NC} Data extracted successfully!"
    exit 0
else
    echo "${RED}[ * ]${NC} Error while extracting data!"
    exit 1
fi