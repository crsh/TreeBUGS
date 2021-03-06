% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotFrequencies.R
\name{plotFreq}
\alias{plotFreq}
\title{Plot Raw Frequencies}
\usage{
plotFreq(fittedModel, freq = TRUE, select = "all")
}
\arguments{
\item{fittedModel}{fitted hierarchical MPT model (see \code{\link{traitMPT}} or \code{\link{betaMPT}})}

\item{freq}{whether to plot absolute frequencies or relative frequencies (which sum up to one within each tree)}

\item{select}{a numeric vector with participant indices to select which raw frequencies to plot (default: \code{"all"})}
}
\description{
Plot observed raw frequencies
}

