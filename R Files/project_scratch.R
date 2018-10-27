setwd("C:/Users/asus/NYC Data Science Academy/NYCDSA Unit 5 Data Analysis with Python/Project 2 - Web Scraping/nycdsa/R Files")


library(readr)

### Grab Files
blog_info = read_csv("nycdsa_blog_full.csv", col_names = T)

blog_post = read_csv("blog_scraped.csv", col_names = T)

blog_post2 = read_csv("blog_scraped_2.csv", col_names = T)

####################################################################################### CLEANING BLOG_INFO
### Cleaning <U+00A0>
#data <- data.frame(lapply(blog_info$excerpt[1], function(x) {gsub("\u00A0", " ", x)}))

blog_info$excerpt <- gsub("\u00A0", ' ', blog_info$excerpt) # \u00A0 is java

### Cleaning dates column
install.packages("anytime")
library(anytime)

blog_info$date <- sub(" 1, ", ' 01, ', blog_info$date)
blog_info$date <- sub(" 2, ", ' 02, ', blog_info$date)
blog_info$date <- sub(" 3, ", ' 03, ', blog_info$date)
blog_info$date <- sub(" 4, ", ' 04, ', blog_info$date)
blog_info$date <- sub(" 5, ", ' 05, ', blog_info$date)
blog_info$date <- sub(" 6, ", ' 06, ', blog_info$date)
blog_info$date <- sub(" 7, ", ' 07, ', blog_info$date)
blog_info$date <- sub(" 8, ", ' 08, ', blog_info$date)
blog_info$date <- sub(" 9, ", ' 09, ', blog_info$date)

blog_info$date <- anydate(blog_info$date) # anytime library

### Cleaning dates column scratch
class(blog_info$date)

df <- data.frame(as.factor(blog_info$date))
names(df)[1] <- "dates"
df$date <- anydate(df$dates)

as.Date(df$date)
blog_info$date

dff <- data.frame(as.Date(df$date))
class(df$date)

################## Clean page info
blog_info$page <- sub("<200 https://nycdatascience.com/blog/>", '1', blog_info$page)
blog_info$page <- sub("<200 https://nycdatascience.com/blog/page/", '', blog_info$page)
blog_info$page <- sub("/>", '', blog_info$page)

blog_info$page <- as.numeric(blog_info$page)

##
blog_info[order(blog_info$page),]
library(dplyr)


b = blog_info[order(blog_info$page),]
length(blog_info$page)
b = table(blog_info$page)
b
(blog_info$page)

class(blog_info$page)


####################################################################################### DONE BLOG_INFO
####################################################################################### ADD UNSCRAPED DATA 
b = table(blog_info$page)
b
1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 
18 14 13 14 14 14 14 14 13 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 12 14 14 14 14 14 14 14 13 14 14 14 14 14 14 14 14 13 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 14 
      X1                 V1                                                              P2                       V1                         V1
67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 
14 14 14 14 14 14 14 14 14 14 13 14 14 14 14 14 14 14 14 14 11 
                              ?1                            P1
                    author category date       excerpt link   page title
blog_info[1213,]= c("Bircan Buyukdag","Alumni","2018-07-29","Refugees and Asylees of Turkey   See interactive Shiny App As a person who has interests in international...",
                    "https://nycdatascience.com/blog/r/33906/", "9","Refugees and Asylees of Turkey ")

blog_info[1214,]= c("David Letzler","Student Works","2017-02-17","America's Favorite Trivia Game ¡§Jeopardy!¡¨ is America's longest-running quiz show.  Originally airing 1964-1975, its Alex-Trebek-hosted 1984 reboot has become...",
                    "https://nycdatascience.com/blog/student-works/jeopardy-sabermetrics/", "39","Jeoparday! Sabermetrics")

blog_info[1215,]= c("Alex Yuan Li","R Visualization","2016-10-24","I. Introduction Living in New York City for more than two years now, I always enjoy the various,...",
                    "https://nycdatascience.com/blog/student-works/r-visualization/exploratory-visualization-nyc-restaurant-safety-inspection-data/", "48","Exploratory Visualization of the NYC Restaurant Safety Inspection Data")

write_csv(blog_info, "blog_scraped_clean.csv")
blog_info2 = read_csv("blog_scraped_clean.csv", col_names = T)
####################################################################################### SAVED
##############################################################################################################################################################################
####################################################################################### Clean blog posts
blog_post = read_csv("blog_scraped.csv", col_names = T)
blog_post2 = read_csv("blog_scraped_2.csv", col_names = T)
blog_post
blog_post2

###blog_post
blog_post$page <- sub("<200 https://nycdatascience.com/blog/>", '1', blog_post$page)
blog_post$page <- sub("<200 https://nycdatascience.com/blog/page/", '', blog_post$page)
blog_post$page <- sub("/>", '', blog_post$page)

blog_post$page <- as.numeric(blog_post$page)
blog_post = blog_post[order(blog_post$page),]
b = table(blog_post$page)
b

#clean post http://www.endmemo.com/program/R/gsub.php
blog_post$post <- gsub("\u00A0", ' ', blog_post$post)

c = blog_post
c$post = gsub("([[:punct:]])\\1+", "", c$post)
c$post = gsub(",*", "", c$post)
c$post = gsub("==*", "", c$post)
c$post = gsub("--*", "", c$post)

nchar(c$post)

d = c[(which(nchar(c$post) > 100)),]
nchar(d$post)

write_csv(d, "blog_post_clean.csv")
### scratch
c$post = gsub("([[:punct:]])([[:space:]])(([[:punct:]])|)\\1+", "", c$post)
c$post = gsub("^([[:punct:]])", "", c$post)

c$post <- gsub(",,+", '', c$post)
c$post <- gsub("[:punct:] {2,}", '', c$post)
c$post <- gsub("^[:punct:]", '', c$post)
###



###blog_post2
blog_post2$page <- sub("<200 https://nycdatascience.com/blog/>", '1', blog_post2$page)
blog_post2$page <- sub("<200 https://nycdatascience.com/blog/page/", '', blog_post2$page)
blog_post2$page <- sub("/>", '', blog_post2$page)

blog_post2$page <- as.numeric(blog_post2$page)
blog_post2 = blog_post2[order(blog_post2$page),]
b2 = table(blog_post2$page)
b2

#clean post
blog_post2$post <- gsub("\u00A0", ' ', blog_post2$post) # \u00A0 is java

e = blog_post2

e$post = gsub(",*", "", e$post)
e$post = gsub("==*", "", e$post)
e$post = gsub("--*", "", e$post)

nchar(e$post)

e = e[(which(nchar(e$post) > 100)),]
nchar(e$post)

write_csv(e, "blog_post_2_clean.csv")


table(d$page)
table(e$page)
####

scrape the blog, variables. 
"""
number of shares was java, scraped the blog post, some posts had formatting, had to scrape again
post = response.xpath('//div[contains(@class, "the-content")]/p/text()').extract()
post = response.xpath('//div[contains(@class, "the-content")]/p/span/text()').extract()
response.xpath('//div[contains(@class, "the-content")]/ul/li/text()').extract()

added page number of blog to see what was missing
protected posts
clean posts, less than 100 char filter prob not full article but what was grabbed by the scraper
combine posts scraped by both scrapes
"""

f = merge(e, d, by=c("title", "page", "link"))

f$page <- as.numeric(f$page)

f = f[order(f$page),]
f$post.y = gsub("__*", "", f$post.y)
nchar(f$post.x)
nchar(f$post.y)

g= f[order(f.index),]
rownames(f) <- NULL

h = f[(which(nchar(f$post.y) < 300)),]
nchar(h$post.x)
nchar(h$post.y)
h = f[(which(nchar(f$post.x) < 300)),]
#check and unite()
rownames(h) <- NULL
h$link[19]
h$link[3]

write_csv(f, "merged_posts_only.csv")

