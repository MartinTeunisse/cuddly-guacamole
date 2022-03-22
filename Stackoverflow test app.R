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


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId = "files", label = "Choose CSV File", multiple = TRUE, accept = c("text/csv",
                   "text/comma-separated-values,text/plain",".csv")
      ), 
      downloadButton("dwd", "you can download by clicking on me"), 
    ),
    mainPanel(
      tableOutput("contents")
    )
  )
)

server <- function(input, output) {
 
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
      
    }
      
    )
    
    return(upload)
  })

}

shinyApp(ui, server)
