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
                  tabPanel(title = "Uploaded classes", tableOutput("algemeen")),
                  tabPanel(title = "Summary of all classes",downloadButton("dwd", "you can download by clicking on me"), tableOutput("contents")),
                  tabPanel(title = "Test1",downloadButton("dwd2", "you can download by clicking on me"), tableOutput("test1")),
                  tabPanel(title = "Test2",downloadButton("dwd3", "you can download by clicking on me"), tableOutput("test2"))
                  
                  
      )
      
    )
  )
)
