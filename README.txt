cov-LDSC (covariance-adjusted LD Score Regression) 

cov-LDSC is a tool extended from original LDSC to measure heritability from GWAS summary statistic in admixed populations. 

## Getting Started
To download cov-ldscâ you should clone this repository via the command 
ÔÕÕ
git clone https://github.com/immunogenomics/cov-ldsc.git
ÔÕÕ

## LD score 
When estimating LD score in an admixed population, you should include the genome-wide covariance file with the flags -Ñcov. 

eg. 
ldsc.py Ñbfile 1000Genome Ñ-l2 Ñ-ld-wind-cm 20 -Ñcov 1000Genome.evec Ñ-out 1000Genome_ld

The first two columns of the covariance file should be family IDs and individual IDs. For now, the individual order in the covariance file needs to have the same individual order as the .fam file. The subsequent columns are the covariates that you want to include in adjusting LD. 


## Heritability estimation 
For estimating heritability in admixed populations, you can follow the same command used in original LD score regression. Refer to instructions of original LD score regression : https://github.com/bulik/ldsc/wiki


## Requirements
1. `Python (3 > version >= 2.7)`
2. `argparse`
3. `bitarray`
4. `numpy`
5. `pandas`
6. `scipy`

## Citations 

## Authors 




