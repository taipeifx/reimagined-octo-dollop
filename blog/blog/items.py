# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

#for blog, need # of shares, the blog post, and group on either title or link (include page but only for debug purposes)
import scrapy

class BlogItem(scrapy.Item):  #each review is an instance of the bestbuyitem
    # define the fields for your item here like:
	shares = scrapy.Field()
	post = scrapy.Field()
	title = scrapy.Field()
	link = scrapy.Field()
	page = scrapy.Field()