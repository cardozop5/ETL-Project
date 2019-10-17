-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/OigECk
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "zip_codes" (
    "zip_code" int   NOT NULL,
    "city" varchar(255)   NOT NULL,
    "state" varchar(255)   NOT NULL,
    CONSTRAINT "pk_zip_codes" PRIMARY KEY (
        "zip_code"
     )
);

CREATE TABLE "texas_population_income" (
    "zip_code" int   NOT NULL,
    "median_income" int   NOT NULL,
    "population" int   NOT NULL
);

CREATE TABLE "yelp_houston_restaurants" (
    "zip_code" int   ,
    "alias" varchar(255) NOT NULL ,
    "name" varchar(255)   ,
    "price" varchar(255)   ,
    "rating" varchar(255)   ,
    "review_count" int ,
    CONSTRAINT "pk_yelp_houston_restaurants" PRIMARY KEY (
        "alias"
     )
);

CREATE TABLE "house_prices" (
    "zip_code" int   NOT NULL,
    "price" int   NOT NULL,
    "street" varchar(255)   NOT NULL,
    "city" varchar(255)   NOT NULL
);

ALTER TABLE "texas_population_income" ADD CONSTRAINT "fk_texas_population_income_zip_code" FOREIGN KEY("zip_code")
REFERENCES "zip_codes" ("zip_code");

ALTER TABLE "yelp_houston_restaurants" ADD CONSTRAINT "fk_yelp_houston_restaurants_zip_code" FOREIGN KEY("zip_code")
REFERENCES "zip_codes" ("zip_code");

ALTER TABLE "house_prices" ADD CONSTRAINT "fk_house_prices_zip_code" FOREIGN KEY("zip_code")
REFERENCES "zip_codes" ("zip_code");

CREATE USER wen WITH PASSWORD '12345';
