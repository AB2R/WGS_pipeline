rule bakta:
    input:
        genome_assembly = f"{PROJECTNAME}/{{sample}}/unicycler/assembly.fasta"
    output:
        genome_gff = f"{PROJECTNAME}/{{sample}}/bakta/{{sample}}.gff3"
    params:
        database_path = config['bakta']['database_path'],
        prefix = "{sample}",
        output_folder = f"{PROJECTNAME}/{{sample}}/bakta/",
        genus = lambda wildcards:  get_sample_genus(wildcards.sample),
        species = lambda wildcards:  get_sample_species(wildcards.sample)
    log:
        f"{PROJECTNAME}/logs/{{sample}}/{{sample}}_bakta.log"
    conda:
        "../envs/bakta.yml"
    container:
        "docker://quay.io/biocontainers/bakta:1.9.4--pyhdfd78af_0"
    threads:
        config['bakta']['threads']
    shell:
        """
        bakta --db {params.database_path} \
        --threads {threads} \
        --force \
        --output {params.output_folder} \
        --prefix {params.prefix} \
        --genus {params.genus} \
        --species {params.species} \
        {input.genome_assembly} \
        2>{log}
        """