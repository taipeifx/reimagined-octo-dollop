from scrapy import Spider
from blog.items import BlogItem
import re
from scrapy import Request

"""
class Blog(scrapy.Item):
	shares = scrapy.Field()
	post = scrapy.Field
	
	title = scrapy.Field()
	link = scrapy.Field()
	page = scrapy.Field()
	
scrapy shell "https://nycdatascience.com/blog/student-works/taiwan-vote-data-project-in-r-shiny/"
	"""
	
	
class BlogSpider(Spider):
	name = 'blog_spider'
	allowed_urls = ['https://nycdatascience.com/']
	start_urls = ['https://nycdatascience.com/blog/']
	#handle_httpstatus_list = [301]
	
	def parse(self, response):
		
		for num in [1,2]: #blog column 1 and 2
			rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[%d]/div' %num) #for row in rows, [1] to [9] #this gets the first row
			tpattern = './a[2]/@title' ########## title (a/@title)
			lpattern = './div[5]/a/@href' ######### link , rows.xpath('./div[5]/a/@href').extract_first()


			for row in rows:
			
				title = row.xpath(tpattern).extract_first()
				print (title)
				
				link = row.xpath(lpattern).extract_first()
				print (link)

				print ("#"*50)
				
				yield Request(url = link, meta = {'t': title, 'l': link, 'r': response}, callback = self.parse_blog_page)
				
		result_urls = ['https://nycdatascience.com/blog/page/{}/'.format(x) for x in range(2,88)]#88)] #https://nycdatascience.com/blog/page/87/
		for url in result_urls: #page 2 to 87 from result_urls
			yield Request(url=url, callback=self.parse_result_page) 
		
		#x = 2
		#while x < 87:
		#	result_urls = ('https://nycdatascience.com/blog/page/%d/'%x)
		#	yield Request(url=result_urls, callback=self.parse_result_page) #, meta = {'dont_redirect': True}) 
		#	x = x+1
#################################################################shares 

#################################################################parse_result_page
	def parse_result_page(self, response):
		for num in [1,2]: #blog column 1 and 2
			rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[3]/div/div[2]/div[%d]/div'%num)
			tpattern = './a[2]/@title' ########## title (a/@title)
			lpattern = './div[5]/a/@href' ######### link rows.xpath('./div[5]/a/@href').extract_first()

			for row in rows:
				title = row.xpath(tpattern).extract_first() ########## title
				#print (title)

				link = row.xpath(lpattern).extract_first()
				#print (link)
					
				yield Request(url = link, meta = {'t': title, 'l': link, 'r': response}, callback = self.parse_blog_page)

	def parse_blog_page(self, response):
	
		title = response.meta['t']
		link = response.meta['l']
		resp = response.meta['r']
		post = response.xpath('//div[contains(@class, "the-content")]/p/text()').extract()
		item = BlogItem()
		item['title'] = title
		item['link'] = link
		item['page'] = resp
		item['post'] = post
		yield item 
		
		
# In [6]: response.xpath('//div[contains(@class, "the-content")]/p/text()').extract() #content post 
#clean the data of \n , \xa0
#excerpt = excerpt.strip()
"""
#DOWNLOAD_DELAY = 10
		
	def parse_detail_page(self, response):
	# This fucntion parses the product detail page.
	# The link to the first page of reviews.
		first_review_page = response.xpath('//div[@class="see-all-reviews-button-container"]/a/@href').extract_first()
		q_and_a = response.xpath('//a[@data-track="Ask-Answer"]/text()').extract_first()
		question, answer = list(map(lambda x: int(x), re.findall('\d+', q_and_a))) #try, except
		yield Request(url=first_review_page, meta={'q': question, 'a': answer},
		callback=self.parse_review_page)
		
	def parse_review_page(self, response):
		question = response.meta['q']
		answer = response.meta['a']
		
		print(question, answer)
		print('*' * 50)
"""
"""scrapy shell "https://nycdatascience.com/blog/student-works/taiwan-vote-data-project-in-r-shiny/"

blog = response.xpath('//*[@id="template-single-v2"]/div[1]/div[2]/div/div[3]/div[1]/div/div[9]/p/text()').extract()



response.xpath('//*[@id="st-1"]/div[1]/span[1]')

<div class="share"><div class="sharethis-inline-share-buttons st-left st-has-labels  st-inline-share-buttons st-animated" id="st-1"><div class="st-total ">
  <span class="st-label">13</span>
  <span class="st-shares">

In [44]: links = response.xpath('//div[contains(@class, "share")]')

In [45]: links
Out[45]:
[<Selector xpath='//div[contains(@class, "share")]' data='<div class="share"><div class="sharethis'>,
 <Selector xpath='//div[contains(@class, "share")]' data='<div class="sharethis-inline-share-butto'>,
 <Selector xpath='//div[contains(@class, "share")]' data='<div class="share"><div class="sharethis'>,
 <Selector xpath='//div[contains(@class, "share")]' data='<div class="sharethis-inline-share-butto'>]

In [46]:

//*[@id="st-1"]/div[1]/span[1]
//*[@id="st-3"]/div[1]/span[1]


In [183]: response.xpath('//*[@id="template-single-v2"]/div[1]/div[2]/div/div[3]/div[1]/div/div[5]')
Out[183]: [<Selector xpath='//*[@id="template-single-v2"]/div[1]/div[2]/div/div[3]/div[1]/div/div[5]' data='<div class="share"><div class="sharethis'>]

In [184]: response.xpath('//*[@id="template-single-v2"]/div[1]/div[2]/div/div[3]/div[1]/div/div[5]/@class')
Out[184]: [<Selector xpath='//*[@id="template-single-v2"]/div[1]/div[2]/div/div[3]/div[1]/div/div[5]/@class' data='share'>]

In [185]: response.xpath('//*[@id="template-single-v2"]/div[1]/div[2]/div/div[3]/div[1]/div/div[5]/@class').extract()
Out[185]: ['share']

In [186]: response.xpath('//*[@id="template-single-v2"]/div[1]/div[2]/div/div[3]/div[1]/div/div[5]/div/@class').extract()
Out[186]: ['sharethis-inline-share-buttons']

In [187]: //*[@id="st-1"]/div[1]/span[1]
"""