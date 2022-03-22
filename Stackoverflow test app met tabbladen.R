# # creating sample files to upload
# write.csv2(
#   x = "diff same", 
#   file = "test.csv"
# )
# 
# write.csv2(
#   x = "diffhere same", 
#   file = "test2.csv"
# )
library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId = "files", label = "Choose CSV File", multiple = TRUE, accept = c("text/csv",
                   "text/comma-separated-values,text/plain",".csv")
      )#, 
      #downloadButton("dwd", "you can download by clicking on me"), 
    ),
    mainPanel(
      
      tabsetPanel(type = "tabs", 
                  tabPanel(title = "Summary of all classes",downloadButton("dwd", "you can download by clicking on me"), tableOutput("contents")),
                  tabPanel(title = "Test1",downloadButton("dwd2", "you can download by clicking on me"), tableOutput("test1")),
                  tabPanel(title = "Test2",downloadButton("dwd3", "you can download by clicking on me"), tableOutput("test2"))
                  
                  
                  )
      
    )
  )
)

server <- function(input, output) {
 
  output$test1<- renderTable({read.csv2(
    file = input$files[[1, 'datapath']]
  )
    
    })  
  output$test2<- renderTable({read.csv2(
    file = input$files[[2, 'datapath']]
  )
    
    })  
  
   output$contents <- renderTable({
    
    req(input$files)
    upload = list()
    
    for(nr in 1:length(input$files[, 1])){
      
      upload[[nr]] <- read.csv2(
        file = input$files[[nr, 'datapath']]
      )
    }
    
    
    print("hier wordt upload geprint")
    print(upload)
    
    upload[[3]]$Mean[1]=  mean(upload[[1]]$RT)
    upload[[3]]$Mean[2]=  mean(upload[[2]]$RT)

    output$dwd <-downloadHandler(filename = function(){
     paste("data", "Aanpasbaar_iets", ".csv", sep = ",")
    },
    content = function(file){
      write.csv(upload, file)
      
    })
    
    output$dwd2 <-downloadHandler(filename = function(){
     paste("data", "Aanpasbaar_iets", ".csv", sep = ",")
    },
    content = function(file){
      write.csv(upload[[1]], file)
      
    }
    
    )
    output$dwd3 <-downloadHandler(filename = function(){
     paste("data", "Aanpasbaar_iets", ".csv", sep = ",")
    },
    content = function(file){
      write.csv(upload[[2]], file)
      
    }
    
    )
    
    return(upload)
  })

}

shinyApp(ui, server)


source("hoi.R")
