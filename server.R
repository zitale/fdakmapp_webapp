library(shiny)
library(fdakmapp)
source("script.R")



shinyServer(function(input, output) {
  
  exe <- eventReactive(input$run, {
    library(fdakmapp)
    
    #dataset
    if(input$dataset == "simulated30"){
      x<-simulated30$x
      y<-simulated30$y
    }
    if(input$dataset == "aneurisk65"){
      x<-aneurisk65$x
      y<-aneurisk65$y
    }
     n_clust<-input$n_cluster
    seeds<-NULL
    if(input$seeds!="")
      seeds<-as.numeric(unlist(strsplit(input$seeds,",")))
      
    if(length(seeds)!=input$n_cluster & is.null(seeds)==FALSE)
      stop("length seeds must be == n_clust")
    
    ############# Choose warping method: #################
    warping_method <- input$warping_method
    warping_opt<-as.numeric()
    if(warping_method=="affine")
      warping_opt<-c(input$max_dilation,input$max_shift)
    if(warping_method=="dilation")
      warping_opt<-c(input$max_dilation)
    if(warping_method=="shift")
      warping_opt<-c(input$max_shift)
    
    
    center_method <- input$center_method
    center_opt <- as.numeric()
    if(center_method=="mean")
      center_opt<-c(input$span,input$delta)

    similarity_method <- input$similarity_method
    optim_method <- "bobyqa"

    out_opt<- c(100 , 0.001 , 100) #c(n_out , tollerance, max_iteration)
    
    com_oc<-TRUE
    fence<-FALSE
    check_total_similarity <- TRUE
    show_iter <- TRUE
    par_opt<-c(1,0) ## c(num_threads, kind of parallelization)
    
    res<-kmap(  x, y, seeds, n_clust,
                warping_method, center_method, similarity_method, optim_method,
                warping_opt, center_opt, out_opt,
                fence, check_total_similarity, show_iter,com_oc,par_opt)
    res
  })
  
  output$plotoriginal <- renderPlot({
    print_original(exe())
  })
  
  output$plotresult <- renderPlot({
    print_result(exe())
  })
  
  output$plotwarping <- renderPlot({
    print_warping(exe())
  })
  
  output$plotsim<- renderPlot({
    print_box(exe())
  })
  
})
