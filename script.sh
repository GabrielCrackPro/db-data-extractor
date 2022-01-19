# COLOR VARIABLES
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

# FUNCTIONS

function checkDB() {
    if [ -z "$(mysql -u $dbuser -p$dbpass -e "SHOW DATABASES LIKE '$1'" 2>&1 | grep -v "Warning: Using a password" | grep $1)" ]; then
    echo "${RED}[ * ]${NC} Database ${RED}$1${NC} does not exist"
    echo "${RED}[ * ]${NC} Exiting..."
    exit 1
fi
}
function checkEmpty() {
    if [ -z "$1" ]; then
    echo "${RED}[ * ]${NC} Field cannot be empty"
    echo "${RED}[ * ]${NC} Exiting..."
    exit 1
fi
}
function checkTable() {
    if [ -z "$(mysql -u $dbuser -p$dbpass -e "SHOW TABLES LIKE '$1'" | grep $1)" ]; then
    echo "${RED}[ * ]${NC} Table ${RED}$1${NC} does not exist"
    echo "${RED}[ * ]${NC} Exiting..."
    exit 1
fi
}

function extractData() {
    # If table is empty extract database else extract table
    if [ -z $2 ]; then
    mysqldump -u $dbuser -p$dbpass $1 2>&1 | grep -v "Warning: Using a password"> $(pwd)/$1.sql
    else
    mysqldump -u $dbuser -p$dbpass $1 $2 2>&1 | grep -v "Warning: Using a password" > $(pwd)/$2.sql
    fi
}
echo "${GREEN}[ * ]${NC} DB Scheme and Data extractor"
echo "\n"
echo "${GREEN}[ * ]${NC} Starting..."
echo "\n"

sleep 1

read -p "$(echo $BLUE"[ ? ] "$NC)Enter database $(echo $BLUE"user"$NC): "  dbuser 
# Check if database user is not empty
checkEmpty $dbuser
read -s -p "$(echo $BLUE"[ ? ] "$NC)Enter database $(echo $BLUE"password"$NC): " dbpass
echo
# Check if database password is not empty
checkEmpty $dbpass
read  -p "$(echo $BLUE"[ ? ] "$NC)Enter database $(echo $BLUE"name"$NC): " dbname
# Check if database name is not empty
checkEmpty $dbname
checkDB $dbname
read -p "$(echo $BLUE"[ ? ] "$NC)Enter database $(echo $BLUE"table"$NC): " dbtable


extractData $dbname $dbtable

if [ $? -eq 0 ]; then
    echo "${GREEN}[ * ]${NC}Data extracted successfully!"
    echo "${GREEN}[ * ]${NC}Check $(pwd)/$dbname.sql"
    exit 0
else
    echo "${RED}[ * ]${NC}Error while extracting data try again"
    exit 1
fi