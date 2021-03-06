% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getGroupMeans.R
\name{getGroupMeans}
\alias{getGroupMeans}
\title{Get Mean Group Estimates}
\usage{
getGroupMeans(traitMPT, factor = "all", probit = FALSE)
}
\arguments{
\item{traitMPT}{a fitted \code{\link{traitMPT}} model}

\item{factor}{whether to get group estimates for all combinations of factor levels (default) or only for specific factors (requires the names of the covariates in covData)}

\item{probit}{whether to use probit scale or probability scale}
}
\description{
For hierarchical latent-trait MPT models with discrete predictor variables.
}
\author{
Daniel Heck
}
\seealso{
\code{\link{traitMPT}}
}

