# Hi there, I'm Alex
I'm from Liverpool, UK but I live in Manchester with my husband. I am a huge nerd, with a particular focus on fantasy novels, star trek, and dungeons & dragons. I'm happy to talk more about those things, but I won't start here in case I accidentally write a thesis on the deeply fulfilling creative cycle of dungeon mastering. I will mention that I recently successfully kickstarted my own game, which I'll be working on the publishing for the next couple of months.

I've had a diverse education and career. I've got qualifications in psychology, philosophy, building production technology, and computer science. I've worked in HR and construction prior to retraining as a software engineer. My career high so far was probably landing a job at Bandcamp. I'm a fan of their service, I love music, and I got to work remotely for the first time, which has been really life changing for me. 

I stayed at Bandcamp for 8 years and ended up being promoted to Director of Engineering, but sadly I found this took me away from the hands-on work I most enjoyed. So after much deliberation and attempts to mend things I parted ways with them very amicably. For most of my time there I headed up their Labels team, running projects focussed on making life easier for large volume sellers on the site. These included simple things like improved UI and more detailed stats, and much trickier things like a brand new account type for labels with extra tools and features, and a project we called "territory support", which involved implementing territorial licenses for labels to share the sales revenue from an album. This project touched nearly every part of the 10+ year old codebase, from the album page UI to the music file encoders. It was a beast, but we got through it. 

I hope this was all of interest, anyways! Let me know if you have follow up questions. Especially if they're about D&D.

# The merch api

## Installation
* Clone this repository
```
git clone git@github.com:alex-hindley/reedsy-challenge-backend.git
```
* Install the gems:
```
bundle install
```
* If needed, migrate the tables to your SQLLite instance:
```
rails db:migrate
```
* You can seed the necessary data to those tables using:
```
rails db:seed
```
* Run the app:
```
bin/rails server
```
* For extra confidence, always run the test suite:
```
bin/rails test
```

## Question 1: list the items
You can get a json formatted list of all the merch items in the database using this curl command;
```
curl localhost:3000/merch_items
```

## Question 2: update item details
You can update the price, code, and/or name of a merch item using the following curl:
```
curl -X PUT localhost:3000/merch_items/1 -d "merch[price]=7.5"
```

## Question 3: check a price
Here we get a little more complex. You'll need to note the id of the items you want to check from the results of the index call in Question 1. You can then use them as below, where items in curly braces are to be replaced with the id values you find:
```
curl localhost:3000/merch_items/check_price -d "quantities[{item_1_id}]=3&quantities[{item_2_id]=2"
```
For example, to check the total for a basked with various quantities of items with ids 1, 2, and 3:
```
curl localhost:3000/merch_items/check_price -d "quantities[1]=3&quantities[2]=2&quantities[3]=5"
```
For the above call your result will look something like:
```
Items: 3 MUG, 2 TSHIRT, 5 HOODIE
Total: 148.00
```

## Question 4: discounts!
The command format here is identical to that in Question 3, but now the results tell the user about the discounts their basket would have applied. So, for this curl call:
```
curl localhost:3000/merch_items/check_price -d "quantities[1]=10&quantities[2]=1"
```
You would get the result:
```
Items: 10 MUG, 1 TSHIRT
Total: 73.80

Explanation:
  - Total without discount: 60.00 + 15.00 = 75.00
  - Discount: 1.20 (2% discount on MUG)
  - Total: 75.00 - 1.20 = 73.80
```


# Reedsy Engineer Challenge

* [Ruby on Rails Engineer](ruby-on-rails-engineer-v2.md)
* [Node.js Fullstack Engineer Challenge](node-fullstack.md)
* [Front end Engineer Challenge](front-end.md)
* [Data Analyst Assignment](data-analyst.md)
* [Data Scientist Assignment](data-engineering.md)
