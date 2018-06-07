#!/bin/bash -l
#call this files with flags -b (bedfile) -c (covariance file) -l (ldsc executable file) 

while getopts "b:c:g:l:p" arg; do 
case $arg in 
	b)
		bed_file=$OPTARG
		;;
	c)
		cov_file=$OPTARG
		;;
	l)
		ldsc_exec=$OPTARG
		;;
esac
done 


for i in {1,3,5,10,20,30}
do 
python ${ldsc_exec} --bfile ${bed_file} --maf 0.05 --l2 --ld-wind-cm ${i} --out Outputs/chr2_cm${i}_noadj
python ${ldsc_exec} --bfile ${bed_file} --maf 0.05 --l2 --ld-wind-cm ${i} --cov $cov_file --out Outputs/chr2_cm${i}_wadj
done 