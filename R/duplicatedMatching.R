#' Searching of duplicated records in a bibliographic database  
#'
#' Search duplicated records in a dataframe.
#' 
#' A bibliographic data frame is obtained by the converting function \code{\link{convert2df}}. 
#' It is a data matrix with cases corresponding to manuscripts and variables to Field Tag in the original SCOPUS and Thomson Reuters' ISI Web of Knowledge file.
#' The function identifies duplicated records in a bibliographic data frame and deletes them. 
#' Duplicate entries are identified through the restricted Damerau-Levenshtein distance. 
#' Two manuscripts that have a relative similarity measure greater than \code{tol} argument are stored in the output data frame only once. 
#'
#' @param M is the bibliographic data frame.
#' @param Field is a character object. It indicates one of the field tags used to identify duplicated records. Field can be equal to one of this tags: TI (title), AB (abstract), UT (manuscript ID).
#' @param tol is a numeric value giving the minimum relative similarity to match two manuscripts. Default value is \code{tol = 0.95}. 
#' @return the value returned from \code{duplicatedMatching} is a data frame without duplicated records.
#'
#'
#' @examples
#'  
#' data(scientometrics)
#' 
#' M=rbind(scientometrics[1:20,],scientometrics[10:30,])
#' 
#' newM <- duplicatedMatching(M, Field = "TI", tol = 0.95)
#'
#' dim(newM)
#'
#'
#' @seealso \code{\link{convert2df}} to import and convert an ISI or SCOPUS Export file in a bibliographic data frame.
#' @seealso \code{\link{biblioAnalysis}} function for bibliometric analysis.
#' @seealso \code{\link{summary}} to obtain a summary of the results.
#' @seealso \code{\link{plot}} to draw some useful plots of the results.
#'
#' @export
duplicatedMatching <- function(M, Field="TI", tol=0.95){
  
  a=b=M[[Field]]
  an=nchar(a)
  A=matrix(an,length(an),length(an))
  B=t(A)
  C=A
  C[B>A]=B[B>A]
  D=as.matrix(stringdistmatrix(a))
  Dn=1-(D/C)
  Dn[Dn>tol]=2
  M=M[!duplicated(Dn),]
  return(M)
  
}