rule snippy:
    input:
        clean_R1 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R1.fastq.gz",
        clean_R2 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R2.fastq.gz",
        genome_ref = config['path_genome_ref']
    output:
        variant_tab = f"{PROJECTNAME}/{{sample}}/snippy/{{sample}}_snps.tab"
    params:
        outdir = f"{PROJECTNAME}/{{sample}}/snippy/",
        prefix = f"{{sample}}_snps"
    log:
        f"{PROJECTNAME}/logs/{{sample}}/{{sample}}_snippy.log"
    conda:
        "../envs/snippy.yaml"
    container:
        "docker://quay.io/biocontainers/snippy:4.6.0--hdfd78af_5"
    threads:
        config['snippy']['threads']
    shell:
        """
        snippy --cpus {threads} \
        --force \
        --outdir {params.outdir} \
        --prefix {params.prefix} \
        --ref {input.genome_ref} \
        --R1 {input.clean_R1} \
        --R2 {input.clean_R2} \
        2>{log}
        """
    