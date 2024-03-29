% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OEFPIL.R
\name{OEFPIL}
\alias{OEFPIL}
\title{Optimal Estimation of Parameters by Iterated Linearization}
\usage{
OEFPIL(data, form, start.val, CM, max.iter = 100, see.iter.val = FALSE,
       save.file.name, th, signif.level, useNLS = TRUE)
}
\arguments{
\item{data}{a data file can be any object of type \code{data.frame} with 2 named columns or \code{list} with 2 elements.}

\item{form}{an object of class \code{\link[stats]{formula}} (or one that can be coerced to that class): a symbolic description of the model to be fitted. The details of model specification are given under ‘Details’.}

\item{start.val}{a named list of starting values of estimating parameters.}

\item{CM}{a covariance matrix of \code{data} (See 'Details' for the information about required structure.).}

\item{max.iter}{maximum number of iterations.}

\item{see.iter.val}{logical. If \code{TRUE}, all the partial results of the algorithm are displayed and saved. The default value is \code{FALSE}.}

\item{save.file.name}{a name of the file for saving results. If missing, no output file is saved.}

\item{th}{a numerical value, indicating threshold necessary for the iteration stoppage. The default value is \code{.Machine$double.eps ^ (2 / 3)}.}

\item{signif.level}{a significance level for the confidence interval. If missing, the default value 0.05 is used.}

\item{useNLS}{logical. If \code{TRUE} (the default value), function will set up starting parameters calculated by \code{\link{nlsLM}} function (nonlinear least square estimation).}
}
\value{
Returns an object of class \code{"OEFPIL"}. It is a list containing the following components

\item{name_Est}{estimations of model parameters.}
\item{name_upgraded.start.val}{modified starting values of estimating parameters (result from \code{\link{nlsLM}} function).}
\item{cov.m_Est}{estimated covariance matrix of parameters.}
\item{cov.m_nlsLM}{a covariance matrix of starting values of parameters from \code{\link{nlsLM}} function (if \code{useNLS} was set to \code{TRUE}).}
\item{it_num}{number of iterations.}
\item{name_previous.step}{the parameter values from the previous iterative step.}
\item{CI_parameters}{a list of confidence intervals for estimated parameters (a significance level is based on \code{signif.level} argument).}
\item{logs}{warnings or messages of events, which happen during the run of the algorithm.}

\item{contents}{a list of outputs as original values of data and other characteristics, which are usable in plotting or other operations with model results.}

If \code{useNLS} argument is set to \code{FALSE}, the \code{name_upgraded.start.val} are the same as \code{start.values} (no \code{nlsLM} procedure for starting value fitting is performed).
}
\description{
Function for computing optimal estimate of parameters of a nonlinear function by iterated linearization (using Taylor expansion). The model considers measurements errors in both (dependent and independent) variables.
}
\details{
Models for OEPFIL function are specified symbolically. A typical model has the form \code{y ~ f(x, a_1,...,a_n)}, where

 \itemize{\item \code{y} is the (numerical) response vector,
           \item \code{x} is the predictor,
           \item terms \code{a_1,...,a_n} are parameters of specified model.}
 Function \code{f} is known nonlinear function with continuous second partial derivatives with respect to \code{x} and parameters \code{a_1,...a_n} (for more details see (Kubáček, 2000).

 All calculations are performed assuming normality of a response vector and measurements errors.

 In the \code{data} entry of type \code{data.frame}, both columns must be named as variables in formula. The same holds for elements of \code{list}.

A choice of \code{start.val} is important for the convergence of the algorithm. If the \code{OEFPIL} algorithm does not converge, starting values modified by \code{nlsLM} function (\code{useNLS = TRUE}) are recommended (see Example 3).

The \code{CM} has to be a \code{2n} covariance matrix (where \code{n} is length of \code{data}) of following structure: first \code{n} elements of the diagonal correspond to the variance of independent variable (\code{x}) and other to the variance of dependent variable (\code{y}).
If argument \code{CM} is missing, the input covariance matrix is set to a diagonal variance matrix with sample variance on the main diagonal.
}
\note{
The symbol \code{pi} is reserved for the Ludolf's constant. So naming one of the model´s parameters by this symbol results in constant entry of the model.
}
\examples{
##Example 1 - Use of OEFPIL function for steam data from MASS library
library(MASS)
steamdata <- steam
colnames(steamdata) <- c("x","y")
k <- nrow(steamdata)
CM <- diag(rep(5,2*k))

st1 <- OEFPIL(steamdata, y ~ b1 * 10 ^ (b2 * x/ (b3 + x)),
 list(b1 = 5, b2 = 8, b3 = 200), CM, useNLS = FALSE)

## Displaying results using summary function
summary(st1)

## Plot of estimated function
plot(st1, signif.level = 0.05)

## Example 2 - Use of OEFPIL for nanoindentation data "silica2098.RData"
## (which is part of the OEFPIL package)
## Preparing arguments for OEFPIL function
max.iter = 100
see.iter.val = FALSE
signif.level = 0.05
useNLS = TRUE

## Creating a list with starting values for parameters
start.val <- list(alpha=0.1, m=1.5, hp=0.9)
names(start.val) <- c("alpha", "m", "hp")

## Imputed formula
form <- Load ~ alpha * (Depth - hp) ^ m
k <- length(silica2098[,1])
CM <- diag(c(rep(0.5^2,k),rep(0.001^2,k)))

## Use of OEFPIL function with defined arguments
output.form <- OEFPIL(silica2098, form, start.val, CM = CM, max.iter = max.iter,
 see.iter.val = see.iter.val, signif.level = signif.level, useNLS = useNLS)

## Displaying results with summary (the result is the same as in NanoIndent.OEFPIL function)
summary(output.form)

}
\references{
Kubáček, L. and Kubáčková, L. (2000) \emph{Statistika a metrologie}. Univerzita Palackého v Olomouci.

   Köning, R., Wimmer, G. and Witkovský, V. (2014) \emph{Ellipse fitting by nonlinear constraints to demodulate quadrature homodyne interferometer signals and to determine the statistical uncertainty of the interferometric phase}.
    Measurement Science and Technology.
}
\seealso{
\code{\link{NanoIndent.OEFPIL}} and function \code{\link[minpack.lm]{nlsLM}} from \code{minpack.lm} package for nonlinear least square algorithms.
}
