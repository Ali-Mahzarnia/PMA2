# PMA2
This is a modification of the PMA package. The older version features are preserved.
The new version would component wise standard deviations of CCA results through permutation to standardize them.


## Install [PMA2](https://github.com/Ali-Mahzarnia/PMA2):  
You can install `PMA2` from [GitHub](https://github.com/Ali-Mahzarnia/PMA2) with the R command after removing the older version:
```R
install.packages("https://github.com/Ali-Mahzarnia/PMA2/archive/master.tar.gz", repos = NULL, type="source")
```
A thorough explanation about the new variables is available in the package manual. The following example can also be found in the manual, in the CCA function:
```R
set.seed(3128) # for replicating the result
n=100 # sample size
q=20 # base size
S=100*matrix(rnorm(100),n,q) # base matrix
u=c(rep(0,5),rep(1,3),rep(0,2) ) # True u
v=c(rep(1,5),rep(0,5),rep(1,5) ) # True v
p1=length(u) # length of true u
p2=length(v) #length of true v
U=matrix(rep(u, q),p1,q) # coefficients of base matrix for constructing X
V=matrix(rep(v, q),p2,q) # coefficients of base matrix for constructing Z
x=S%*%t(U) # constructing U
x=x+matrix(rnorm(dim(x)[1]*dim(x)[2]),dim(x)[1],dim(x)[2]);  # adding noise
z=S%*%t(V) # constructing V
z=z+matrix(rnorm(dim(z)[1]*dim(z)[2]),dim(z)[1],dim(z)[2]);  # adding noise
library(PMA)
perm.out <- CCA.permute(x,z,typex="standard",typez="standard",nperms=1000, SD=TRUE, upos = TRUE, vpos = TRUE) 
# by SD=TRUE we estimate SD of U and V components too.
# by upos and vpos we restrict the estimations to only positive values but this isn't necessary generally
print(perm.out)
```
Best L1 bound for x:  0.1

Best L1 bound for z:  0.1

| X Penalty | Z Penalty | Z-Stat | P-Value | Cors  | Cors Perm | FT(Cors) | FT(Cors Perm) | # U's Non-Zero | # Vs Non-Zero |
|-----------|-----------|--------|---------|-------|-----------|----------|---------------|----------------|---------------|
| 0.100     | 0.100     | 81.474 | 0       | 1.000 | 0.178     | 8.758    | 0.180         | 3              | 10            |


```R
out <- CCA(x,z,typex="standard",typez="standard",K=1,
           penaltyx=perm.out$bestpenaltyx,penaltyz=perm.out$bestpenaltyz,
           v=perm.out$v.init, UVperms = perm.out$UVperms, 
           allpenaltyxs = perm.out$penaltyxs , upos = TRUE, vpos = TRUE)
print(out)
```

Num non-zeros u's:  3 

Num non-zeros v's:  10 

Type of x:  standard 

Type of z:  standard 

Penalty for x: L1 bound is  0.1 

Penalty for z: L1 bound is  0.1 

U's constrained to be positive

V's constrained to be positive

Cor(Xu,Zv):  0.9999999

```R

# results of projection  for u
# respectively:True U, Estimated U, Standard deviations, Zscores, nonparametric-Pvalues
utable=base::cbind(u,out$u, out$SDu, out$standardu, out$pvalsu) 
colnames(utable)=c("True U", "Estimated U", "SDs", "Zscores", "nonpar-Pvals")
utable
```
|    | True U | Estimated U |       SDs |  Zscores | nonpar-Pvals |
|---:|-------:|------------:|----------:|---------:|-------------:|
|  1 |      0 |   0.0000000 | 0.3227695 | 0.000000 |        1.000 |
|  2 |      0 |   0.0000000 | 0.3274496 | 0.000000 |        1.000 |
|  3 |      0 |   0.0000000 | 0.3512654 | 0.000000 |        1.000 |
|  4 |      0 |   0.0000000 | 0.3227695 | 0.000000 |        1.000 |
|  5 |      0 |   0.0000000 | 0.3364717 | 0.000000 |        1.000 |
|  6 |      1 |   0.7115661 | 0.2151489 | 3.307318 |        0.049 |
|  7 |      1 |   0.6326786 | 0.1968911 | 3.213343 |        0.040 |
|  8 |      1 |   0.3056003 | 0.1734044 | 1.762357 |        0.031 |
|  9 |      0 |   0.0000000 | 0.3320154 | 0.000000 |        1.000 |
| 10 |      0 |   0.0000000 | 0.3239505 | 0.000000 |        1.000 |

```R
# results of projection  for v
# respectively:True V, Estimated V, Standard deviations, Zscores, nonparametric-Pvalues
vtable=base::cbind(v,out$v, out$SDv, out$standardv, out$pvalsv) 
colnames(vtable)=c("True V", "Estimated V", "SDs", "Zscores", "nonpar-Pvals")
vtable

```
|    | True V | Estimated V | SDs       | Zscores   | nonpar-Pvals |
|----|--------|-------------|-----------|-----------|--------------|
|  1 |      1 |  0.40319028 | 0.2138732 | 1.8851838 |        0.048 |
|  2 |      1 |  0.21945815 | 0.2338604 | 0.9384152 |        0.058 |
|  3 |      1 |  0.42693171 | 0.2457360 | 1.7373592 |        0.065 |
|  4 |      1 |  0.44814171 | 0.2338604 | 1.9162787 |        0.058 |
|  5 |      1 |  0.30363254 | 0.2610034 | 1.1633279 |        0.074 |
|  6 |      0 |  0.00000000 | 0.2586173 | 0.0000000 |        1.000 |
|  7 |      0 |  0.00000000 | 0.3274496 | 0.0000000 |        1.000 |
|  8 |      0 |  0.00000000 | 0.2300368 | 0.0000000 |        1.000 |
|  9 |      0 |  0.00000000 | 0.3014795 | 0.0000000 |        1.000 |
| 10 |      0 |  0.00000000 | 0.2376057 | 0.0000000 |        1.000 |
| 11 |      1 |  0.37283057 | 0.2095899 | 1.7788575 |        0.046 |
| 12 |      1 |  0.07033582 | 0.2300368 | 0.3057590 |        0.056 |
| 13 |      1 |  0.35775713 | 0.2051977 | 1.7434752 |        0.044 |
| 14 |      1 |  0.12576095 | 0.2448754 | 0.5135712 |        0.064 |
| 15 |      1 |  0.16194313 | 0.2619019 | 0.6183351 |        0.074 |


### Refrences

Ali Mahzarnia, Alexander Badea (2022), Joint Estimation of Vulnerable Brain Networks and Alzheimer’s Disease Risk Via Novel Extension of Sparse Canonical Correlation at bioRxiv. 
