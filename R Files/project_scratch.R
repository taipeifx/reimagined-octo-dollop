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
#c$post = gsub("([[:punct:]])\\1+", "", c$post)
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
A relatively high amount of hiking trails
 A relatively high amount of hiking trails labeled Moderate or Difficult. This is because many parks and city walking areas are classified as trails- with a label of Easy. If I filter out Easy then I would likely be left with a more rural-centric selection.
A small overall tourist industry or a small percentage of tourism.
To find destinations that are of interest to travelers I collected
list of popular US destinations. This list includes hundreds of locations some are places with an emphasis on outdoors experiences others are towns or big cities.
Afterwards I brought the data into
a repository of hiking trails by location. With my list from Tripadvisor I gathered information about the trails for each location (This includes each trail name its rating number of reviews difficulty and the total trails returned for each location.
Looking for under-rated destinations I conjectured that those places would have a moderate to small tourist industry or that their tourist industry in relationship to their trail count and popularity would be sortable in a way that can separate hiking destinations from non-hiking destinations.
In order to add this dimension to the data I sent my list of locations to
and saved the results of each county. I also collected
Data about economy sizes by county.
To make a database that includes a full set of data for each location I joined my collected files into a pandas data frame. You can check out 
for the code.
With data about tourist industry size total industry hiking trails reviews etc. I sorted the data on multiple columns. The foremost rows were locations with prominent outdoor features: Aspen Colorado or Moab Utah. Further down the list had to live my under-rated locations. But how do they ge
t to the top of the list?
I decided to use the available data to score each location on its features and use those scores to sort the data as well as visualize them. With some basic Exploratory Data Analysis like groupby aggregating sums and means it was possible to quantify a hiking locations average rating score tot
al reviews whether or not the location had mostly hard trails (usually something like mountains) or easy trails (usually city parks). See the github links in Step 2 for examples of the functions built to perform EDA on the data.
At this point I was building functions that added columns to the dataset and visualizing them inside of a jupyter notebook. To make this part of exploring data easier and more robust I built an app that automatically plots and sorts the datable. It creates an easier feedback for the process an
d is a useful tool for sharing. Visit below:
The previous steps succeeded in gathering hiking-friendly locations from Tripadvisors list. In the visualization it is easy enough to explore and sort locations based on any of their features. However there is no
scale for under-ratedness although there are included some systems of scoring. This presents interesting challenge questions:
I plan to address these questions in future iterations of this project. Some of my plans include:

In [16]: response.xpath('//div[contains(@class, "the-content")]/div[2]/div/p/text()').extract()
Out[16]:
All of us are aware that motor vehicle accidents are becomingan inevitable part of our daily lives and this is especially true for those living in big cities. In some cases, the injuries are minimal and there are others where people sustain life threatening injuries and even ultimately lose th
eir lives. New York city, home to almost 8.4 million people is no exception to this trend and the city officials wanted to introduce measures that would help curb the rising casualties. The solution was called Vision Zero.,
Vision Zero is a multi-national road traffic safety project that originated in Sweden in late 90s and was later adopted by major cities across the world. The programaims to achieve a highway system with no fatalities or serious injuries in road traffic.The Vision Zero Action Plan is inten
ded to help end traffic deaths and injuries on New York City streets. Vision Zero programs are designed to discourage dangerous behavior on roads and streets by combining better enforcement and roadway engineering with improved emergency response and public campaigns on safe driving.,
The objective of this analysis is to analyze the variables pertaining to the New York city motor vehicle collision data and visually represent the data to understand the overall trend and big picture regarding the fatalities and injuries over the last 4 years. The data was analyzed from multiple p
erspectives including the time of accident, the location within the borough, the factors that could have contributed towards the collision and across years to understand the overalleffectiveness of the Vision Zero programin reducing the casualties.,
As a part of this analysis, I also wanted to understand how the fatalities and injuries vary across the boroughs and years. The following are some of the questions that I am trying to answer based on the visualization:,
The data pertaining to motor vehicle collisions within NY city is being collected by the citys Police Department and shared with the public as a part of the NYC OpenData program for visualization and performing analytics. The URL for the data is : ,
The data is relatively well structured and clean given that it contained more than 840,000 observations as of June 30, 2016. There are29 variables that describe different aspects of every accident such asdate, time, location, vehicle type, contributing factors toward accidents, etc. For th
e purpose of this visualization, I was primarily focusing on key variables such as date, time and year of accident, zip code , borough, number of fatalities and injuries.,
As a first step, I imported the data and cleaned up some of the key fields required for this analysis by performing data type conversions, renaming certain cryptic variables and derived new variables such asYear and Time from the Accident Date variable.,
All the code for this analysis can be found in : https://github.com/nycdatasci/bootcamp006_project/tree/master/Project1-ExploreVis/NandaRajarathinam,
As a part of answering my first research question, I looked at the overall trend in fatalities by boroughs over the last four years by creating the bar plot.,
Based on the bar plot, the overall number of fatalities seem to be going down over the past 3.5 years starting January 2013 until June 2016. I wanted to further drill down and observe the trend within each of the three groups of people involved in the collision namely cyclists, motorists and pedes
trians.,
Although there are more than 40 factors that might have likely caused the vehicle collision, I was interested in finding out the top 5 factors that would account for a significant percentage of the casualties. I created a bar plot of the number of fatalities and injuries by contributing factors.,

The bar plot clearly showed that the top factors that contributed towards the casualties were,
The above 10 factors contributed to at least 50% of the fatalities whereas the remaining 35 factors accounted for the rest of the casualties showing that the above factors play a more significant role in determining the number of fatalities.,
Last but not the least, I wanted to determineif the time of the day really had any significance with regards to the number of casualties. In order to answer that question, I had to first categorize the day into 4 groups - Morning, Afternoon, Evening and Overnight so that we would be able to ma
ke better sense of the result instead of using the time as is. The objective was to create a line plot of the number of casualties by part of the day in all boroughs to observe the pattern.,
The plot showed that there was a consistent observation in all boroughs where evening time(between 5 PM and mid-night) had the most number of casualties compared to rest of the day. This could be explained due to the rush hour traffic during peak evening hours and people trying to get home after w
ork as soon as possible.,
Theanalysis shows that there is a gradual declining trend in the number of casualties since the initiation of Vision Zero program couple of years ago.This initiative has helped curb the rising trend that was seen during the past decade in NY city.,
Although the overall number of pedestrian and motorist fatalities have come down over the past couple of years the cyclist related casualties are slowly rising. One possible reason for the spike in the number of cyclist related fatalities is the increasing useof Citibike, a popular bike sharin
g program in New York city. Given that the Citibike program is slated to expand significantly by 2017, ensuring the safety of the cyclists in all five boroughs of the city is of paramount importance.,
There are also more fatalities during the evening time and in specific neighborhoods of the boroughs. As a result, we can see that more work needs to be done to address specificissues that would reduce fatalities during evening time and enhance overall roadway and motorist safety in targeted n
eighborhoods of NY city.



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

table(f$page)
table(blog_merge$page)


f = merge(e, c, by=c("title", "page", "link"), all = TRUE)

k = e[(which(nchar(e$post) < 50)),] #72
m = c[(which(nchar(c$post) < 50)),] #12
l = merge(k, m, by=c("title", "page", "link"), all = TRUE) #k+m = 184

k = e[(which(nchar(e$post) > 1)),] 
m = c[(which(nchar(c$post) > 1)),] 
f2 = merge(k, m, by=c("title", "page", "link"), all = TRUE) 
table(f$page)
table(f2$page)
f$link[655]

write_csv(f2, "merged_posts_only.csv")
