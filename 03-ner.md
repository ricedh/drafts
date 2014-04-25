---
title: Tagging Locations with NER
author: Aaron Braunstein, Clare Jensen, and Kaitlyn Sisk
...

![NER script](https://cloud.githubusercontent.com/assets/6469656/2755492/929e39b4-c969-11e3-8ba7-47b3d265dd37.png)

# Rationale

A close reading of the runaway ads from our corpora suggested that Texas ads were more self-referential than those of Arkansas and Mississippi, which seemed to include a more diverse interaction with states outside of themselves. In addition, mentions of Mexico seemed to appear exclusively in Texas ads. However, without digital tools to sift through the information, and with over 1000 advertisements in the Mississippi corpora alone, analysis and trends are challenging to prove through close reading. In order to test these hypotheses, then, we needed comprehensive lists of state mentions in each of the three runaway ad corpora (Arkansas, Mississippi, and Texas). These locations lists required a method of large data collection and organization, since the number of advertisements prohibited the possibility of manual labeling.

Extracting geographic place names from the runaway advertisements through NER gave us the ability to process the large amounts of data. The script was able to collect a relatively comprehensive list of all location mentions in the corpora. The possibilites of NER extend beyond the geographic as well, through NER's ability to extract names of people and organizations. Without the computer coding, we would have been unable to collect a relatively complete data set of locations, given the enormous size of our sources and the manual labor necessary for the task. Through NER, however, we were able to achieve an approximation, a broad overview of the number trends in state references for Arkansas, Mississippi, and Texas.


# Methodology

How we got NER running, how the script works, adjustments that had to be made.

1. Parsed runaway ads for named entities using Stanford NER. Extracted the location entities.
2. Merged location entities that appeared close to each other in text, but NER separated (e.g. "Atlanta" and "GA" in the phrase "Atlanta, GA").
3. Used Google's geocode API to convert each location into corresponding latitude and longitude, as well as full address: street, city, state, zipcode.
4. For each advertisement, converted each location address into the state code. Created a set of state codes for each advertisement.
5. Summed the number of state references in each state's set of ads for each state
6. Exported numbers to spreadsheet for use in Google Fusion Tables

# Conclusions

Findings, questions, limitations.

NER can sometimes tag items incorrectly, which can be a limitation in our data. For example, we found that names of slaves or slave owners were sometimes tagged as locations, and places such as rivers could be tagged as just "Colorado" as opposed to "Colorado River." These outliers can be cleaned up manually, but with a large corpus such as ours, it can be very time consuming. Even a well-written NER script will still make some mistakes, so cleaning up the data is a necessary step when using NER.

###Using NER with Google Fusion Tables

Through the NER script, we were able to analyze our hypotheses that Texas was more self-referential and the only state to mention Mexico by getting a count of how many times a state was mentioned in the Mississippi, Arkansas, and Texas newspapers. One way to visualize the results of this data is through Google Fusion Tables ([this tutorial](http://commons.trincoll.edu/jackdougherty/how-to/gft-thematic-maps/) is helpful for learning how to use Google Fusion Tables). By shading each mentioned state with a color intensity based on its percentage of total references, we were quickly able to illustrate the results of the NER counts. 

*maps will be embedded on actual site (hopefully)*  
[Texas map](https://www.google.com/fusiontables/DataSource?docid=1eqWyjk4LrP4cnkB2-O9YD-FZKIfg8KE2f2a2s2ST)  
[Mississippi map](https://www.google.com/fusiontables/data?docid=1zqezAZk0FRZnfDEraQRD1dcl471zN8VzsI6Up-L5#map:id=3)  
[Arkansas map](https://www.google.com/fusiontables/DataSource?docid=1WSnfP2-F62Do3GsH-_Cey1qIzP94Ox-0n-5Hzl93)  

When viewed in conjunction, the three maps show that Texas runaway slave advertisements were slightly more self-referential that advertisements in Arkansas and Mississippi, which confirms our hypothesis. This could be due to the fact that Texas was a border land, so many runaway slaves were likely heading towards more remote areas, such as West Texas and Mexico, and not towards the rest of the Southern states. Texas is additionally the only state of the three to mention Mexico, but it does so fewer times than we were expecting. Arkansas is the least self-referential, which supports our earlier hypothesis outlined in the Palladio section that Arkansas was somewhat of a border land as well. The fact that about half of the total state references in the corpus are locations outside of Arkansas could be because Arkansas had more jailer's notices that advertised runaway slaves from other states.  

Google Fusion Tables is still an experimental tool and had a few limitations for us during this project. Because our data jumped quickly from lower numbers to higher numbers, we could not utilize the gradient tool to separate the colors and data evenly. Instead, we divided the number range into buckets to get a better sense of where the data was most heavily weighted. However, this makes the intervals appear random at first glance, and the colors are difficult to tell apart. 

Additionally, Google Fusion Tables only allows viewers to see what the author has published, rather than giving them the ability to experiment with the gradient and bucket tools for themselves. Our Google Fusion Tables have data columns for total number of counts, percentage including the state of the newspaper corpus, and percentage without the counts of the main state, yet we published the map that colors states based on the percentage including the main state. Giving the viewer the ability to play with the different features themselves could allow the viewer to make their own conclusions about what the data shows.

Our Google Fusion Tables can continue to improve as the results from the NER become cleaner and more precise. Additional research could focus just on jailer's notices (with help from MALLET). Since regular runaway slave advertisements mostly only mention the owner's location and a projected location, looking at jailer's notices would eliminate many of the self-referential advertisements. It also changes the lens through which we look at the data, as the out of state references would have been provided by the slaves rather than the slave owners. In addition, the Google Fusion Tables that we made could be enhanced by creating a JavaScript map that displays the colored data from the state when the mouse hovers over that state. This would enable the viewer to better see the differences between each state. 
