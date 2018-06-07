cov-LDSC (covariance-adjusted LD Score Regression)

cov-LDSC is a tool extended from original LDSC to measure heritability from GWAS summary statistic in admixed populations.

## Getting Started
To download cov-ldsc you should clone this repository via the command
```
git clone https://github.com/immunogenomics/cov-ldsc.git
```
## LD score
When estimating LD score in an admixed population, you should include the genome-wide covariance file with the flags --cov. For example:
```
ldsc.py --bfile 1000Genome --l2 --ld-wind-cm 20 --cov 1000Genome.evec --out 1000Genome_ld
```

The first two columns of the covariance file should be family IDs and individual IDs. For now, the individual order in the covariance file needs to have the same individual order as the \*.fam file. The subsequent columns are the covariates that you want to include in adjusting LD.

## Heritability estimation
For estimating heritability in admixed populations, you can follow the same command used in original LD score regression. Refer to instructions of original LD score regression : https://github.com/bulik/ldsc/wiki

## Prerequisites
1. `Python (3 > version >= 2.7)`
2. `argparse`
3. `bitarray`
4. `numpy`
5. `pandas`
6. `scipy`

## Citations

Bulik-Sullivan, et al. LD Score Regression Distinguishes Confounding from Polygenicity in Genome-Wide Association Studies. Nature Genetics, 2015.

## Authors
Xinyi Li
Yang Luo
Hilary Finucane
