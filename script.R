
print_original<-function(Result){
  
  
  r<-Result
  n.dim<-dim(r$y)[3]
  par(mfrow=c(n.dim,1))
  var<-c("x","y","z")
  for (l in 1:n.dim) {
    
    matplot(t(r$x), t(r$y[, , l]), type = "l", lwd = 1, xlab = "t", ylab = var[l])
    title(main = paste(c("Original Data, dimension ", l), collapse = ""))
    lines(r$x.center.orig, r$y.center.orig[l, ],lwd = 3, col = "red")
  }
  
  
}


print_result<-function(Result){
  
  
  r<-Result
  n.dim<-dim(r$y)[3]
  n.obs<-dim(r$y)[1]
  par(mfrow=c(n.dim,1))
  var<-c("x","y","z")
  
  
  ## colors
  myrainbow <- c("red", "blue", "green3", "orange", "grey", "yellow")
  myrainbowdark <- c("darkred", "darkblue", "darkgreen", "darkorange", "black", "brown")
  
  colori.dopo <- rainbow(length(unique(r$labels)))
  myrainbow <- c(myrainbow, colori.dopo)
  myrainbow <- myrainbow[1:r$n.clust.final]
  
  myrainbow.dark <- c(myrainbowdark, colori.dopo)
  myrainbow.dark <- myrainbowdark[1:r$n.clust.final]
  
  colours.bygroup<- rep(0,n.obs )
  coloursdark.bygroup<- rep(0,n.obs )
  for (k in unique(r$labels)) {
    colours.bygroup[which(r$labels == k)] <- myrainbow[k]
    coloursdark.bygroup[which(r$labels == k)] <- myrainbowdark[k]
  }
  for (l in 1:n.dim) {

    matplot(t(r$x.final), t(r$y[, , l]), type = "l", col = coloursdark.bygroup,
            xlab = "x", ylab = var[l])

    title22 <- paste(c("Aligned Data; dimension ", l), collapse = "")
    title(main = title22)

    for (k in unique(r$labels)) {
      col_cl<-myrainbow
      lines(r$x.centers.final, r$y.centers.final[k,,l], lwd = 3, col = col_cl[k])
    }

    text <- rep(0, length(unique(r$labels)))
    for (i in 1:length(unique(r$labels))) {
      text[i] <-paste("Cluster ", i)
    }
    lty <- rep(1, length(text))
    legend("topright", legend = text,col=unique(coloursdark.bygroup),lty = lty, cex = 0.6)
  }

}

#
#      print warping functions
#

print_warping<-function(r){
  
  n.obs<-dim(r$y)[1]
  #colori
  myrainbow <- c("red", "blue", "green3", "orange", "grey", "yellow")
  colori.dopo <- rainbow(length(unique(r$labels)))
  myrainbow <- c(myrainbow, colori.dopo)
  myrainbow <- myrainbow[1:r$n.clust.final]
  
  colours.bygroup<- rep(0,n.obs )
  for (k in unique(r$labels)) {
    colours.bygroup[which(r$labels == k)] <- myrainbow[k]
  }
  colours.warping <- rep(0, n.obs)
  
  for (k in unique(r$labels)) {
    colours.warping[which(r$labels == k)] <- myrainbow[k]
  }
  
    plot(t(r$x[1, ]), t(r$x.final[1, ]), xlim = c(min(r$x, na.rm = TRUE),
        max(r$x, na.rm = TRUE)), ylim = c(min(r$x, na.rm = TRUE),
        max(r$x, na.rm = TRUE)), type = "l", lwd = 1, col = colours.warping[1],
        xlab = "x", ylab = "y", asp = 1)
  
      for (i in 2:n.obs) {
          lines(t(r$x[i, ]), t(r$x.final[i, ]), type = "l", lwd = 1,
              col = colours.warping[i], xlab = "x", ylab = "y",
              asp = 1)
      }
      title3 <- c("Registration: ", r$warping.method)
      title3 <- paste(title3, collapse = "")
      title33 <- c("Warping Functions")
      title3def <- c(title3, title33)
      title(main = title3def)
      abline(v = min(r$x))
      abline(v = max(r$x))

}

print_box<-function(r){

      if (r$similarity.method == "pearson") {
        boxplot(-r$similarity.origin, -r$similarity.final, notch = FALSE, boxwex = 0.3,
                col = c("grey", "orange"), ylim = c(min(-r$similarity.origin,
                                                        -r$similarity.final), 1))
      }
      if (r$similarity.method == "l2") {
        boxplot(r$similarity.origin,
                r$similarity.final, notch = FALSE, boxwex = 0.3,
                col = c("grey", "orange"), ylim = c(min(r$similarity.origin,
                                                        r$similarity.final),
                                                    max(r$similarity.origin,
                                                        r$similarity.final)))
      }
      
      
      # creo testo
      text <- rep(0, length(unique(r$labels)))
      for (i in 1:length(unique(r$labels))) {
        text[i] <-paste("Cluster ", i)
      }
      
      lty <- rep(1, length(text))
      # legend(x = min(x), y = max(x), legend = text, col = colours.templates.last,
      #        lty = lty, cex = 0.6)
      etichette <- rep(0, 2)
      etichette[1] <- "orig. data"
      etichette[2] <- paste("k =", r$n.clust)
      title4 <- c("Registration: ", r$warping.method)
      title4 <- paste(title4, collapse = "")
      title44 <- c("Boxplot Similarity Indexes")
      title4def <- c(title4, title44)
      title(main = title4def)
      axis(1, at = 1:2, labels = etichette, las = 0)
}


