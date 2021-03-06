% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/genDataBeta.R
\name{genBetaMPT}
\alias{genBetaMPT}
\title{Generate Data for Beta MPT Models}
\usage{
genBetaMPT(N, numItems, eqnfile, mean = NULL, sd = NULL, alpha = NULL,
  beta = NULL)
}
\arguments{
\item{N}{number of participants}

\item{numItems}{number of responses per tree (a named vector with tree labels)}

\item{eqnfile}{path to EQN file specifying the MPT model}

\item{mean}{Named vector of true group means of individual MPT parameters. If the vector is not named, the internal order of parameters is used (can be obtained using \code{\link{readEQN}}).}

\item{sd}{named vector of group standard deviations of individual MPT parameters.}

\item{alpha}{Alternative specification of the group-level distribution using the shape parameters of the beta distribution (see \link{dbeta}).}

\item{beta}{see \code{alpha}

Data are generated independently from the JAGS model files used for fitting the Beta-MPT model. If data for an equality-constrained version of the MPT model are required, the restrictions need to be hard-coded into the EQN-model file. Note that equal means still result in nonidentical MPT parameters on the individual level!}
}
\value{
a list including the generated frequencies (\code{data}) and the true, underlying parameters (\code{parameters})
}
\description{
Generating a data file with known parameter structure using the Beta-MPT. Useful for simulations and robustness checks.
}
\examples{
# Example: Standard Two-High-Threshold Model (2HTM)
EQNfile <- paste0(.libPaths()[1], "/TreeBUGS/MPTmodels/2htm.eqn")
genDat <- genBetaMPT(N = 100,
                     numItems = c(Target=250, Lure=250),
                     eqnfile = EQNfile,
                     mean = c(Do=.7, Dn=.7, g=.5),
                     sd =   c(Do=.1, Dn=.1, g=.05))
}
\references{
Smith, J. B., & Batchelder, W. H. (2010). Beta-MPT: Multinomial processing tree models for addressing individual differences. Journal of Mathematical Psychology, 54, 167-183.
}
\seealso{
\code{\link{genMPT}}
}

