% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getParam.R
\name{getParam}
\alias{getParam}
\title{Get Parameter Posterior Estimates}
\usage{
getParam(fittedModel, parameter = "mean", posterior = "Mean")
}
\arguments{
\item{fittedModel}{a fitted latent-trait MPT model (see \code{\link{traitMPT}}) or beta MPT model (see \code{\link{betaMPT}})}

\item{parameter}{which parameter(s) should be returned? (see below for details)}

\item{posterior}{whether to show the posterior \code{"Mean"}, \code{"50\%"} (median), or \code{"SD"}}
}
\description{
Returns posterior statistics (e.g., mean, median) for the parameters of a hierarchical MPT model.
}
\details{
In the latent-trait MPT, the following parameters are being estimated:
\itemize{
\item \code{"mean"} (group means on probability scale)
\item \code{"mu"} (group means on probit scale)
\item \code{"sigma"} (SD on probit scale)
\item \code{"rho"} (correlations on probit scale)
\item \code{"theta"} (individual MPT parameters)
}

In the beta MPT, the following parameters are being estimated:
\itemize{
\item \code{"mean"} (group means on probability scale)
\item \code{"sd"} (SD on probability scale)
\item \code{"alph"},\code{"bet"} (group parameters of beta distribution)
\item \code{"theta"} (individual MPT parameters)
}

Note that this function is only a wrapper to conveniently access the information stored in \code{fittedModel$mcmc.summ}
}
\author{
Daniel Heck
}
\seealso{
\code{\link{traitMPT}}, \code{\link{betaMPT}}
}

