rule quast:
    input:
        clean_R1 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R1.fastq.gz",
        clean_R2 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R2.fastq.gz",
        unpaired_read = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_unpaired.fastq.gz",
        genome_assembly = f"{PROJECTNAME}/{{sample}}/unicycler/assembly.fasta",
        genome_annotation = f"{PROJECTNAME}/{{sample}}/bakta/{{sample}}.gff3"
    output:
        report_html = f"{PROJECTNAME}/{{sample}}/quast/report.html"
    params:
        output_folder = f"{PROJECTNAME}/{{sample}}/quast/",
        options = config['quast']['options'],
        genes_threshold = config['quast']['genes_threshold']
    log:
        f"{PROJECTNAME}/logs/{{sample}}/{{sample}}_quast.log"
    conda:
        "../envs/quast.yml"
    singularity:
        "docker://quay.io/biocontainers/quast:5.2.0--py38pl5321h40d3509_4"
    threads:
        config['quast']['threads']
    shell:
        """
        quast -o {params.output_folder} \
        -g {input.genome_annotation} \
        -t {threads} \
        -1 {input.clean_R1} \
        -2 {input.clean_R2} \
        --single {input.unpaired_read} \
        --gene-thresholds {params.genes_threshold} \
        {params.options} \
        {input.genome_assembly} \
        2>{log}
        """