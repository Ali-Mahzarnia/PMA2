#' Penalized Multivariate Analysis
#'
#' This package is called __PMA2__, for __P__enalized __M__ultivariate
#' __A__nalysis.  It implements three methods: A penalized matrix
#' decomposition, sparse principal components analysis, and sparse
#' canonical correlations analysis. All are described in the reference below.
#' The main functions are: `PMD`, `CCA` and `SPC`.
#'
#' The first, `PMD`, performs a penalized matrix decomposition.  `CCA`
#' performs sparse canonical correlation analysis. `SPC` performs sparse
#' principal components analysis.
#'
#' There also are cross-validation functions for tuning parameter selection for
#' each of the above methods: `SPC.cv`, `PMD.cv`, `CCA.permute`. And `PlotCGH` produces
#' nice plots for DNA copy number data.
#'
#' @name PMA2-package
#' @aliases PMA2-package PMA2
#' @docType package
#' @useDynLib PMA2
#' @references
#'***  \doi{***}.
#' @keywords package
NULL


#' Breast cancer gene expression + DNA copy number data set from Chin
#' et. al. and used in Witten, et. al. See references below.
#'
#' This data set consists of gene expression and DNA copy number
#' measurements on a set of 89 samples. The data set can be used to
#' perform integrative analysis of gene expression and DNA copy number
#' data, as in . That is,
#' we can look for sets of genes that are associated with regions of
#' chromosomal gain/loss.
#'
#' Missing values were imputed using 5-nearest neighbors (see library
#' `pamr`).
#'
#' @name breastdata
#' @docType data
#' @format The format is a list containing the following elements: - dna: a
#' 2149x89 matrix of CGH spots x Samples - rna: a 19672x89 matrix of Genes x
#' Samples - chrom: a 2149-vector of chromosomal location of each CGH spot -
#' nuc: a 2149-vector of nucleotide position for each CGH spot - gene: a
#' 19672-vector wiith an accession number for each gene - genenames: a
#' 19672-vector with a name for each gene - genechr: a 19672-vector with a
#' chromosomal location for each gene - genedesc: a 19672-vector with a
#' description for each gene - genepos: a 19672-vector with a nucleotide
#' position for each gene
#' @references
#'
#'
#' Ali Mahzarnia, Alexander Badea (2022)
#' \emph{Joint Estimation of Vulnerable Brain Networks and Alzheimer’s Disease Risk Via Novel Extension of Sparse Canonical Correlation at bioRxiv.} \cr
#'
#' Must be downloaded from   https://github.com/Ali-Mahzarnia/PMA2
#' @keywords datasets
#' @examples
#'
#' data(breastdata)
#' attach(breastdata)
#' PlotCGH(dna[,1], chrom=chrom, main="Sample 1", nuc=nuc)
#' detach(breastdata)
#'
NULL





