from scrapy import Spider
from nycdsa.items import NycdsaItem
import re
from scrapy import Request

class NycdsaSpider(Spider):
	name = 'nycdsa_spider'
	allowed_urls = ['https://nycdatascience.com/']
	start_urls = ['https://nycdatascience.com/blog/']
	#handle_httpstatus_list = [301]
	
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
				
				alines = row.xpath(apattern)
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
		
		x = 5
		
		result_urls = ('https://nycdatascience.com/blog/page/%d/'%x)
		yield Request(url=result_urls, callback=self.parse_result_page) #, meta = {'dont_redirect': True}) 
			

		#result_urls = ['https://nycdatascience.com/blog/page/{}/'.format(x) for x in range(2,88)] #https://nycdatascience.com/blog/page/87/
		#for url in result_urls: #page 2 to 87 from result_urls
		#	yield Request(url=url, callback=self.parse_result_page) 
		
#################################################################parse_result_page
	def parse_result_page(self, response):
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
				#print (title)
				
				alines = row.xpath(apattern) ######### author 
				author = []
				for line in range(1,len(alines)-1):
					alist= row.xpath(apattern).extract()[line]
					author.append(alist)
				#print (author)
					
				category = row.xpath(cpattern).extract_first() ######### category
				#print (category)
				
				link = row.xpath(lpattern).extract_first()
				#print (link)
					
				excerpt = row.xpath(epattern).extract_first() ######### excerpt
				excerpt = excerpt.strip() #.replace("\r\n","")
				#print (excerpt)
				
				date = row.xpath(dpattern).extract_first() ######### date
				#print (date)
				#print ("#"*50)

				item = NycdsaItem()
				item['title'] = title
				item['author'] = author
				item['category'] = category
				item['link'] = link
				item['excerpt'] = excerpt
				item['date'] = date
				yield item 
	
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