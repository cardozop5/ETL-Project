# ETL-Project

* In Jupyter Notebook perform all ETL.

* **Extraction**

  * Put each CSV into a pandas DataFrame.

* **Transform**

  * Copy only the columns needed into a new DataFrame.

  * Rename columns to fit the tables created in the database.

  * Handle any duplicates. **HINT:** some locations have the same name but each license number is unique.

  * Set index to the previously created primary key.

* **Load**

  * Create a connection to database.

  * Check for a successful connection to the database and confirm that the tables have been created.

  * Append DataFrames to tables. Be sure to use the index set earlier.

* Confirm successful **Load** by querying database.


**ETL Project:

**Members:

**Wenyuan Qiu, Devon Firestone, Patrick Cardozo

**Proposal


The proposal is to create a database of restaurants, house prices, and income/population in Houston, with the field that connects them being Houston-area zip codes (there ended up being 190 Houston area zip codes).  As a result, there is a zip codes table where zip codes serve as a primary key, and zip codes are a foreign key in the other 3 tables.

PostgreSQL and pgAdmin 4 are used as the database management system and frontend.


Extract: your original data sources and how the data was formatted (CSV, JSON, pgAdmin 4, etc).

List of Zip Codes:
A list of unique US zip codes and the states/cities they are in were pulled as an xls from (http://www.pier2pier.com/links/files/Countrystate/USA-Zip.xls) and converted to a csv.

Yelp Restaurants:
A list of Houston-based restaurants was extracted from the Yelp API.  This was done with the /business/search endpoint, which is designed to provide basic information about the business including the “alias” (a primary key for the business that Yelp sets up, the name, price range ($ to $$$$), rating, review count, and address (which contains a zip code for each record).  The API call was done by entering each zip code in Houston (run through a list of zip codes) into the “location” parameter for the API.  The endpoint only returns a maximum of 50 business per call, so offsets were used to loop through all results.



Texas Income and Population: 
For the extraction of this data, I went on “kaggle.com” and found a csv dataset that has some geographical attributes with regards to the state of Texas and can be used to join dataset obtained from my team members.  The most important attribute that was needed for this project was the zip code attribute which was what we decided on using to join our dataset. Hence after inspecting my dataset and making sure that it had the required attributes needed I downloaded it and saved it into my ETL project folder. 

Realtor.com:  
I used google to find housing data, then browsed and scraped the information from realtor.com using splinter and chromedriver.  I chose this site because it had easy to access information and included the zip code as a separate piece of data, which would be needed to join the housing data with the rest of our dataset.  Then I broke down the data across six pages into the price, street, zip code, and city for each listing, by setting the url in a for loop to move from page to page, then appended the data gathered into the appropriate lists.


Transform: what data cleaning or transformation was required.

Yelp Restaurants:
Due to the way the search was set up (search by entering each zip code in a list of zip codes) and the way Yelp finds results (proximity from entered location), the same restaurant shows up in multiple API calls because it could be close to multiple zip codes.  Duplicate listings were eliminated by dropping duplicate instances of in the “alias” field (a Yelp primary key for the business).  Then, the dataset must be able to join with other datasets in the database using zip codes as a foreign key.  The zip code is contained in the “location” result that the API call returns, but unfortunately, the “location” results are formatted as dictionaries.  So, the location field (a series of dictionaries) was transformed into a dataframe where each key became a series, and the zip code series was extracted from that.  Then, the zip codes were concatenated with the original restaurant dataframe so that the zip codes appear in the same dataframe as the other data.  Finally, it was discovered that the Yelp API call returned results outside the US because zip codes in Houston matched some sort of other location parameters in other countries.  Results were then isolated for Houston restaurants only by a string filter on the “alias” field (the alias must contain “Houston” for it to be kept).  Fortunately, Yelp set their alias field to contain the city name so this was feasible.

Texas Income and Population: 
The original CSV I downloaded had 10 columns which consisted of Housing Units, Zipcode, Water Area, Median Home Value, Median Household Income, Population Density, Occupied Housing Units, Population, Id, Land Area. Out of these 10 columns I needed just 3. Hence I dropped the columns I didn’t need, checked for duplicates, and converted my new dataset to a data frame.

Realtor.com:  
The gathered data was set in a panda’s data frame which was then cleaned of the ‘\n\’ characters in the Street column.  There was little to clean since the import grabbed only the necessary information with little formatting issues.



Load: the final database, tables/collections, and why this was chosen.

The database was set up in pgAdmin 4 using the schema described above.  Blank tables with primary and foreign key relationships were initialized for zip_codes, yelp_houston_restaurants, house_prices, and texas_population_income in pgAdmin4.  The initialization code for SQL is in the SQL folder.

We chose a relational database because our data tables needed to relate to one another (they can all join using zip code).  This enables further analysis that can combine insights from the individual tables (income vs restaurant count, income vs restaurant reviews, income vs house prices, restaurant price vs house price, etc).

Then, the Jupyter notebook LoadAllToSQL in the Jupyter Notebooks folder was set up to put the zip codes, house prices, restaurants, and income/population to the same database.  Checks were done on the current data to be added with data existing in the database via pandas subsets to make sure that no duplicate records are added to the tables.


