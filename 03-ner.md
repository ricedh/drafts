![NER script](https://cloud.githubusercontent.com/assets/6469656/2755492/929e39b4-c969-11e3-8ba7-47b3d265dd37.png)

# Rationale

The method of close-reading runaway slave advertisements between 1835 and 1865 allows for an exploration of whether patterns of listed locations differ between the states, specifically in relationship to how Texas trends might differ. Various newspapers from Mississippi, Texas, and Arkansas provide the data set for this analysis.  Trends are most easily analyzed by individual state, followed by a conversation and comparison of these overall trends between the states.

# Methodology

How we got NER running, how the script works, adjustments that had to be made.

1. Parsed runaway ads for named entities using Stanford NER. Extracted the location entities.
2. Merged location entities that appeared close to each other in text, but NER separated (e.g. "Atlanta" and "GA" in the phrase "Atlanta, GA").
3. Used Google's geocode API to convert each location into corresponding latitude and longitude, as well as full address: street, city, state, zipcode.
4. For each advertisement, converted each location address into the state code. Created a set of state codes for each advertisement.
5. Summed the number of state references in each state's set of ads for each state
6. Exported numbers to spreadsheet for use in Palladio

# Conclusions

Findings, questions, limitations.

