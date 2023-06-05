#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

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


# Define UI for application that draws a histogram
ui <-dashboardPage( 
  dashboardHeader(title = "Analisis Saham"),skin = "red",
  
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Overview", tabName = "data", icon = icon("table")),
      menuItem(text = "Sebaran Nilai", tabName = "sebaran", icon = icon("chart-bar"))
      
      
    )
  ),
  
  
  dashboardBody(
    
    tabItems(
      
      tabItem(
        tabName = "data", 
        fluidPage(
          box(
            
            width = 6,
            selectInput(inputId = "perusahaan",
                        label = "Pilih Perusahaan",
                        choices = c("Darya-Varia Laboratoria Tbk. (DVLA)" = "DVLA.JK",
                                    "Indofarma Tbk. (INAF)" = "INAF.JK",
                                    "Kimia Farma Tbk. (KAEF)" = "KAEF.JK",
                                    "Kalbe Farma Tbk. (KLBF)" = "KLBF.JK",
                                    "Mitra Keluarga Karyasehat Tbk. (MIKA)" = "MIKA.JK",
                                    "Prodia Widyahusada Tbk. (PRDA)" = "PRDA.JK",
                                    "Industri Jamu dan Farmasi Sido (SIDO)" = "SIDO.JK",
                                    "Siloam International Hospitals (SILO)" = "SILO.JK",
                                    "Sejahteraraya Anugrahjaya Tbk. (SRAJ)" = "SRAJ.JK",
                                    "Tempo Scan Pacific Tbk. (TSPC)" = "TSPC.JK"
                                    
                                    
                        ),
                        selected = "DVLA.JK")
            
          ), 
          box(
            width = 6,
            dateRangeInput(inputId = "range", label = "Pilih Range Tanggal", start = "2020-01-01", end = now())
          )
        ),
        
        
        
        
        
        fluidPage(
          
          box(
            width = 6,
            plotlyOutput(outputId = "openPlotly")
          ),
          box(
            width = 6,
            plotlyOutput(outputId = "closePlotly")
          )
          
        ),
        
        fluidPage(
          
          box(
            width=12,
            plotlyOutput(outputId = "volumePlotly")
          )
        ),
        
        fluidPage(
          title = "Data Saham",
          width = 12,
          box(
            width=12,
            dataTableOutput(outputId = "saham_table")
          )
          
        )
        
      ), 
      
      
      tabItem(
        tabName = "sebaran",
        
        fluidPage(
          box(
            
            width = 6,
            selectInput(inputId = "forScatter",
                        label = "Pilih Perusahaan",
                        choices = c("Darya-Varia Laboratoria Tbk. (DVLA)" = "DVLA.JK",
                                    "Indofarma Tbk. (INAF)" = "INAF.JK",
                                    "Kimia Farma Tbk. (KAEF)" = "KAEF.JK",
                                    "Kalbe Farma Tbk. (KLBF)" = "KLBF.JK",
                                    "Mitra Keluarga Karyasehat Tbk. (MIKA)" = "MIKA.JK",
                                    "Prodia Widyahusada Tbk. (PRDA)" = "PRDA.JK",
                                    "Industri Jamu dan Farmasi Sido (SIDO)" = "SIDO.JK",
                                    "Siloam International Hospitals (SILO)" = "SILO.JK",
                                    "Sejahteraraya Anugrahjaya Tbk. (SRAJ)" = "SRAJ.JK",
                                    "Tempo Scan Pacific Tbk. (TSPC)" = "TSPC.JK"
                                    
                                    
                        ),
                        selected = "DVLA.JK"),
            dateRangeInput(inputId = "range1", label = "Pilih Range Tanggal", start = "2020-01-01", end = now())
            
            
            
          ), 
          
          box(
            width = 6,
            radioButtons(inputId = "scotter", label = "Pilih Data", 
                         choices = c("Open", "High",  "Low", "Close", "Volume","Adjusted"), selected = "Open")          
          )
          
          
        ),
        
        fluidPage(
          
          box(
            width=12,
            plotlyOutput(outputId = "scatterPlot")
          )
        )
        
        
      )
      
      
    )
    
    
  )
  
)

