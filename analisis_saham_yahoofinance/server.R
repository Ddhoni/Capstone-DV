#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(scales)
library(glue)
library(plotly)
library(dplyr)
library(lubridate)
library(shiny)
library(TTR)
library(quantmod)
library(shinythemes)
library(shinydashboard)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$saham_table <- renderDataTable({
    data <- getSymbols(input$perusahaan, src='yahoo', auto.assign=FALSE)
    
    data <- as.data.frame(data)
    copydata <- data         
    
    copydata <- setDT(data, keep.rownames = TRUE)[]         
    
    names(copydata)[1] <- "Date"
    names(copydata)[2] <- "Open"
    names(copydata)[3] <- "High"
    names(copydata)[4] <- "Low"
    names(copydata)[5] <- "Close"
    names(copydata)[6] <- "Volume"
    names(copydata)[7] <- "Adjusted"
    copydata <- copydata %>% filter(Date >= input$range[1] & Date <= input$range[2])
    copydata
  })
  
  output$openPlotly <- renderPlotly({
    data <- getSymbols(input$perusahaan, src='yahoo', auto.assign=FALSE)
    
    data <- as.data.frame(data)
    copydata <- data         
    
    copydata <- setDT(data, keep.rownames = TRUE)[]         
    
    names(copydata)[1] <- "Date"
    names(copydata)[2] <- "Open"
    names(copydata)[3] <- "High"
    names(copydata)[4] <- "Low"
    names(copydata)[5] <- "Close"
    names(copydata)[6] <- "Volume"
    names(copydata)[7] <- "Adjusted"
    
    copydata$Date <- as.Date(copydata$Date)
    copydata <- copydata %>% filter(Date >= input$range[1] & Date <= input$range[2])
    
    range <- input$range
    OpenPlot <- ggplot(copydata, aes(x = Date, y = Open )) +
      geom_line(col="red")+
      labs(title = "Open Price")+
      theme_light()
    
    ggplotly(OpenPlot)
  })
  
  output$closePlotly <- renderPlotly({
    
    
    data <- getSymbols(input$perusahaan, src='yahoo', auto.assign=FALSE)
    
    data <- as.data.frame(data)
    copydata <- data         
    
    copydata <- setDT(data, keep.rownames = TRUE)[]         
    
    names(copydata)[1] <- "Date"
    names(copydata)[2] <- "Open"
    names(copydata)[3] <- "High"
    names(copydata)[4] <- "Low"
    names(copydata)[5] <- "Close"
    names(copydata)[6] <- "Volume"
    names(copydata)[7] <- "Adjusted"
    
    copydata$Date <- as.Date(copydata$Date)
    copydata <- copydata %>% filter(Date >= input$range[1] & Date <= input$range[2])
    
    ClosePlot <- ggplot(copydata, aes(x = Date, y = Close )) +
      geom_line(col="red")+
      labs(title = "Close Price")+
      theme_light()
    
    ggplotly(ClosePlot)
  })
  
  
  output$volumePlotly <- renderPlotly({
    
    
    data <- getSymbols(input$perusahaan, src='yahoo', auto.assign=FALSE)
    
    data <- as.data.frame(data)
    copydata <- data         
    
    copydata <- setDT(data, keep.rownames = TRUE)[]         
    
    names(copydata)[1] <- "Date"
    names(copydata)[2] <- "Open"
    names(copydata)[3] <- "High"
    names(copydata)[4] <- "Low"
    names(copydata)[5] <- "Close"
    names(copydata)[6] <- "Volume"
    names(copydata)[7] <- "Adjusted"
    
    copydata$Date <- as.Date(copydata$Date)
    copydata <- copydata %>% filter(Date >= input$range[1] & Date <= input$range[2])
    
    volumePlot <- ggplot(copydata, aes(x = Date, y = Close )) +
      geom_line(col="red")+
      labs(title = "Volume Perday")+
      theme_light()
    
    ggplotly(volumePlot)
  })
  
  
  output$scatterPlot <- renderPlotly({
    
    
    
    data <- getSymbols(input$forScatter, src='yahoo', auto.assign=FALSE)
    
    data <- as.data.frame(data)
    copydata <- data         
    
    copydata <- setDT(data, keep.rownames = TRUE)[]         
    
    names(copydata)[1] <- "Date"
    names(copydata)[2] <- "Open"
    names(copydata)[3] <- "High"
    names(copydata)[4] <- "Low"
    names(copydata)[5] <- "Close"
    names(copydata)[6] <- "Volume"
    names(copydata)[7] <- "Adjusted"
    
    copydata$Date <- as.Date(copydata$Date)
    copydata <- copydata %>% filter(Date >= input$range1[1] & Date <= input$range1[2])
    
    copydata <- copydata %>% mutate(label = glue("Date : {Date}
                                                  Price : {input$scotter}"))
    
    ScatterPlot <- ggplot(copydata, aes(x = Date, y = Open)) +
      geom_point(position = "jitter", col = "red")+
      labs(title = "Scotter Plot")+
      theme_light()
    
    # y_copy <- copydata[,"Open"]
    if(input$scotter == "Close"){
      ScatterPlot <- ggplot(copydata, aes(x = Date, y = Close)) +
        geom_point(position = "jitter", col = "red")+
        labs(title = "Scotter Plot")+
        theme_light()
    }else if(input$scotter == "High"){
      ScatterPlot <- ggplot(copydata, aes(x = Date, y = High)) +
        geom_point(position = "jitter", col = "red")+
        labs(title = "Scotter Plot")+
        theme_light()
    }else if(input$scotter == "Low"){
      ScatterPlot <- ggplot(copydata, aes(x = Date, y = Low)) +
        geom_point(position = "jitter", col = "red")+
        labs(title = "Scotter Plot")+
        theme_light()
    }else if(input$scotter == "Volume"){
      ScatterPlot <- ggplot(copydata, aes(x = Date, y = Volume)) +
        geom_point(position = "jitter", col = "red")+
        labs(title = "Scotter Plot")+
        theme_light()
    }else if(input$scotter == "Adjusted"){
      ScatterPlot <- ggplot(copydata, aes(x = Date, y = Adjusted)) +
        geom_point(position = "jitter", col = "red")+
        labs(title = "Scotter Plot")+
        theme_light()
    }
    
    
    
    ggplotly(ScatterPlot)
    
  })
  
}
