
# internal function to process R2JAGS output
summarizeMPT <- function(model, mcmc, thetaNames, sampler="JAGS", transformedParameters=NULL){

  # number of parameters
  S <- max(thetaNames[,"theta"])

  if(sampler %in% c("JAGS","jags")){
    N <- dim(mcmc$BUGSoutput$mean$theta)[2]
    # which statistics to select:
    colsel <- c(1:3,5,7:9)
    uniqueNames <- thetaNames[!duplicated(thetaNames[,"theta"]),"Par"]

    if(model == "betaMPT"){
      # mean and individual parameter estimates
      mu <- mcmc$BUGSoutput$summary[paste0("mean[",1:S,"]"),colsel]
      variance <- mcmc$BUGSoutput$summary[paste0("sd[",1:S,"]"),colsel]
      alpha <- mcmc$BUGSoutput$summary[paste0("alph[",1:S,"]"),colsel]
      beta <- mcmc$BUGSoutput$summary[paste0("bet[",1:S,"]"),colsel]

      rownames(mu) <-paste0("mean_", uniqueNames)
      rownames(variance) <-paste0("sd_", uniqueNames)
      rownames(alpha) <-paste0("alpha_", uniqueNames)
      rownames(beta) <-paste0("beta_", uniqueNames)
      meanParameters <- list(mean=mu, variance=variance, alpha=alpha, beta=beta)
    }else{
      mu <- mcmc$BUGSoutput$summary[paste0("mu[",1:S,"]"),colsel]
      mean <- mcmc$BUGSoutput$summary[paste0("mean[",1:S,"]"),colsel]
      sigma <- mcmc$BUGSoutput$summary[paste0("sigma[",1:S,"]"),colsel]
      rho <- rhoNames <- c()
      cnt <- 1
      # if(S>1){
#         rho <- mcmc$BUGSoutput$summary[paste0("rho[1,",2:S,"]"),colsel]
      #         rownames(rho) <- paste0("rho[1,",1:S,"]_",uniqueNames[1],"_",uniqueNames[2:S])
      # cnt <- 2
      while(cnt<S){
        rho <- rbind(rho, mcmc$BUGSoutput$summary[paste0("rho[",cnt,",",(cnt+1):S,"]"),colsel])
        rhoNames <- c(rhoNames,
                      paste0("rho[",uniqueNames[cnt],",",uniqueNames[(cnt+1):S],"]"))
        cnt <- cnt+1
      }

      rownames(mu) <-paste0("latent_mu_", uniqueNames)
      rownames(mean) <-paste0("mean_", uniqueNames)
      rownames(sigma) <-paste0("latent_sigma_", uniqueNames)
      rownames(rho) <- rhoNames

      meanParameters <- list(mean = mean, mu = mu, sigma = sigma, rho = rho)
    }

    individParameters <- array(c(mcmc$BUGSoutput$mean$theta,
                                 mcmc$BUGSoutput$median$theta,
                                 mcmc$BUGSoutput$sd$theta), c(S,N,3))
    dimnames(individParameters) <- list(Parameter=uniqueNames,
                                        ID=1:N, Statistic=c("Mean","Median","SD"))

    # goodness of fit and deviance
    if(is.null(transformedParameters)){
      transPar <- NULL}
    else{
      transPar <- mcmc$BUGSoutput$summary[transformedParameters,colsel, drop=FALSE]
    }

    summary <- list(meanParameters=meanParameters,
                    individParameters=individParameters,
                    fitStatistics=list(
                      "overall"=c("DIC"=mcmc$BUGSoutput$DIC,
                                  "T1.observed"=mcmc$BUGSoutput$mean$T1.obs,
                                  "T1.predicted"=mcmc$BUGSoutput$mean$T1.pred,
                                  "p.T1"=mcmc$BUGSoutput$mean$p.T1),
                      "p.T1individual"=mcmc$BUGSoutput$mean$p.T1ind),
                    transformedParameters=transPar)
  }else{
    warning("Clean MPT summary statistics only available when using JAGS.")
    summary <- mcmc$BUGSoutput$summary
  }
  return(summary)
}


#' @export
print.summary.betaMPT <- function(x,  ...){
  if(is.null(x$meanParameters)){
    warning("Clean MPT summary only available when fitting with JAGS.")
    print(x)
  }else{
    cat("Mean parameters on group level:\n")
    print(round(x$meanParameters$mean, 4))
    cat("\nVariance of parameters across individuals:\n")
    print(round(x$meanParameters$variance, 4))

    cat("\nOverall model fit statistics (T1: Posterior predictive check):\n")
    print(round(x$fitStatistics$overall, 4))
    cat("\nPoster predictive p-values for individual data sets:\n")
    print(round(x$fitStatistics$p.T1individual, 4))
    if(!is.null(x$transformedParameters)){
      cat("\nTransformed parameters:\n")
      print(round(x$transformedParameters, 4))
    }

  }
}

#' @export
print.summary.traitMPT <- function(x,  ...){
  if(is.null(x$meanParameters)){
    warning("Clean MPT summary only available when fitting with JAGS.")
    print(x)
  }else{
    cat("Mean parameters on group level:\n")
    print(round(x$meanParameters$mean, 4))
    cat("\nMean of latent-trait values across individuals:\n")
    print(round(x$meanParameters$mu, 4))
    cat("\nStandard deviation of latent-trait values across individuals:\n")
    print(round(x$meanParameters$sigma, 4))

    cat("\nOverall model fit statistics (T1: Posterior predictive check):\n")
    print(round(x$fitStatistics$overall, 4))
    cat("\nPoster predictive p-values for individual data sets:\n")
    print(round(x$fitStatistics$p.T1individual, 4))
    if(!is.null(x$transformedParameters)){
      cat("\nTransformed parameters:\n")
      print(round(x$transformedParameters, 4))
    }

  }
}

#' @export
summary.betaMPT <- function(object,  ...){
  if(!object$sampler %in% c("jags", "JAGS")){
    warning("Clean MPT summary only available when fitting with JAGS.")
  }
  summ <- object$summary
  class(summ) <- "summary.betaMPT"
  return(summ)
}

#' @export
summary.traitMPT <- function(object,  ...){
  if(!object$sampler %in% c("jags", "JAGS")){
    warning("Clean MPT summary only available when fitting with JAGS.")
  }
  summ <- object$summary
  class(summ) <- "summary.traitMPT"
  return(summ)
}

#' @export
print.betaMPT <- function(x,  ...){
  cat("Call: \n")
  print(x$call)
  cat("\n")
  if(!x$sampler %in% c("jags", "JAGS")){
    warning("\nClean MPT summary only available when fitting with JAGS.")
  }else{
    print(round(cbind("Group Mean" = x$summary$meanParameters$mean[,1],
                "Group Variance" = x$summary$meanParameters$variance[,1]),4))
  }
  cat("\nUse 'summary(fittedModel)' or 'plot(fittedModel)' to get a more detailed summary.")
}

#' @export
print.traitMPT <- function(x,  ...){
  cat("Call: \n")
  print(x$call)
  cat("\n")
  if(!x$sampler %in% c("jags", "JAGS")){
    warning("\nClean MPT summary only available when fitting with JAGS.")
  }else{
    print(round(cbind("Mean(MPT Parameters)" = x$summary$meanParameters$mean[,1],
                      "Mu(latent-traits)" = x$summary$meanParameters$mu[,1],
                      "SD(latent-traits)" = x$summary$meanParameters$sigma[,1]),4))
  }
  cat("\nUse 'summary(fittedModel)' or 'plot(fittedModel)' to get a more detailed summary.")
}