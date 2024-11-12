rule confindr:
    input:
        clean_R1 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R1.fastq.gz"
    output:
        confindr_report = f"{PROJECTNAME}/{{sample}}/confindr/confindr_report.csv"
    params:
        database_path = config['confindr']['database_path'],
        reads_path = f"{PROJECTNAME}/{{sample}}/fastp/",
        output_path = f"{PROJECTNAME}/{{sample}}/confindr/"
    log:
        f"{PROJECTNAME}/logs/{{sample}}/{{sample}}_confindr.log"
    conda:
        "../envs/confindr.yml"
    singularity:
        "docker://quay.io/biocontainers/confindr:0.8.1--pyhdfd78af_0"
    threads:
        config['confindr']['threads']
    shell:
        """
        confindr -t {threads} \
        -i {params.reads_path} \
        -o {params.output_path} \
        -d {params.database_path} \
        --rmlst \
        2>{log}
        """