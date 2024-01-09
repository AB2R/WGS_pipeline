import os


def mkdirectory(project_name, samples_list):
    if not os.path.exists(project_name):
        os.makedirs(project_name)
    
    if not os.path.exists(f"{project_name}/logs"):
        os.makedirs(f"{project_name}/logs")

    list_sample_directory = ["fastp", "unicycler", "bakta", "quast"]
    
    for sample in samples_list:
        if not os.path.exists(f"{project_name}/logs/{sample['sampleID']}"):
            os.path.exists(f"{project_name}/logs/{sample['sampleID']}")
        
        for directory in list_sample_directory:
            if not os.path.exists(f"{project_name}/{sample['sampleID']}/{directory}"):
                os.path.exists(f"{project_name}/{sample['sampleID']}/{directory}")

def get_list_sample(samples_list):
    """
    Return a list of samples id.

    Args:
        samples_list (list): List of samples input in the pipeline.
    Return:
        list_id_sample (list): List of samples id.
    """
    id_sample = []
    for sample in samples_list:
        id_sample.append(sample['sampleID'])
    return id_sample

def get_sample_genus(sample_name):
    for sample in config['sample']:
        if sample['sampleID'] == sample_name:
            return sample['phylogeny']['genus']

def get_sample_species(sample_name):
    for sample in config['sample']:
        if sample['sampleID'] == sample_name:
            return sample['phylogeny']['species']

def get_all_output(samples_list):

    list_files = []

    for sample in samples_list:
        #unicycler
        list_files.append(f"{PROJECTNAME}/{sample['sampleID']}/unicycler/assembly.fasta")

        #bakta
        list_files.append(f"{PROJECTNAME}/{sample['sampleID']}/bakta/{sample['sampleID']}.gff3")

        #quast
        list_files.append(f"{PROJECTNAME}/{sample['sampleID']}/quast/report.html")

    return list_files