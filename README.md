`cov-LDSC` (covariance-adjusted LD Score Regression) is a tool extended from original LDSC to measure heritability from GWAS summary statistic in admixed populations.

## cov-LDSC
covariate-adjusted LD score regression (cov-LDSC) is a method to provide robust hg2 estimates from GWAS summary statistics and in-sample LD estimates in admixed populations. Check out the latest [preprint](https://www.biorxiv.org/content/early/2018/12/22/503144) of cov-LDSC on bioRxiv.

![ ](manuscript/figures/Figure1-covLDSC_overview.jpg)


## Getting Started
To download cov-ldsc you should clone this repository via the command
```
git clone https://github.com/immunogenomics/cov-ldsc.git
```
## LD score
We used 1000 Genome Project Ad Mixed American (AMR) chromosome 21 data as a demo. 

The first step is to acquire global principal components (PCs) from the raw genotypes. Different methods can be applied to measure PCs. We applied EIGENSOFT(Patterson et al. 2006) on AMR whole genome LD pruned data .
The PC files should be formatted that the first two columns of the covariance file are family IDs and individual IDs and the subsequent columns are the covariates that you want to include in adjusting LD.

We provide a pre-generated 10PC file on AMR_chr21/AMR.evec. 

When estimating LD score in an admixed population, you should include the genome-wide covariance file with the flags `--cov`. We recommend to use 20cM for LD window size (--ld-wind-cm). For example:
```
ldsc.py --bfile example/AMR_chr21/AMR_chr21_cm --l2 --ld-wind-cm 20 --cov example/AMR_chr21/AMR.evec --out example/AMR_chr21/AMR_chr21_20cm_covldsc
```


## Heritability estimation
For estimating heritability in admixed populations, you can follow the same command used in original LD score regression. Refer to instructions of original LD score regression : https://github.com/bulik/ldsc/wiki

## Prerequisites
1. `Python (3 > version >= 2.7)`
2. `argparse`
3. `bitarray`
4. `numpy`
5. `pandas`
6. `scipy`
