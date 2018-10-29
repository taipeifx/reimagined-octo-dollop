#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(readr)
library(timevis)
library(googleVis)
library(dplyr)
library(lubridate)
library(anytime)
#data for shiny app
working_data_merged = read_csv("working_data_merged_time.csv", col_types =cols(category = col_factor(NULL)))

working_data = read_csv("working_data_merged.csv", col_types =cols(category = col_factor(NULL)))
data_table = working_data[c('title', 'author', 'category', 'date', 'link')]
#working_data_merged2[working_data_merged2$category == "R",]$date
#working_data_merged2[working_data_merged2$category == "R",]$end

# Define UI for application that draws a histogram
ui <-  navbarPage(
  title = 'NYCDSA Blog Data',
  id = 'nav',
  theme = shinytheme('spacelab'),
  #cerulean, cosmo, cyborg, darkly, flatly, journal, lumen, paper, readable, sandstone, simplex, slate, spacelab, superhero, united, yeti.
###################### CHART APP 1 tabPanel #############################    
  tabPanel('Overview',
         fluidRow(
           column(3, 
                  h3('NYC Data Science Academy'),
                  selectInput("cat",
                                 h4("Select Category"),
                                 choices = levels(working_data_merged$category),
                                 selected = c('R'),
                                 multiple = TRUE
                                 )),
           column(6,
                  h3('Blog Post Timeline:'),
                  selectInput("end",
                              h4('Versions:'),
                              choices = c("version 1", "version 2"),
                              selected = 'version 1'))
           ),
         fluidRow(
           column(12, 
                  timevisOutput("timeline")
         )
         ),
  
################################################################ DATA TABLE           
#tabPanel('Tables',         
         fluidRow(
           column(12, navbarPage(
                  title = 'Blog Post Data Table',
                  tabPanel("All",                DT::dataTableOutput('ex1')),
                  tabPanel("R",                  DT::dataTableOutput('ex2')),
                  tabPanel("Web Scraping",       DT::dataTableOutput('ex3')),
                  tabPanel("Student Works",      DT::dataTableOutput('ex4')),
                  tabPanel("R Shiny",            DT::dataTableOutput('ex5')),
                  tabPanel("Capstone",           DT::dataTableOutput('ex6')),
                  tabPanel("Machine Learning",   DT::dataTableOutput('ex7')),
                  tabPanel("Meetup",             DT::dataTableOutput('ex8')),
                  tabPanel("R Visualization" ,   DT::dataTableOutput('ex9')),
                  tabPanel("Alumni",             DT::dataTableOutput('ex10')),
                  tabPanel("Data Science News and Sharing", DT::dataTableOutput('ex11')),
                  tabPanel("Community",          DT::dataTableOutput('ex12')),
                  tabPanel("Featured",           DT::dataTableOutput('ex13'))
                  ))
         ))

################################################################ END DATA TABLE
)
###################### SERVER #############################   
server <- function(input, output) {

  v_chart = reactive({ #v_chart returns tt
    tt = filter(working_data_merged, category == input$cat)#sprintf("%s", VP()))
    #tt$date = anytime(tt$date)
    #print(tt$date)
    return(tt) 
  })
  
  end = reactive({ #v_chart returns tt
    if (input$end == "version 1"){
      kk = NA
    } else {
    if (input$end == "version 2"){
      kk = v_chart()$date + hours(12)
    }
    }
    #print(kk)
    return(kk) 
  })
  
  output$timeline <- renderTimevis(
    timevis(  data = data.frame(
      id      = 1:length(v_chart()$title),
      end     = end(), #NA,#v_chart()$date + hours(6),
      content = v_chart()$title,
      group   = v_chart()$category,
      start   = v_chart()$date
      ), 
    groups = data.frame (
      id = unique(droplevels(v_chart()$category)), #unique droplevels
      content = unique(droplevels(v_chart()$category))),
    fit = FALSE, showZoom = TRUE, zoomFactor = 2
    )
  )
  
####################################################################################################################
  ####################################################################################################################
   #################################################################################################################### DATA TABLES
  output$ex1 <- DT::renderDataTable(
    DT::datatable(
      data_table, options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex2 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "R"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex3 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Web Scraping"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex4 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Student Works"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex5 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "R Shiny"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex6 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Capstone"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex7 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Machine Learning"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex8 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Meetup"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex9 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "R Visualization"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex10 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Alumni"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex11 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Data Science News and Sharing"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex12 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Community"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  output$ex13 <- DT::renderDataTable(
    DT::datatable(
      filter(data_table, category == "Featured"), options = list(
        lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
        pageLength = 15
      )
    )
  )
  ####################################################################################################################
  ####################################################################################################################
  #################################################################################################################### end DATA TABLES
  
###################### END SERVER #############################     
}

# Run the application 
shinyApp(ui = ui, server = server)

