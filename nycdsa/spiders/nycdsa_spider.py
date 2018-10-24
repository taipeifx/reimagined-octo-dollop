from scrapy import Spider
from nycdsa.items import NycdsaItem
import re
from scrapy import Request

class NycdsaSpider(Spider):
	name = 'nycdsa_spider'
	allowed_urls = ['https://nycdatascience.com/']
	start_urls = ['https://nycdatascience.com/blog/']
	
	def parse(self, response):
		for num in [1,2]: #blog column 1 and 2
			rows = response.xpath('//*[@id="template-home-v2"]/div[1]/div[4]/div/div[2]/div[1]/div[%d]'%num) #for row in rows, [1] to [9] #this gets the first row
			pattern = './a[2]/@title' #or a/@title
			for row in rows:
				title = row.xpath(pattern).extract_first()
				print (title)

		item = NycdsaItem()
		item['title'] = title	
		yield item 
"""
	def parse(self, response):
		# Find the total number of pages in the result so that we can decide how many pages to scrape next
		text = response.xpath('//div[@class="left-side"]/span/text()').extract_first()
		num_pages = int(re.findall('\d+', text)[-1])//24+1
		#_, per_page, total = map(lambda x: int(x), re.findall('\d+', text))
		#num_pages = total // per_page
		# List comprehension to construct all the urls
		result_urls = ['https://www.bestbuy.com/site/all-laptops/pc-laptops/pcmcat247400050000.c?cp={}&id=pcmcat247400050000'.format(x) for x in range(1,num_pages+1)]
		# Yield the requests to different search result urls, 
		# using parse_result_page function to parse the response.
		for url in result_urls[:2]:
			yield Request(url=url, callback=self.parse_result_page)
		
	def parse_result_page(self, response):
	# This fucntion parses the search result page.
	# We are looking for url of the detail page.
		detail_urls = response.xpath('//div[@class="sku-title"]/h4/a/@href').extract()
		print(len(detail_urls))
		print('=' * 50)  #first middle way checkpoint
		# Yield the requests to the details pages, 
		# using parse_detail_page function to parse the response.
		for url in detail_urls:
			yield Request(url=url, callback=self.parse_detail_page)
		
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