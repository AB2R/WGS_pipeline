import os

### Open config files
configfile: "config/config_database.json"

### Make directory
if not os.path.exists("database"):
    os.makedirs("database")
if not os.path.exists("database/logs"):
    os.makedirs("database/logs")


### Rule all
rule all:
    input:
        "bakta_db_updated"


### Database rule
rule bakta_database:
    output:
        "bakta_db_updated"
    log:
        "database/logs/bakta_database"
    conda:
        "envs/bakta.yaml"
    params:
        database_path = config['bakta_database']['folder_path'],
        type = config['bakta_database']['type']
    shell:
        """
        rm -rf {params.database_path}
        bakta_db download --output {params.database_path} --type {params.type}
        touch bakta_db_updated
        """