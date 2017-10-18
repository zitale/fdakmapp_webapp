library(shiny)
library(fdakmapp)


shinyServer(function(input, output) {
  
  observeEvent(input$run, {
    
    b <- as.numeric(unlist(strsplit(input$vec1,",")))
    
    
    
    # # #simulated data
    x<-simulated30$x
    y<-simulated30$y
    n_clust <-3
    
    # #aneurisk data
    x<-aneurisk65$x
    y<-aneurisk65$y
    n_clust <-2
    
    
    # #  # PAZIENTE 1
    # load("../../data/control1.RData")
    # y<-data
    # y1<-data
    # x<-grid
    # n_clust<-1
    #
    #
    
    
    # select seeds (random if null)
    seeds<-NULL
    #seeds<-res$seeds
    ############# Choose warping method: #################
    
    warping_method <- "affine"
    warping_opt<-c(0.15,0.15) # c(max_dilation,max_shift)
    
    # warping_method <- "dilation"
    # warping_opt<-c(0.15) # c(max_dilation)
    #
    # warping_method <- "shift"
    # warping_opt<-c(0.15) # c(max_shift)
    #
    # warping_method <- "noalign"
    # warping_opt<-as.numeric()
    
    
    ############# Choose center method: #########
    # center_method <- "medoid"
    # center_opt <- as.numeric()
    
    # center_method <- "pseudomedoid"
    # center_opt <- as.numeric()
    #
    center_method <- "mean"
    center_opt <- c(0.01,0.1) # c(span,delta)
    
    ############ Choose similarity and optim: #############
    similarity_method <- "pearson"
    optim_method <- "bobyqa"
    
    ############ Output_options
    out_opt<- c(100 , 0.001 , 100) #c(n_out , tollerance, max_iteration)
    fence <- FALSE
    check_total_similarity <- TRUE
    com_oc<-TRUE
    show_iter <- TRUE
    par_opt<-c(4,0) ## c(num_threads, kind of parallelization)
    
    ############# EXE ##########################
    
    res<-kmap(  x, y, seeds, n_clust,
                warping_method, center_method, similarity_method, optim_method,
                warping_opt, center_opt, out_opt,
                fence, check_total_similarity, show_iter,com_oc,par_opt)
    
    
  })
  output$distPlot <- renderPlot({

  })

})
