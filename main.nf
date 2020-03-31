#!/usr/bin/env nextflow

params.fastq_files = "$baseDir/guppy_basecall/*.fastq"
params.artic_scheme = "V2"
params.cpus = 4
params.prefix = "run_name"

fqs = Channel.fromPath(params.fastq_files)


process GuppyBarCoder{

    input:
    file "*.fastq" from fqs.collect()

    output:
    file "barcodes/barcode*" into barcoder 
    
    shell:
    """
    guppy_barcoder --require_barcodes_both_ends -i . -s barcodes --arrangements_files "barcode_arrs_nb12.cfg barcode_arrs_nb24.cfg"
    """
}



process GuppyPlex{

    input:
    file y from barcoder.flatten()

    output:
    file "*.fastq" into guppyplexed

    shell:
    """
    PREFIX=\$(ls ./${y.fileName} | cut -d'_' -f3 | uniq)
    echo \$PREFIX
    artic guppyplex --skip-quality-check --min-length 400 --max-length 700 --directory ./${y.fileName} --prefix \$PREFIX
    """
}


process ArticMinion {
    cpus params.cpus

    input:
    file y from guppyplexed

    shell:
    """
    SAMPLE=\$(ls *.fastq | cut -d'_' -f1 | uniq)
    artic minion --normalise 200  --threads ${params.cpus} --scheme-directory /opt/artic-ncov2019/primer_schemes --skip-nanopolish --read-file ${y.fileName} nCoV-2019/${params.artic_scheme} \$SAMPLE 
    """
}
