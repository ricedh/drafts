![NER script](https://cloud.githubusercontent.com/assets/6469656/2755492/929e39b4-c969-11e3-8ba7-47b3d265dd37.png)

# Rationale

The close reading of the runaway ads indicated that Texas ads were overwhelmingly Texas-centric, as opposed to those in Arkansas and Mississippi, which included a more diverse interaction with states outside of themselves. In order to test this hypothesis, however, we needed comprehensive lists of state mentions in each of the three runaway ad corpora (Arkansas, Mississippi, and Texas). The data provided by NER allowed for an exploration of whether patterns of listed locations differ between the states, specifically in relationship to how Texas trends might compare with Arkansas and Mississippi.

The extensive size of the data set results in certain implications based on the time-consuming and labor-intensive nature of the manual labor of close reading. Without digital tools to sift through the information and help identify patterns, and with over 1000 advertisements in the Mississippi corpora alone, analysis and trends are challenging to find and prove through close reading.

Extracting geographic place names from the runaway advertisements through NER gave us the ability to process the massive amount of data. This collection and organization of massive data extends beyond the geographic as well, through NER's capability to extract names of people and organizations. Without the computer coding, we would have been unable to collect a relatively complete data set of locations, given the enormous size of the corpus and the manual labor necessary for the task. Through NER, we achieved an approximation, a broad overview of the number trends in state references for Arkansas, Mississippi, and Texas.



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

