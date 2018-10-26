http://localhost:8888/notebooks/NYC%20Data%20Science%20Academy/NYCDSA%20Unit%205%20Data%20Analysis%20with%20Python/Project%202%20-%20Web%20Scraping/nycdsa/intro%20to%20scrapy-Copy1.ipynb

conda activate ipykernel_py3 
for git : cd C:\Users\asus\NYC Data Science Academy\NYCDSA Unit 5 Data Analysis with Python\Project 2 - Web Scraping\nycdsa

scrapy shell "https://nycdatascience.com/blog/" #200
scrapy crawl nycdsa_spider



1. cd C:\Users\asus\NYC Data Science Academy\NYCDSA Unit 5 Data Analysis with Python\Project 2 - Web Scraping
scrapy startproject bestbuy

2. drag folder into text editor

3. update items.py, save

import scrapy
class NycdsaItem(scrapy.Item):  #each review is an instance of the bestbuyitem
    # define the fields for your item here like:
	category = scrapy.Field()
	title = scrapy.Field()
	author = scrapy.Field()
	date = scrapy.Field()
	excerpt = scrapy.Field()
	shares = scrapy.Field()
	link = scrapy.Field()

4. create spider, create file called nycdsa_spider.py under nycdsa/spiders

5. In bestbuy_spider.py, import the Spider class and the nycdsa class we defined earlier in items.py.
from scrapy import Spider
from bestbuy.items import BestbuyItem

6. set up a scraping task in nycdsa_spider.py
class NycdsaSpider(Spider):
    name = 'nycdsa_spider'
    allowed_urls = ['https://nycdatascience.com/']
    start_urls = ['https://nycdatascience.com/blog/']
    def parse(self, response):
        pass

		
		
start new anaconda prompt terminal # conda activate ipykernel_py3
cd C:\Users\asus\NYC Data Science Academy\NYCDSA Unit 5 Data Analysis with Python\Project 2 - Web Scraping\nycdsa

start scrapy shell:
scrapy shell "https://nycdatascience.com/blog/" #200
		
7. explore the patterns in the URL (copy xpath)
	category //*[@id="template-home-v2"]/div[2]/div[4]/div/div[2]/div[1]/div[1]/div[1]/a
	title 
	author 
	date 
	sypnosis 
	shares 
		
		

In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div') #2 columns that i need
In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div' ) #1st column of 9 projects
In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[2]/div') #2nd column of 9 projects 

"""
In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' )
div 1 = category
div 2 = author
div 3 = date
div 4 = excerpt 

In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/a' ) 
a 2 = title #a[2] but row[1] because rows are indexed from 0
"""

rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/a' ) #1st column of 9 projects
row = rows[1]
print (row)
<Selector xpath='//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/a' data='<a title="Characterising Culinary Footpr'>
xtext = row.xpath('./@title')
xtext.extract-first() #['Characterising Culinary Footprint of World Cuisines']

In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[x]') # x = 1 and 2  for the 2 columns that i need
	In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/a' ) #1st column of 9 projects
	In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[9]/a' ) #1st column of 9 projects
	
	
	In [78]: response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[2]/div[1 : 9]/a') #2nd column of 9 projects 

	
	def parse(self, response):
		rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div') #for row in rows, [1] to [9] #this gets the first row
		pattern = './a[2]/@title' #or a/@title
		for row in rows:
			title = row.xpath(pattern).extract_first()
			print (title)

		item = NycdsaItem()
		item['title'] = title	
		yield item 
##################### for both blog columns
	def parse(self, response):
		for num in [1,2]: #blog column 1 and 2
			rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[%d]/div' %num) #for row in rows, [1] to [9] #this gets the first row
			pattern = './a[2]/@title' #or a/@title
			for row in rows:
				title = row.xpath(pattern).extract_first()
				print (title)

		item = NycdsaItem()
		item['title'] = title	
		yield item 

########## for more items                                                      %d....[1-9]
#rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' )
rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]')
In [67]: rows.xpath('./div')
Out[67]:
[<Selector xpath='./div' data='<div class="content-category"><a class="'>,
 <Selector xpath='./div' data='<div class="content-authors lato bold fs'>,
 <Selector xpath='./div' data='<div class="content-date">Sep 26, 2018</'>,
 <Selector xpath='./div' data='<div class="content-excerpt fs13 lh19 gr'>,
 <Selector xpath='./div' data='<div class="content-link"><a href="https'>]

In [68]: rows.xpath('./div/a')
Out[68]:
[<Selector xpath='./div/a' data='<a class="aqua-text" href="https://nycda'>,
 <Selector xpath='./div/a' data='<a href="https://nycdatascience.com/blog'>,
 <Selector xpath='./div/a' data='<a href="https://nycdatascience.com/blog'>]

In [69]: rows.xpath('./div/a').extract()
Out[69]:
['<a class="aqua-text" href="https://nycdatascience.com/blog/category/student-works/r-shiny/">R Shiny</a>',
 '<a href="https://nycdatascience.com/blog/author/lavanya/" title="Posts by Lavanya Gupta" class="author url fn" rel="author">Lavanya Gupta</a>',
 '<a href="https://nycdatascience.com/blog/student-works/characterising-the-culinary-footprint-of-world-cuisines/">Read More</a>']

In [92]: rows.xpath('./div/a/text()')
Out[92]:
[<Selector xpath='./div/a/text()' data='R Shiny'>,
 <Selector xpath='./div/a/text()' data='Lavanya Gupta'>,
 <Selector xpath='./div/a/text()' data='Read More'>]
 
In [70]: rows.xpath('./div/a/text()').extract()
Out[70]: ['R Shiny', 'Lavanya Gupta', 'Read More']

In [97]: rows.xpath('./div/a/text()').extract()[0] ######### author
Out[97]: 'R Shiny'

In [95]: rows.xpath('./div/a/text()').extract()[1] ######### category
Out[95]: 'Lavanya Gupta'

In [104]: rows.xpath('./div/a/@href').extract()[2] ######### link
Out[104]: 'https://nycdatascience.com/blog/student-works/characterising-the-culinary-footprint-of-world-cuisines/'

In [111]: rows.xpath('./div/text()').extract()[2] ######### excerpt
Out[111]: '\r\n                                    Motivation We all love food; and we all talk about it a lot. There are myriad of datasets...'

In [112]: rows.xpath('./div/text()').extract()[1] ######### date
Out[112]: 'Sep 26, 2018'


#In [115]: rows.xpath('./div[3]')
#Out[115]: [<Selector xpath='./div[3]' data='<div class="content-date">Sep 26, 2018</'>]

#In [116]: rows.xpath('./div[3]/text()')
#Out[116]: [<Selector xpath='./div[3]/text()' data='Sep 26, 2018'>]

#In [117]: rows.xpath('./div[3]/text()').extract()
#Out[117]: ['Sep 26, 2018']

#In [118]: rows.xpath('./div[3]/text()').extract_first()
#Out[118]: 'Sep 26, 2018'

#rows			 ('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]')
#[<Selector xpath='//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' data='<div class="content-category"><a class="'>, #category
				   //*[@id="template-home-v2"]/div[2]/div[4]/div/div[2]/div[1]/div[1]/div[1]/a

# <Selector xpath='//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' data='<div class="content-authors lato bold fs'>, #author
				   //*[@id="template-home-v2"]/div[2]/div[4]/div/div[2]/div[1]/div[1]/div[2]/a

# <Selector xpath='//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' data='<div class="content-date">Sep 26, 2018</'>, #date
				   //*[@id="template-home-v2"]/div[2]/div[4]/div/div[2]/div[1]/div[1]/div[3]

# <Selector xpath='//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' data='<div class="content-excerpt fs13 lh19 gr'>, #excerpt
				   //*[@id="template-home-v2"]/div[2]/div[4]/div/div[2]/div[1]/div[1]/div[4]/text()

# <Selector xpath='//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' data='<div class="content-link"><a href="https'>] #link
				   //*[@id="template-home-v2"]/div[2]/div[4]/div/div[2]/div[1]/div[1]/div[5]/a


				   
div 1 = category
div 2 = author
div 3 = date
div 4 = excerpt 
div 5 = link 
		
In [31]: rows.xpath('./@class')
Out[31]:
[<Selector xpath='./@class' data='content-category'>,
 <Selector xpath='./@class' data='content-authors lato bold fs14'>,
 <Selector xpath='./@class' data='content-date'>,
 <Selector xpath='./@class' data='content-excerpt fs13 lh19 gray-text3'>,
 <Selector xpath='./@class' data='content-link'>]		

		
new anaconda prompt, cd into folder with scrapy.cfg. 
scrapy crawl nycdsa_spider

	
	
#####
In [127]: rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/a[2]')
In [128]: rows.extract()
Out[128]: ['<a title="Characterising Culinary Footprint of World Cuisines" href="https://nycdatascience.com/blog/student-works/characterising-the-culinary-footprint-of-world-cuisines/" class="fs18 lh24 bold dark-gray-text content-title">\r\n
 Footprint of World Cuisines                                </a>']

In [129]: rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/a[2]/@title')
In [130]: rows.extract()
Out[130]: ['Characterising Culinary Footprint of World Cuisines']






#############################################################################################################
In [9]: print (row)
<Selector xpath='//*[@id="mw-content-text"]/div/table/tbody/tr' data='<tr>\n<td><i><a href="/wiki/Three_Billboa'>

In [18]: xtext = row.xpath('./td[1]/i/a/text()') #define xtext through row.xpath

In [19]: xtext
Out[19]: [<Selector xpath='./td[1]/i/a/text()' data='Three Billboards Outside Ebbing, Missour'>]
#In [20]: print (xtext)
#[<Selector xpath='./td[1]/i/a/text()' data='Three Billboards Outside Ebbing, Missour'>]

In [21]: xtext.extract() #use .extract() to print value
Out[21]: ['Three Billboards Outside Ebbing, Missouri']
    #extract_first() returns none if extracting from empty list. 
    
film = row.xpath('./td[1]/i/a/text()').extract_first()
#############################################################################################################


//*[@id="template-home-v2"]/div[2]/div[4]/div/div[2]/div[1]/div[1]/a[2]
/html/body/div[2]/div[4]/div/div[2]/div[1]/div[1]/a[2]



#crawl using scrapy crawl bestbuy_spider

7. explore the patterns in the URL
https://www.bestbuy.com/site/promo/headphone-and-speaker-deals
https://www.bestbuy.com/site/promo/headphone-and-speaker-deals?cp=2

1-14, 25-48 of 96 items = 4 pages #right click highlight, span tag: <span>25-48 of 96 items</span>
Xpath = /html/body/main/div[2]/div[2]/div[2]/div[3]/div/div/div[4]/div[1]/span


Construct the result_urls list in bestbuy_spider.py
def parse(self, response):
    # Find the total number of pages in the result so that we can decide how many urls to scrape next
    text = response.xpath('//div[@class="left-side"]/span/text()').extract_first()
    _, per_page, total = map(lambda x: int(x), re.findall('\d+', text))
    number_pages = total // per_page
    # List comprehension to construct all the urls
    result_urls = ['https://www.bestbuy.com/site/all-laptops/pc-laptops/pcmcat247400050000.c?cp={}&id=pcmcat247400050000'.format(x) for x in range(1,number_pages+1)]
	
8. Add from scrapy import Request at the top of your spider file
def parse(self, response):
    # Find the total number of pages in the result so that we can decide how many pages to scrape next
    text = response.xpath('//div[@class="left-side"]/span/text()').extract_first()
    _, per_page, total = map(lambda x: int(x), re.findall('\d+', text))
    number_pages = total // per_page
    # List comprehension to construct all the urls
    result_urls = ['https://www.bestbuy.com/site/all-laptops/pc-laptops/pcmcat247400050000.c?cp={}&id=pcmcat247400050000'.format(x) for x in range(1,number_pages+1)]
    # Yield the requests to different search result urls, 
    # using parse_result_page function to parse the response.
    for url in result_urls[:2]:
        yield Request(url=url, callback=self.parse_result_page)

9. new conda, conda activate ipykernel_py3 , cd bestbuy (cd bestbuy folder), check dir

10. start scrapy shell:
scrapy shell "https://www.bestbuy.com/site/all-laptops/pc-laptops/pcmcat247400050000.c?id=pcmcat247400050000"
#200

response.xpath('//div[@class="left-side"]/span/text()')
response.xpath('//div[@class="left-side"]/span/text()').extract()
# find results per page , save as text 

#In [8]: import re
#In [9]: total = map(lambda x: int(x), re.findall('\d+', text))
#In [10]: print (total)
#<map object at 0x0000000004B8D5C0>
#In [11]: print (list(total))
#[1, 24, 761]

11. first middle way check point 

12. def parse detail page
	def parse_detail_page(self, response):
	# This fucntion parses the product detail page.
	# The link to the first page of reviews.
	first_review_page = response.xpath('//div[@class="see-all-reviews-button-container"]/a/@href').extract_first()
	yield Request(url=first_review_page, callback=self.parse_review_page)
	



test the see all customer reviews button for a certain product:
restart scrapy shell, ctrl+d

scrapy shell "https://www.bestbuy.com/site/sony-xb650bt-over-the-ear-wireless-headphones-black/4833400.p?skuId=4833400"
Xpath of see all reviews button : //*[@id="ratings-count-button"]

response.xpath('//*[@id="ratings-count-button"]/span/text()') -> refers to button below 

response.xpath('//div[@class="see-all-reviews-button-container"]/a/@href').extract_first()



		
		
		
		
#############################################################################################################
#############################################################################################################
############################################################################################################# pipeline.py
#pipelines.py
# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html


from scrapy.exceptions import DropItem
from scrapy.exporters import CsvItemExporter

class ValidateItemPipeline(object):

    def process_item(self, item, spider):
        if not all(item.values()):
            raise DropItem("Missing values!")
        else:
            return item

class WriteItemPipeline(object):

    def __init__(self):
        self.filename = 'academy_awards.csv'

    def open_spider(self, spider):
        self.csvfile = open(self.filename, 'wb')
        self.exporter = CsvItemExporter(self.csvfile)
        self.exporter.start_exporting()

    def close_spider(self, spider):
        self.exporter.finish_exporting()
        self.csvfile.close()

    def process_item(self, item, spider):
        self.exporter.export_item(item)
        return item
#next edit settings.py
#then, ready to deploy spider

#settings.py
ITEM_PIPELINES = {'nycdsa.pipelines.ValidateItemPipeline': 100, #smaller number -> higher priority
					'nycdsa.pipelines.WriteItemPipeline': 200}
#############################################################################################################
#############################################################################################################
#############################################################################################################






















		