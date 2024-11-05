rule fastp:
    input:
        raw_R1 = f"{config['path_raw_file']}{{sample}}_R1.fastq.gz",
        raw_R2 = f"{config['path_raw_file']}{{sample}}_R2.fastq.gz"
    output:
        clean_R1 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R1.fastq.gz",
        clean_R2 = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_clean_R2.fastq.gz",
        unpaired_read = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_unpaired.fastq.gz",
        fastp_json = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_fastp.json",
        fastp_html = f"{PROJECTNAME}/{{sample}}/fastp/{{sample}}_fastp.html"
    params:
        quality_tresholds = config['fastp']['quality'],
        options = config['fastp']['options']
    log:
        f"{PROJECTNAME}/logs/{{sample}}/{{sample}}_fastp.log"
    conda:
        "../envs/fastp.yaml"
    threads:
        config['fastp']['threads']
    shell:
        """
        fastp -i {input.raw_R1} \
        -I {input.raw_R2} \
        -o {output.clean_R1} \
        -O {output.clean_R2} \
        --unpaired1 {output.unpaired_read} \
        --unpaired2 {output.unpaired_read} \
        -j {output.fastp_json} \
        -h {output.fastp_html} \
        -M {params.quality_tresholds} \
        {params.options} \
        -w {threads} \
        2>{log}
        """