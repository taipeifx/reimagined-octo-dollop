

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
			tpattern = './a[2]/@title' ########## title (a/@title)
			apattern = './div/a/text()' ######### author
			cpattern = './div[1]/a/text()' ######### category
			lpattern = './div[5]/a/@href' ######### link , rows.xpath('./div[5]/a/@href').extract_first()
			epattern = './div[4]/text()' ######### excerpt
			dpattern = './div[3]/text()' ######### date
			
			
			for row in rows:
				title = row.xpath(tpattern).extract_first()
				print (title)
				
				alines = row.xpath(apattern) ######### author  #use rows.xpath when testing single div with scrapy shell 
				author = []
				for line in range(1,len(alines)-1):
					alist= row.xpath(apattern).extract()[line]
					author.append(alist)
				print (author)
					
				category = row.xpath(cpattern).extract_first()
				print (category)
				
				link = row.xpath(lpattern).extract_first()
				print (link)
				
				excerpt = row.xpath(epattern).extract_first()
				excerpt = excerpt.strip()
				print (excerpt)
				
				date = row.xpath(dpattern).extract_first()
				print (date)
				print ("#"*50)

				item = NycdsaItem()
				item['title'] = title
				item['author'] = author
				item['category'] = category
				item['link'] = link
				item['excerpt'] = excerpt
				item['date'] = date
				yield item 




########## for more items                                                      %d....[1-9]

#rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' )
rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]')

In [119]: rows.xpath('./a[2]/@title').extract_first() ######### title
Out[119]: 'Characterising Culinary Footprint of World Cuisines'

#In [70]: rows.xpath('./div/a/text()').extract()
#Out[70]: ['R Shiny', 'Lavanya Gupta', 'Read More']

In [97]: rows.xpath('./div/a/text()').extract()[0] ######### category
Out[97]: 'R Shiny'

In [95]: rows.xpath('./div/a/text()').extract()[1] ######### author
Out[95]: 'Lavanya Gupta'

In [104]: rows.xpath('./div/a/@href').extract()[2] ######### link
Out[104]: 'https://nycdatascience.com/blog/student-works/characterising-the-culinary-footprint-of-world-cuisines/'

In [111]: rows.xpath('./div/text()').extract()[2] ######### excerpt
Out[111]: '\r\n                                    Motivation We all love food; and we all talk about it a lot. There are myriad of datasets...'

In [112]: rows.xpath('./div/text()').extract()[1] ######### date
Out[112]: 'Sep 26, 2018'

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


############################################################################################################# page 1 done

scrapy shell "https://nycdatascience.com/blog/page/2"
############################################################################################################# page 2 +

#rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]/div' )
rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[1]')
###############

In [4]: rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[3]/div/div[2]/div[1]/div[1]')

In [25]: rows.xpath('./a[2]/@title').extract_first() ######### title
Out[25]: 'In the Money: Predicting the Outcomes of Horse Races with RaceQuant'

In [16]: rows.xpath('./div/a/text()').extract()[0] ######### category
Out[16]: 'Capstone'

lines = rows.xpath('./div/a/text()') ######### author
for line in range(1,len(lines)-1):
	lin = rows.xpath('./div/a/text()').extract()[line]
	print (lin)
Julie Levine
Howard Chang
Kevin Cannon
Lavanya Gupta
Max Schoenfeld

for line in range(len(lines)-1,len(lines)): ######### link
	lin = rows.xpath('./div/a/@href').extract()[line]
	print (lin)

In [68]: rows.xpath('./div[4]/text()').extract_first()######### excerpt
Out[68]: '\r\n                                    Introduction RaceQuant is a startup specializing in consulting for horse race betting. RaceQuant enlisted our team to use...'

In [76]: rows.xpath('./div[3]/text()').extract_first()######### date
Out[76]: 'Oct 8, 2018'


###############
	def parse(self, response):
		for num in [1,2]: #blog column 1 and 2
			rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[3]/div/div[2]/div[%d]/div'%num)
			tpattern = './a[2]/@title' ########## title (a/@title)
			apattern = './div/a/text()' ######### author
			cpattern = './div[1]/a/text()' ######### category  rows.xpath('./div[1]/a/text()').extract_first()
			lpattern = './div[5]/a/@href' ######### link rows.xpath('./div[5]/a/@href').extract_first()
			epattern = './div[4]/text()' ######### excerpt
			dpattern = './div[3]/text()' ######### date
			for row in rows:
				title = row.xpath(tpattern).extract_first() ########## title
				print (title)
				
				alines = row.xpath(apattern) ######### author 
				author = []
				for line in range(1,len(alines)-1):
					alist= row.xpath(apattern).extract()[line]
					author.append(alist)
				print (author)
					
				category = row.xpath(cpattern).extract_first() ######### category
				print (category)
				
				link = row.xpath(lpattern).extract_first()
				print (link)
					
				excerpt = row.xpath(epattern).extract_first() ######### excerpt
				excerpt = excerpt.strip() #.replace("\r\n","")
				print (excerpt)
				
				date = row.xpath(dpattern).extract_first() ######### date
				print (date)
				print ("#"*50)

				item = NycdsaItem()
				item['title'] = title
				item['author'] = author
				item['category'] = category
				item['link'] = link
				item['excerpt'] = excerpt
				item['date'] = date
				yield item 
############################################################################################################# page 2 done

file:///D:/NYCDSA/Unit%205%20Data%20Analysis%20with%20Python/Scrapy_Lab/Scrapy_Lab.html#10
scrapy shell "https://nycdatascience.com/blog/page/2"
############################################################################################################# construct cont_urls

def parse(self, response):
    # Find the total number of pages in the result so that we can decide how many urls to scrape next
    text = response.xpath('//div[@class="left-side"]/span/text()').extract_first()
    _, per_page, total = map(lambda x: int(x), re.findall('\d+', text))
    number_pages = total // per_page
    # List comprehension to construct all the urls
    result_urls = ['https://www.bestbuy.com/site/all-laptops/pc-laptops/pcmcat247400050000.c?cp={}&id=pcmcat247400050000'.format(x) for x in range(1,number_pages+1)]
    # Yield the requests to different search result urls, 
    # using parse_result_page function to parse the response.
    for url in result_urls[:2]:
        yield Request(url=url, callback=self.parse_result_page)
# This yields a new Request object that goes to the new url and then direct Scrapy to parse_result_page, 
# which we haven't defined yet, to parse the response object we got from each of the urls.


# using format option in a simple string 
print ("{}, A computer science portal for geeks."
                        .format("GeeksforGeeks")) 
  
# using format option for a 
# value stored in a variable 
str = "This article is written in {}"
print (str.format("Python")) 
  
# formatting a string using a numeric constant 
print ("Hello, I am {} years old !".format(18))  






























