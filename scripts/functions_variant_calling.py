import os


def mkdirectory(project_name, samples_list):
    if not os.path.exists(project_name):
        os.makedirs(project_name)
    if not os.path.exists(f"{project_name}/logs"):
        os.makedirs(f"{project_name}/logs")

    list_sample_directory = ["fastp", "snippy"]
    
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

def get_all_output(samples_list):

    list_files = []

    for sample in samples_list:
        #snippy
        list_files.append(f"{PROJECTNAME}/{sample['sampleID']}/snippy/{sample['sampleID']}_snps.tab")

    return list_files