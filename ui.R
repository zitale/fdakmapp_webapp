
library(shiny)
library(shinythemes)


shinyUI(fluidPage(theme= shinytheme("cerulean"),
                  
                  # Application title
                  titlePanel("Fdakmapp Live Testing App"),
                  
                  # Sidebar with a slider input for number of bins
                  sidebarLayout(
                    
                    sidebarPanel(
                      
                      ## RUN BUTTON
                      actionButton("run", "Run"),
                      
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
                      
                  
                      sliderInput("n_cluster",
                                  "Number of clusters:",
                                  min = 1,
                                  max = 10,
                                  value = 3),
                      
                      #seeds

                      textInput('vec', 'Enter seeds(comma delimited). If empty random seeds.'),
                      
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
                      checkboxInput("fence", "Fence Check", FALSE)
                    ),
                    
                    # Show a plot of the generated distribution
                    mainPanel(
                      # fluidRow(
                      # column(12,plotOutput("alignPlot"))
                      # ),
                      # fluidRow(
                      #   column(12,plotOutput("originPlot"))
                      # )
                    ) ## FINE MAIN PANNEL
                    
                  )## FINE SIDEBAR LAYOUT
                  
))
