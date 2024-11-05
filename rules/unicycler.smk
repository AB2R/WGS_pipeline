rule unicycler:
    input:
        clean_R1 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R1.fastq.gz",
        clean_R2 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R2.fastq.gz",
        unpaired_read = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_unpaired.fastq.gz"
    output:
        genome_assembly = f"{PROJECTNAME}/{{sample}}/unicycler/assembly.fasta"
    params:
        out_prefix = f"{PROJECTNAME}/{{sample}}/unicycler/",
        min_fasta_length = config['unicycler']['min_fasta_length']
    log:
        f"{PROJECTNAME}/logs/{{sample}}/{{sample}}_unicycler.log"
    conda:
        "../envs/unicycler.yaml"
    threads:
        config['unicycler']['threads']
    shell:
        """
        unicycler -1 {input.clean_R1} \
        -2 {input.clean_R2} \
        -s {input.unpaired_read} \
        -o {params.out_prefix} \
        --min_fasta_length {params.min_fasta_length} \
        2>{log} \
        -t {threads}
        """