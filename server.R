
#load required libraries
library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
  
              #Load data from CSV file
              filepath <-"ACTeams.csv"
              df <- read.csv(filepath)
              
              #Convert Winner field to binary  
              df<-df %>% mutate(WinnerBin=ifelse(Winner=="Defender",1,0))
              
              #Calculate Ratio of Challenger to defenders
              df<-mutate(df,Ratio=Challengers/Defenders)
              
              #determine predicted result dynamically based on user input  
              predictedresult<-reactive({
                                      #Filter based on user selection to include/not include  
                                      if(input$MatchFilter) {df<-filter(df,Type=="Match")}
                                      
                                      #build binomial model
                                      fit<-glm(WinnerBin~Ratio,data=df, family="binomial")
                                      
                                      #predicted results from data set
                                      predictdata<-predict(fit,type="response")
                                      
                                      #calculate the Challenger to Defender Ratio from user selection
                                      inputratio<-input$NumberChallengers/input$NumberDefenders
                                      
                                      #Calculate predicted result from Binomal model
                                      predicted <-predict(fit,newdata=data.frame(Ratio=inputratio))
                                      
                                      #Return ration and text of result
                                      # assumes if result is > 0.5 Defender is more likely to win
                                      if(predicted >= 0.5) {output$result<-renderText({"Defender"})}
                                      else {output$result<-renderText({"Challenger"})}
                                      
                                      output$SelectedRatio <- renderText({
                                                                        input$NumberChallengers/input$NumberDefenders})
                                      
                                      #set value result
                                      predicted
              
                                      }) 
              #returns data table
              output$filetable <- renderTable({ df })
              
              #generate prediction plot
              output$Gplot <- renderPlot({
   
                                    inputratio<-input$NumberChallengers/input$NumberDefenders
                                    #build binomial model
                                    fit<-glm(WinnerBin~Ratio,data=df, family=binomial)
                                    
                                    #predicted results from data set
                                    predictdata<-predict(fit,type="response")
                                    
                                    #generate plot
                                    ggplot(data=df,aes(y=WinnerBin,x=Ratio)) +   
                                      geom_point(size = 3,col="red") +  #plot historical Data
                                      xlab("Challenger / Defender Ratio") +   
                                      ylab("Winner") +  
                                      scale_y_continuous(breaks=c(0,1),labels= c("Challenger","Defender")) +
                                      geom_point(aes(y=predictedresult(),x=inputratio),size=5,col="blue") +   #plot predicted result
                                      geom_hline(yintercept = 0.5,linetype="dashed", color="blue")  #plot threshold
                                        })
              
              #prepare images for UI
              output$ACImage <- renderImage({
                                            list(
                                              src = "AC.jpg",
                                              filetype = "image/jpeg",
                                              height=200)
                                            }, deleteFile=FALSE)
              
              output$TeamNZImage <- renderImage({
                                                list(
                                                  src = "TeamNZ.jpg",
                                                  filetype = "image/jpeg",
                                                  height=200)
                                                },deleteFile=FALSE)
          


            })#function  
    
