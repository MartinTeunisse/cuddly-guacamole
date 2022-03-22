server <- function(input, output) {
  
  output$algemeen<- renderTable({input$files})
  
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
      write.csv(upload[[1]], file)}
    )
    
    output$dwd3 <-downloadHandler(filename = function(){
      paste("data", "Aanpasbaar_iets", ".csv", sep = ",")
    },
    content = function(file){
      write.csv(upload[[2]], file)
      
    })
    return(upload)
  })
    
    

  
}