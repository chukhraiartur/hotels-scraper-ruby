require_relative '../lib/zillow/zillow'

scraper = ZillowScraper.new(location='Austin, TX', pages=1)

hotels = scraper.get_hotels

scraper.print(hotels)
scraper.save(hotels)