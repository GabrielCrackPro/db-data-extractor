# DB Data Extractor

[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/GabrielCrackPro/db-data-extractor/master/LICENSE)
<img src="https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white" alt="sql-logo">

Script that dumps database information using [MySQLDump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html)

## Usage

- Run the script with the following command: <br>

```
./script.sh
```

- If the command doesn't work, try to give it executable permissions with the following command: <br>

  ```
    chmod +x script.sh
  ```

If you want to run the script from anywhere, you can create an alias for it: <br>
Put the following line in your .bashrc or .zshrc file: <br>

```
    alias dump="sh path/to/script.sh"
```

## Requirements

- <a href="https://dev.mysql.com/downloads" target="_blank">MySQL</a>
