#!/bin/bash -l
#call this files with flags -b (bedfile, just use chromosome 2 file for test ) -c (covariance file) -l (ldsc executable file) 

usage="$(basename "$0") [-h] [-b -c -l] --measure LD score in different window size

where:
	-h show this help text
	-b input bfile, use chromosome 2 file for test 
	-c input genome-wide covariance file (PCs); for now, the individual order in the PCs should be the same as the order in .fam file
	-l indicate the location of ldsc.py in cov-ldsc. If you run in this directory, use the command: -l ../ldsc.py "

while getopts "b:c:g:l:p:h" arg; do 
case $arg in 
	h) echo "$usage"
		exit
		;;
	b)
		bed_file=$OPTARG
		;;
	c)
		cov_file=$OPTARG
		;;
	l)
		ldsc_exec=$OPTARG
		;;
	*) printf "illegal option: -%s\n" "$arg">&2 
		echo "$usage">&2
		exit 1
		;;
esac
done 

if [ $OPTIND -eq 1 ] 
then 
    echo "No options were passed"
    echo "$usage"
else
    for i in {1,5,10,20,30}
    do 
	python ${ldsc_exec} --bfile ${bed_file} --maf 0.05 --l2 --ld-wind-cm ${i} --out Outputs/chr2_cm${i}_noadj
	python ${ldsc_exec} --bfile ${bed_file} --maf 0.05 --l2 --ld-wind-cm ${i} --cov $cov_file --out Outputs/chr2_cm${i}_wadj
    done 
fi
