library(shiny)
source("script.R")


shinyServer(function(input, output) {
  
  exe <- eventReactive(input$run, {
    library(fdakmapp)
    
    print("RUNNING")
    
    #dataset
    if(input$dataset == "simulated30"){
      x<-simulated30$x
      y<-simulated30$y
    }
    if(input$dataset == "aneurisk65"){
      x<-aneurisk65$x
      y<-aneurisk65$y
    }

    # ## seeds
    # seeds<-NULL
    # if(input$vec1!="")
    #   seeds<- as.numeric(unlist(strsplit(input$vec1,",")))
    #
    # #if(length(seeds)!=input$n_cluster)

    ############# Choose warping method: #################

    warping_method <- "affine"
    warping_opt<-c(0.15,0.15) # c(max_dilation,max_shift)

    center_method <- "mean"
    center_opt <- c(0.01,0.1) # c(span,delta)

    similarity_method <- "pearson"
    optim_method <- "bobyqa"

    out_opt<- c(100 , 0.001 , 100) #c(n_out , tollerance, max_iteration)
    fence <- FALSE
    check_total_similarity <- TRUE
    com_oc<-TRUE
    show_iter <- TRUE
    par_opt<-c(4,0) ## c(num_threads, kind of parallelization)
    seeds<-NULL
    n_clust<-2
    res<-kmap(  x, y, seeds, n_clust,
                warping_method, center_method, similarity_method, optim_method,
                warping_opt, center_opt, out_opt,
                fence, check_total_similarity, show_iter,com_oc,par_opt)
    res
  })
  
  output$plot <- renderPlot({
    print_original(exe())
  })
  
  output$plot1 <- renderPlot({
    print_original(exe())
  })
  
  output$plot2 <- renderPlot({
    print_original(exe())
  })
})
