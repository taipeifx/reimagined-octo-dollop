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
library(shinydashboard)
library(DT)
#data for shiny app
working_data_merged = read_csv("working_data_merged_time.csv", col_types =cols(category = col_factor(NULL)))

working_data = read_csv("working_data_merged.csv", col_types =cols(category = col_factor(NULL)))
data_table = working_data[c('title', 'author', 'category', 'date', 'link')]
lda = read_csv("interactive_lda.csv")
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
        column(8,
               h3('NYCDSA Blog Post Timeline:'),
         fluidRow(
           column(5, 
                  selectInput("cat",
                                 h4("Select Category"),
                                 choices = levels(working_data_merged$category),
                                 selected = c('R'),
                                 multiple = TRUE
                                 )),
           column(2,
                  #h3('Blog Post Timeline:'),
                  selectInput("end",
                              h4('Versions:'),
                              choices = c("version 1", "version 2"),
                              selected = 'version 1'))
           ))),
         fluidRow(
           column(12, 
                  timevisOutput("timeline")
         )
         ),hr(),
  
################################################################ DATA TABLE           
#tabPanel('Tables',         
         fluidRow(
           column(12, 
                  h3('Blog Post Data Table:'),
                  navbarPage(
                  title = 'Categories',
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
         )),

################################################################ END DATA TABLE & Chart app 1 tabpanel

###################### CHART APP 2 tabPanel #############################    
tabPanel('NLP: WordCloud',
         fluidRow(
           column(12, includeHTML("Project_NLP_WordCloud.html"),
                  br())
         )
         ),
################################################################ END Chart app 2 tabpanel
###################### CHART APP 3 tabPanel #############################  
tabPanel('NLP: LDA',
         fluidRow(
           column(12, includeHTML("Project_NLP_LDA.html"),
                  br())
         )
        ),
################################################################ END Chart app 3 tabpanel
###################### CHART APP 4 tabPanel #############################  
tabPanel('Interactive LDA',
         fluidRow(
           column(12, 
                  h3('Interactive LDA:'),#,
                  h4('Select a Blog Post'), hr(),
                  DT::dataTableOutput('x11'))), hr(),
                  #verbatimTextOutput('y11'),
           
                  #table w/ numbers
         fluidRow(
           column(12, h4("Topic Relevance for Selected Post:"),
                  tableOutput("table2"))), hr(),
           
                  #table w/ topics 
         fluidRow(
           column(12, h4("Topics"),
                  verbatimTextOutput("text")))
           
        ),
################################################################ END Chart app 4 tabpanel

##########################info section
tabPanel('Project Info',
         fluidRow(
           column(12,dashboardPage(dashboardHeader(disable = T),
                                   dashboardSidebar(disable = T),
                                   dashboardBody(br(),
                  h2('New York City Data Science Academy'),br(),
                  h3('Fall Cohort 2018'),br(),
                  h4('Blog Post Data Scraped From:'),
                  tags$div(class = 'header', checked = NA,
                           tags$a(href = 'https://nycdatascience.com/blog/','https://nycdatascience.com/blog/')),br(),br(),
                  h4('Created by'), 
                  tags$div(class = "header", checked = NA,
                           tags$p("Daniel Chen : dchen@taipeifx.com"),br(),
                           tags$div(class = "header", checked = NA,
                                    tags$a(href= "https://github.com/taipeifx/reimagined-octo-dollop","TaipeiFX GitHub")),br(),
                           tags$div(class = "header", checked = NA,
                                    tags$a(href= "https://nycdatascience.com/blog/author/dchen/","NYCDSA Blog"))
                           ))
                  ))
           ))
#############################end info section
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
  
  #################################################################################################################### interactive LDA
  ### blog post selection table
  options(DT.options = list(pageLength = 5))
  output$x11 = DT::renderDataTable(data_table, server = FALSE, selection = 'single')
  #output$y11 = renderPrint(input$x11_rows_selected)
  
  ###LDA output 
  toppings2 <- reactive({
    a = lda[input$x11_rows_selected,]
    return (data.frame(a,check.names = F))
  })  
  
  output$table2 <- renderTable({  
    expr = toppings2()
     }
     ,digits = 5) 
  
  ###Topics
  output$text <- renderText({
    paste("
    Topic #0:
    data science learning work job time use project academy people like yc using bootcamp python students machine really want just
    
    Topic #1:
    reviews rating ratings movie shows wine average movies music data review score number user artists complaints scores songs different higher
    
    Topic #2:
    data number time year years countries city ew population york world map people states state analysis country different shows dataset
    
    Topic #3:
    data app shiny user time information number map code based different tab health used project average job application chart salary
    
    Topic #4:
    price market sales prices fig airlines flight brands project category number brand average popular categories industry shot days apps projects
    
    Topic #5:
    stock games data performance analysis game correlation time model number used plot companies trading significant variables news stocks values words
    
    Topic #6:
    data crime school schools loan education rates car rate high house loans students price grade years higher credit student time
    
    Topic #7:
    team player players data game teams season win winning match statistics games field points performance use percentage home let results
    
    Topic #8:
    data words user used using users information project scraping time web page word reviews analysis number text website use restaurants
    
    Topic #9:
    model data models features variables set regression used feature training values learning dataset number test random using machine score variable"
    )
  })
  #################################################################################################################### end interactive LDA
###################### END SERVER #############################     
}

# Run the application 
shinyApp(ui = ui, server = server)

