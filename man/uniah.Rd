\name{uniah}
\alias{uniah}
\title{Fit Unimodal Additive Hazards Model}
\description{Nonparametric estimation of a unimodal or U-shape covariate effect for additive hazard model.}
\usage{
uniah(formula, trt, data, shape, mode, M, maxdec, maxiter, eps)
}
\arguments{
  \item{formula}{a formula object: a response ~ a univariate covariate. The response must be survival outcome unsing the Surv function.}
  \item{trt}{Treatment group. It must be coded by 0 or 1. This argument is optional.}
  \item{data}{data.frame or list that includes variables named in the formula argument.}
  \item{shape}{direction of the covariate effect on the hazard function, "unimodal" or "ushape"}
  \item{mode}{mode of the unimodal or ushape hazard function, "known" or "unknown" (default is "unknown").}
  \item{M}{A value for mode, which is only requred when mode="known".}
  \item{maxdec}{maximum number of decisimal for output (default is 3).}
  \item{maxiter}{maximum number of iteration (default is 10^3).}
  \item{eps}{stopping convergence criteria (default is 10^-3).}
}
\details{The uniah function allows to analyze shape restricted additive hazards model, defined as
\deqn{ \lambda(t|z,trt)=\lambda0(t)+\psi(z)+\beta trt, }
where \eqn{ \lambda0 } is a baseline hazard function, \eqn{ \psi } is a unimodal or U-shaped function, \eqn{z} is a univariate variable, \eqn{\beta} is a regression parameter, and \eqn{trt} is a binary treatment group variable. One point at mode has to be fixed with \eqn{ \psi(M)=0 } for model identifiability. For known mode (mode="known"), \eqn{M} has to be prespecified, and (\eqn{ \psi, \beta}) is estimated given the prespecified \eqn{M}. For unknown mode (mode="unknown"), \eqn{M} is not needed, and  (\eqn{ \psi , \beta, M}) is estimated by profiling all hypothetical modes. A direction of \eqn{ \psi } is defined as unimodal or ushape prior to data analysis. Monotone covariate effects are also considered by setting a mode to the left or right end point of \eqn{Z}.
}
\value{A list of class isoph:
\item{est}{results.}
\item{psi}{estimated \eqn{\psi} at z}
\item{beta}{estimated \eqn{\beta}.}
\item{conv}{algorithm convergence status.}
\item{M}{Predetermined model if mode="known" or estimated mode if mode="unknown".}
\item{shape}{Direction of \eqn{\psi}.}
\item{call}{Specified arguments that are specified in the model.}
}

\references{Yunro Chung, Anastasia Ivanova, Jason P. Fine, Shape restricted addtive hazards model (in preparation).}
\author{Yunro Chung [aut, cre]}

\examples{
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
test2=list(
  time=  c(2, 7, 3, 7, 8, 1, 2, 2, 9, 8),
  status=c(1, 0, 1, 1, 1, 0, 0, 1, 1, 0),
  z=     c(4, 9, 5, 5, 1, 3, 8, 8, 1, 2),
  trt=   c(1, 1, 1, 1, 1, 0, 0, 0, 0, 0)
)

# 2.2. Fit isotonic proportional hazards model
res2=uniah(Surv(time,status)~z, trt=trt, data=test2, shape='unimodal', mode='known', M=6)

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
# 4. More arguments for plot.uniah
###
# 4.1 renames labels
#plot(res3, main="Ush", ylab="RD", xlab="Cov", lglab="Cov wt obs", lgloc="center", lgcex=1.5)

# 4.2 removes labels and changes line and point parameters
#plot(res3, main=NA, ylab=NA, xlab=NA, lglab=NA, lty=2, lcol=2, lwd=2, pch=3, pcol=4, pcex=1.5)
}
