\name{uniah}
\alias{uniah}
\title{Fit Unimodal Additive Hazards Model}
\description{Nonparametric estimation of a unimodal or U-shape covariate effect for additive hazard model.}
\usage{
uniah(formula, x, data, shape, mode, M, maxiter, eps, maxdec)
}
\arguments{
  \item{formula}{a formula object: a response ~ a univariate covariate. The response must be survival outcome unsing the Surv function. For interval data, each subject's starting time must be set to 0.}
  \item{x}{Treatment group. It must be coded by 0 or 1. This argument is an optional (default is NULL)}
  \item{data}{data.frame or list that includes variables named in the formula argument.}
  \item{shape}{direction of the covariate effect on the hazard function, "unimodal" or "ushape"}
  \item{mode}{mode of the unimodal or ushape hazard function, "known" or "unknown"}
  \item{M}{A value for mode, which is only requred when mode="known".}
  \item{maxiter}{maximum number of iteration (default is 10^3).}
  \item{eps}{stopping convergence criteria (default is 10^-3).}
  \item{maxdec}{maximum number of decisimal for output (default is 3).}
}
\details{The uniah function allows to analyze shape restricted additive hazards model, defined as
\deqn{ \lambda(t|z,x)=\lambda0(t)+\psi(z)+\beta x, }
where \eqn{ \lambda0 } is a baseline hazard function, and \eqn{ \psi } is a unimodal or ushaped function, \eqn{z} is a univariate covariate, \eqn{\beta} is a regression parameter and \eqn{x} is a binary covariate. One point at mode is fixed with \eqn{ \psi(M)=0 }. For known mode, \eqn{M} has to be prespecified. For unknown mode, \eqn{M} does not have to be fixed. A direction of \eqn{ \psi } is defined as unimodal or ushape prior to data analysis. Monotone covariate effects are also considered by setting a mode to the left or right end point of \eqn{Z}. Quadratic pool adjacent violators algorithm is used.
}
\references{Yunro Chung, Anastasia Ivanova, Michael M. Hudgens, Jason P. Fine, Shape restricted addtive hazards model (in preparation).}
\author{Yunro Chung [cre], Anastasia Ivanova, Michael G. Hudgens and Jason P. Fine}

\examples{
#require(Iso)
#require(survival)
#require(ahaz)

###
# 1. unimodal with known mode
###
# 1.1. create a test data set
test1=list(
  time=  c(9, 7, 5, 9, 5, 3, 8, 7, 9, 7),
  status=c(1, 1, 0, 1, 0, 1, 1, 1, 1, 1),
  z=     c(2, 8, 1, 3, 2, 4, 4, 6, 8, 3)
)

# 1.2. Fit isotonic proportional hazards model
res1=uniah(Surv(time,status)~z, data=test1, shape='unimodal', mode='known', M=5)

# 1.3. print result
res1

# 1.4 figure
plot(res1)

###
# 2. unimodal with known mode with treatment group
###
# 2.1. create a test data set 1
test1=list(
  time=  c(2, 7, 3, 7, 8, 1, 2, 2, 9, 8),
  status=c(1, 0, 1, 1, 1, 0, 0, 1, 1, 0),
  z=     c(4, 9, 5, 5, 1, 3, 8, 8, 1, 2),
  x=     c(1, 1, 1, 1, 1, 0, 0, 0, 0, 0)
)

# 2.2. Fit isotonic proportional hazards model
res2=uniah(Surv(time,status)~z, x=x, data=test1, shape='unimodal', mode='known', M=6)

# 2.3. print result
res2

# 2.4 figure
plot(res2)

###
# 3. ushape with unknown mode
###
# 3.1. create a test data set
test3=list(
  time=  c(3, 4, 5, 4, 1, 8, 1, 9, 2, 8, 2, 5, 7, 2, 2, 3, 3, 1, 1, 8),
  status=c(1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1),
  z=     c(10,4, 6, 9, 2, 9, 9, 7, 6, 1, 2, 2, 7, 4, 8, 5, 7,10, 4, 8)
)

# 3.2. Fit isotonic proportional hazards model
res3=uniah(Surv(time,status)~z, data=test3, shape='ushape', mode='unknown')

# 3.3 print result
res3

# 3.4 Figure
plot(res3)

###
# 4. More arguments for plot.uniah (S3method)
###
# 4.1 renames labels
plot(res3, main="Ush", ylab="RD", xlab="Cov", lglab="Cov wt obs", lgloc="center", lgcex=1.5)

# 4.2 removes labels and changes line and point parameters
plot(res3, main=NA, ylab=NA, xlab=NA, lglab=NA, lty=2, lcol=2, lwd=2, pch=3, pcol=4, pcex=1.5)

}
\keyword{Unimodal regression, Survival analysis, Constrained estimation}
