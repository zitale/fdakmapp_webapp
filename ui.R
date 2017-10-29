
library(shiny)
library(shinythemes)


shinyUI(fluidPage(theme= shinytheme("cerulean"),
                  
                  # Application title
                  titlePanel("Fdakmapp Live Testing App"),
                  
                  # Sidebar with a slider input for number of bins
                  sidebarLayout(
                    
                    sidebarPanel(
                      # Input: Selector for choosing dataset
                      selectInput(inputId = "dataset",
                                  label = "Choose a dataset:",
                                  choices = c("simulated30", "aneurisk65","custom")),
                      
                      conditionalPanel(
                        condition = "input.dataset == 'custom'",
                        # Input: Select a file ----
                        fileInput("file", "or Choose RData File",
                                  multiple = TRUE,
                                  accept = c(".RData"))
                      
                      ),
                      
                  
                      numericInput("n_cluster",
                                  "Number of clusters: \ (default 2)",2),
                      
                      #seeds

                      textInput('seeds', 'Enter seeds(comma delimited). If empty random seeds.'),
                      
                      radioButtons(inputId="center_method", label="Select center method",
                                   choices=c("medoid","mean")),
                      
                      conditionalPanel(
                        condition = "input.center_method == 'mean'",
                        sliderInput("span",
                                    "Span:",
                                    min = 0,
                                    max = 1,
                                    value = 0.15)
                      ),
                      conditionalPanel(
                        condition = "input.center_method == 'mean'",
                        sliderInput("delta",
                                    "Delta:",
                                    min = 0.1,
                                    max = 1,
                                    value = 0)
                      ),
                      
                      radioButtons(inputId="warping_method", label="Select warping method",
                                   choices=c("noalign","shift","dilation","affine")),
                      
                      conditionalPanel(
                        condition = "input.warping_method == 'affine'",
                        sliderInput("max_shift",
                                    "Max shift:",
                                    min = 0,
                                    max = 1,
                                    value = 0.15),
                        
                        sliderInput("max_dilation",
                                    "Max dilation:",
                                    min = 0,
                                    max = 1,
                                    value = 0.15)
                      ),
                      
                      conditionalPanel(
                        condition = "input.warping_method == 'shift'",
                        sliderInput("max_shift",
                                    "Max shift:",
                                    min = 0,
                                    max = 1,
                                    value = 0.15)
                      ),
                      
                      conditionalPanel(
                        condition = "input.warping_method == 'dilation'",
                        sliderInput("max_dilation",
                                    "Max dilation:",
                                    min = 0,
                                    max = 1,
                                    value = 0.15)
                      ),
                      
                      radioButtons(inputId="similarity_method", label="Choose dissimilarity measure:",
                                   choices=c("pearson","l2")),
                      
                      checkboxInput("total_sim", "Check total similarity", TRUE),
                      
                      ## RUN BUTTON
                      actionButton("run", "Run", icon("paper-plane"), 
                                   style="color:  #2e6da4; background-color: #337ab7; border-color: #2e6da4")
                    ),
                    
                    # Show a plot of the generated distribution
                    mainPanel(
                      
                      fluidRow(
                      column(6,plotOutput(outputId="plotoriginal")),
                      column(6,plotOutput(outputId="plotresult"))
                      ),
                      fluidRow(
                        column(6,plotOutput(outputId="plotwarping")),
                        column(6,plotOutput(outputId="plotsim"))
                      )
                    ) ## FINE MAIN PANNEL
                    
                  )## FINE SIDEBAR LAYOUT
                  
))
