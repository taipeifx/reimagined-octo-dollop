setwd("C:/Users/asus/NYC Data Science Academy/NYCDSA Unit 5 Data Analysis with Python/Project 2 - Web Scraping/nycdsa/R Files")
working_data_merged = read_csv("working_data_merged.csv")

blog_ = read_csv("blog_post_clean.csv")
blog_2 = read_csv("blog_post_2_clean.csv")


library(readr)
blog_info = read_csv("blog_scraped_clean.csv")
blog_merge = read_csv("merged_posts_only.csv")

#combine post.x and post.y
#merge blog_info with blog_merge
blog_merge = blog_merge[c(-5,-7)]

library(tidyr)
blog_merged = unite(data = blog_merge, col = post, c(4:5), sep = " ", remove = T)
blog_merged
blog_merged$post = gsub("NA*", "", blog_merged$post)

a = blog_merged[(which(nchar(blog_merged$post) < 100)),] #$post = ""
a$post = ""

working_data = merge(blog_info, blog_merged, by=c("title", "page", "link"), all = TRUE) 
write_csv(working_data, "working_data.csv")
working_data_merged = unite(data = working_data, col = post1, c(7,8), sep = ":", remove = T)
working_data_merged = unite(data = working_data_merged, col = post, c(1,7), sep = ": ", remove = F)
working_data_merged = working_data_merged[-8]
  
############################################## timevis
install.packages("timevis")
library(timevis) #https://daattali.com/shiny/timevis-demo/
working_data_merged = 

b = c(1:length(working_data_merged[working_data_merged$category == "R",]$category))
b[]= "NA"
data <- na.omit(data.frame(
  id      = 1:length(working_data_merged[working_data_merged$category == "R",]$category),
  content = working_data_merged[working_data_merged$category == "R",]$title,
  start   = working_data_merged[working_data_merged$category == "R",]$date, 
  end     = b
  
))
timevis(data, )
?timevis
#

b = 1:length(working_data_merged$post)
b[]= "NA"
data <- na.omit(data.frame(
  id      = 1:length(working_data_merged$post),
  content = working_data_merged$title,
  group   = working_data_merged$category,
  start   = working_data_merged$date,
  end     = b
))

timevis(data, 
        groups =  data.frame (id = levels(working_data_merged$category), content = levels(working_data_merged$category)))
#
add table. group by month, show category posts?  
https://shiny.rstudio.com/gallery/datatables-options.html
https://stackoverflow.com/questions/3550341/gantt-charts-with-r
https://github.com/scrapy-plugins/scrapy-splash
use NLP to see if can group student works category into Shiny, webscraping, etc

working_data_merged = working_data_merged[-(working_data_merged$title == "Test Gist Wil"),]
#
timevis(data = data.frame(
  start = c(Sys.Date(), Sys.Date(), Sys.Date() + 1, Sys.Date() + 2),
  content = c("one", "two", "three", "four"),
  group = c(1, 2, 1, 2)),
  groups = data.frame(id = 1:2, content = c("G1", "G2"))
)


levels(working_data_merged$category)
working_data_merged$title
levels(working_data_merged$category)[[1]]
#working_data_merged = working_data_merged[-969,] test gist wil
rownames(working_data_merged[working_data_merged$title == "Test Gist Wil",])





working_data_merged[working_data_merged$category == "R",]$category
working_data_merged[working_data_merged$category == "R",]$date
a = working_data_merged[working_data_merged$category == "R",]
a = data.frame(working_data_merged[working_data_merged$category == "R",]$date)
working_data_merged[working_data_merged$date == "2013-06-09",]
a = working_data_merged[(which(nchar(working_data_merged$date) > 4)),]
a = data.frame(nchar(working_data_merged$date))
1:length(working_data_merged[working_data_merged$category == "R",]$category)


1:length(working_data_merged$category)



class(working_data_merged$date)
type(working_data_merged$date)

working_data_merged$date[969] = "2015-02-28"
write_csv(working_data_merged, "working_data_merged.csv")
###############################################
















########################################################### added two posts below, and rewrite merged_posts_only.csv  , write_csv(blog_merge, "merged_posts_only.csv")
rownames(blog_merge) <- NULL
blog_merge$post.y[235]
blog_merge[blog_merge$title == "What are the most under-rated hiking destinations?",]$post.y = "A relatively high amount of hiking trails
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
I plan to address these questions in future iterations of this project. Some of my plans include:"

blog_merge[1193,]= c("NYC Vision Zero - Has this initiative improved the overall road safety ?", "60", "https://nycdatascience.com/blog/student-works/nyc-vision-zero-initiative-improved-overall-road-safety/",
                    "All of us are aware that motor vehicle accidents are becomingan inevitable part of our daily lives and this is especially true for those living in big cities. In some cases, the injuries are minimal and there are others where people sustain life threatening injuries and even ultimately lose th
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
                    ", "", "","")

blog_info[blog_info$author == "Nanda Rajarathinam" & blog_info$date == "2016-06-29",]$link
