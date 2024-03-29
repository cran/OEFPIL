% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/NanoIndent.OEFPIL.R
\name{NanoIndent.OEFPIL}
\alias{NanoIndent.OEFPIL}
\title{Estimation of parameters in nanoindentation}
\usage{
NanoIndent.OEFPIL(data, alpha.start, m.start, hp.start, unload.data = FALSE, ucut = 0.98,
                 lcut = 0.4, CM, uh = 0.5, uF = 0.001, max.iter = 100,
                 see.iter.val = FALSE, save.file.name, th = .Machine$double.eps ^ (2 / 3),
                 signif.level = 0.05, useNLS = TRUE)
}
\arguments{
\item{data}{an object of type \code{data.frame} with 2 named columns or \code{list} with 2 elements.}

\item{alpha.start}{a starting value of the fitting constant alpha.}

\item{m.start}{a starting value of the exponent m.}

\item{hp.start}{a starting value of the permanent indentation depth hp.}

\item{unload.data}{a logical value (default \code{FALSE}) indicating the structure of \code{data}. If \code{TRUE}, an input data contains only unloading part of the curve. If \code{FALSE}, an input data contains complete loading, hold and unloading parts of an indentation process.}

\item{ucut}{a numerical value, indicating the upper bound of cut off.}

\item{lcut}{a numerical value, indicating the lower bound of cut off.}

\item{CM}{a covariance matrix of the input \code{data}. See 'Details' for more information.}

\item{uh}{standard deviation of depth.}

\item{uF}{standard deviation of load.}

\item{max.iter}{maximum number of iterations.}

\item{see.iter.val}{logical. If \code{TRUE}, all the partial results of the OEFPIL algorithm are displayed and saved. The default value is \code{FALSE}.}

\item{save.file.name}{a name of the file for saving results. If missing, no output file is saved.}

\item{th}{a numerical value, indicating threshold necessary for the iteration stoppage.}

\item{signif.level}{a significance level for the confidence interval.}

\item{useNLS}{logical. If \code{TRUE} (the default value), function will set up starting parameters calculated by \code{\link{nlsLM}} function (nonlinear least square estimation).}
}
\value{
Returns an object of class \code{"OEFPIL"}. It is a list containing at least the following components

\item{name_Est}{estimations of model parameters.}
\item{name_upgraded.start.val}{modified starting values of estimating parameters (result from \code{\link{nlsLM}} function).}
\item{cov.m_Est}{estimated covariance matrix of parameters.}
\item{it_num}{number of iterations.}
\item{CI_parameters}{a list of confidence intervals for estimated parameters (a significance level is based on \code{signif.level} argument).}
\item{logs}{warnings or messages of events, which happen during the run of the algorithm.}
\item{...}{for other components specification see \code{\link{OEFPIL}}.}

\item{contents}{a list of outputs as original values of data and other characteristics, which are usable in plotting or other operations with model results.}

If \code{useNLS} argument is set to \code{FALSE}, the \code{name_upgraded.start.val} are the same as \code{start.values} (no \code{nlsLM} procedure for starting value fitting is performed).
}
\description{
Fitting the unloading curve in nanoindentation process by power law function with parameters estimated by iterated linearization algorithm (OEFPIL). The special case of \code{\link{OEFPIL}} function customized for using in nanoindentation (see 'Details').
}
\details{
In this special case of the \code{OEFPIL} function, the dependence of parameters is fixed in
the form: \eqn{F = \alpha * (h - h_p)^m}, where \eqn{F} is load and \eqn{h} depth measured within a nanoindentation process.
It is possible to set own starting values of the parameters, in the other case these values are calculated by the algorithm and printing into the console.

A selection of the part of the unloading curve fitted by a power law function is provided with \code{lcut} and \code{ucut} arguments. The default values 0.4 and 0.98 corresponds to the range 40-98 \% \eqn{F_{max}} (maximum force) as recommended in ISO 14577 standard.

The \code{CM} has to be a \code{2n} covariance matrix (where \code{n} is length of \code{data}) of following structure: first \code{n} elements of the diagonal correspond to the variance of depth and other to the variance of load.
If argument \code{CM} is missing, the input covariance matrix is set to a diagonal matrix with variance of depth and load (calculated from \code{uh} and \code{uF}) on the diagonal.
If standard deviations are missing too, the default values (\code{uh}=0.5, \code{uF}=0.001) are used.

The estimations and confidence intervals are computed under normality assumption (see \code{\link{OEFPIL}} 'Details').
}
\examples{
##Use of NanoIndent function for data file "silicaBerk.RData" (a part of the OEFPIL package)
signif.level = 0.05
output.form.NI <- NanoIndent.OEFPIL(silicaBerk, unload.data = TRUE, ucut = 0.98, lcut = 0.2,
uh = 0.5, uF = 0.001, signif.level = signif.level)

##The output is an object of class 'OEFPIL', supplementary functions for this class are available
##Use of summary function
summary(output.form.NI)

##Plot of estimated unloading curve
plot(output.form.NI, signif.level = signif.level)

}
\references{
ISO/IEC: \emph{14577-1:2015 Metallic materials – Instrumented indentation test for hardness and materials parameters – Part 1: Test method} (ISO/IEC, Internation Organisation for Standardisation, 2015).

Anna Charvátová Campbell, Petr Grolich, Radek šlesinger. (2019). \emph{Niget: Nanoindentation general evaluation tool}. SoftwareX, \strong{Vol. 9}: 248–254.
\doi{10.1016/j.softx.2019.03.001}.

Köning, R., Wimmer, G. and Witkovský, V. \emph{Ellipse fitting by nonlinear constraints to demodulate quadrature homodyne interferometer signals and to determine the statistical uncertainty of the interferometric phase}. Measurement Science and Technology (2014).
}
\seealso{
\code{\link{OEFPIL}}
}
