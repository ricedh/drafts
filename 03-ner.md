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

One way in which NER can be used is to get a count of how many times a newspaper (or a corpora of newspapers) in one state mentions other states. This can provide insights into how far runaway slaves traveled and ideas about how connected states were in the south. We used Google Fusion Tables ([this tutorial](http://commons.trincoll.edu/jackdougherty/how-to/gft-thematic-maps/) is helpful for learning how to use Google Fusion Tables) to visualize the results of running the NER script on our advertisement corpora. MORE ON RESULTS WHEN FINISHED WITH GFT.

*Google Fusion Tables section planning*

* possibly shows that Texas referenced itself much more often than other states. Jailer's notices and captured slave notices would reference other states (if slaves said they were from another state), but owners likely didn't think their slaves were running to other states. Could be confirmed by more close readings and comparisons of jailers notices versus slave advertisements
* our data didn't allow for evenly spread gradient - used buckets - intervals appear random at first glance
* doesn't allow users to play with results - only presents what author chooses to present
* possible next steps: making a JavaScript hover map to show each state's mentions in comparison to the other

<iframe width="500" height="300" scrolling="no" frameborder="no" src="https://www.google.com/fusiontables/embedviz?q=select+col2%3E%3E1+from+1WSnfP2-F62Do3GsH-_Cey1qIzP94Ox-0n-5Hzl93&amp;viz=MAP&amp;h=false&amp;lat=33.99690524070303&amp;lng=-92.99405781250005&amp;t=1&amp;z=4&amp;l=col2%3E%3E1&amp;y=2&amp;tmplt=2&amp;hml=KML"></iframe>

