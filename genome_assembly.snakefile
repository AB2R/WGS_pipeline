### Import configfiles
configfile: "config/config_genome_assembly.json" #Config file of the project with all the samples
configfile: "config/config_tools.json" #Config file of tools options and thresholds.

include: "scripts/functions_genome_assembly.py"
PROJECTNAME = config['project_name']

### Create folders
mkdirectory(PROJECTNAME, config['sample'])

### Wildcards
SAMPLES = get_list_sample(config['sample'])

### Import rules
include: "rules/fastp_genome.py"
include: "rules/unicycler.py"
include: "rules/bakta.py"
include: "rules/quast.py"
include: "rules/confindr.py"

list_files = get_all_output(config['sample'])

rule all:
    input:
        expand(f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_fastp.{{extension}}", sample=SAMPLES, extension=["json", "html"]),
        list_files