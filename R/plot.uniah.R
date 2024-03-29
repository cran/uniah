plot.uniah=function(x, lty=1, lcol=1, lwd=1, pch=19, pcol=1, pcex=0.7, main=NULL, ylab=NULL, xlab=NULL, lglab=NULL, lgloc=NULL, lgcex=0.9, ylim=NULL, xlim=NULL, ...){
  y=x$psi$psi
  z=x$psi$z

  n=length(y)
  y.obs=y[2:(n-1)] #first and last values are not potential jump points
  z.obs=z[2:(n-1)]
  
  if(is.null(main)) main=paste("Additive hazards model with ",x$shape," cov eff",sep="")
  if(is.null(xlab)) xlab="z"
  if(is.null(xlim)) xlim=range(z)
  
  if(is.null(lglab)) lglab="Potential jump points (or covs assoc with status=1)"

  if(is.null(lgloc)){
    if(x$shape=='unimodal'){     lgloc='topleft'
    }else if(x$shape=='ushape'){ lgloc='topleft' 
    }
  }  
  
  if(is.null(ylab)) ylab="Risk difference"#expression("Risk difference (or"~hat(psi)(z)~")")
  if(is.null(ylim)) ylim=range(y)
    
  plot(y~z,type='s', main=main, xlab=xlab, ylab=ylab, xlim=xlim, ylim=ylim, col=lcol, lty=lty, lwd=lwd)
  if( is.character(pch) || (is.numeric(pch) & is.finite(pch)) )
    points(y.obs~z.obs, pch=pch, col=pcol, cex=pcex)

  #legends
  if(!is.na(lglab))
    legend(x=lgloc, legend=lglab, pch=pch, col=pcol, bty='n', cex=lgcex)  
}
