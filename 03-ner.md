---
title: Tagging Locations with NER
author: Aaron Braunstein, Clare Jensen, and Kaitlyn Sisk
...

![NER script](https://cloud.githubusercontent.com/assets/6469656/2755492/929e39b4-c969-11e3-8ba7-47b3d265dd37.png)

# Rationale

The method of close-reading runaway slave advertisements between 1835 and 1865 allows for an exploration of whether patterns of listed locations differ between the states, specifically in relationship to how Texas trends might differ. Various newspapers from Mississippi, Texas, and Arkansas provide the data set for this analysis.  Trends are most easily analyzed by individual state, followed by a conversation and comparison of these overall trends between the states.

The data set indicates that Texas ads are overwhelmingly Texas-centric, as opposed to those in Arkansas and Mississippi, which include a more diverse interaction with states outside of themselves. 
BROAD OVERVIEW
The extensive size of the data set results in certain implications based on the time-consuming and labor-intensive nature of the manual labor of close reading. When analyzing the data by the human eye, pre-conceived assumptions come into play, and unexpected results are less likely to be found if present. Without digital tools to sift through the information and help identify patterns, the presence of human bias in evaluating the advertisement trends would be more noticeable.  Focusing on multiple elements or the connections between them is also more difficult for a human observer. For example, perhaps there exists a correlation between the amount of the reward and the projected location of the slave or distance between the locations of the advertisement and the owner. Without the extremely labor-intensive process of creating a spreadsheet, this evidence is difficult to analyze. Specific locations (cities and plantations) fall to the generalization and recognizability of states and counties. With over 1000 advertisements in the Mississippi corpora alone, analysis and trends are very difficult to find in a short period of time.



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

