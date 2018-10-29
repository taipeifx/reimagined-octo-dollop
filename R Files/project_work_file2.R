setwd("C:/Users/asus/NYC Data Science Academy/NYCDSA Unit 5 Data Analysis with Python/Project 2 - Web Scraping/nycdsa/R Files")
library(readr)
library(dplyr)

working_data_merged = read_csv("working_data_merged.csv", col_types =cols(category = col_factor(NULL)))


filter(working_data_merged, working_data_merged$page == 64) 
filter(working_data_merged, page > 6)


######################################################################### NLP (python)
clean posts
use Text Classification #sentiment analysis, supervised learning 
use LDA # latent dirichlet allocation, unsupervised method #or not

working_data_merged$post[1]

lda = data.frame(working_data_merged$post, working_data_merged$title)
names(lda) = c("post","title")
lda[1:5]

write_csv(lda, "lda.csv")



















######################################################################### End NLP
#
add table. group by month, show category posts?  
  https://shiny.rstudio.com/gallery/datatables-options.html
https://stackoverflow.com/questions/3550341/gantt-charts-with-r
https://github.com/scrapy-plugins/scrapy-splash
use NLP to see if can group student works category into Shiny, webscraping, etc

working_data_merged = working_data_merged[-(working_data_merged$title == "Test Gist Wil"),]
#

output$ex2 <- DT::renderDataTable(
  DT::datatable(
    iris, options = list(
      lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
      pageLength = 15
    )
  )
)

#

tabsetPanel(
  tabPanel('diamonds', dataTableOutput("mytable1")), 
  tabPanel('mtcars', dataTableOutput("mytable2")), 
  tabPanel('iris', dataTableOutput("mytable3"))
  
  # a large table, reactive to input$show_vars
  output$mytable1 = renderDataTable({
    library(ggplot2)
    diamonds[, input$show_vars, drop = FALSE]
  })
  #sorted columns are colored now because CSS are attached to them
  output$mytable2 = renderDataTable({
    mtcars
  }, options = list(bSortClasses = TRUE))
  #customize the length drop-down menu; display 5 rows per page by default
  output$mytable3 = renderDataTable({
    iris
  }, options = list(aLengthMenu = c(5,30,50), iDisplayLength = 5))