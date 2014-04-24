---
title: Grouping Documents with Topic Models
author: Daniel Burns
...

Screen shot of MALLET topics.

# Rationale

Why we wanted to separate regular ads from jailor's notices programmatically. 

Through our close readings of our ad corpuses, we quickly realized that a significant portion of the ads present were not in fact ads posted by owners searching for runaways, but of jailers who had captive runaways and were searching for the owners. While most of the language and intent in these ads were similar, there were enough differences to encourage sorting them out from the other ads.  From a geographic standpoint, these ads were the end-points of slaves' runaway journeys, and can be plotted differently than runaway ads, which serve as a starting point.  From a data analysis perspective, they do not include categories of information like reward value or means of escape, and would interfere with the collection of consistent data from ads on those categories.  Finally, the jailors' ads also served as an independent source of information, since sorting them out would lead to new insights on how laws on slave capture and return were put into effect, or how they varied in terms of language from ads posted by slave owners.
While these ads individually can be identified and sorted out of a corpus, both the number of runaway ads being dealt with and the number of jailors' ads prohibited this due to time constraints.  However, differences in language and terminology between the types of ads made it possible to train a computer to differentiate between them based on these variables.

# Methodology

Our method for using the MALLET topic modeling package to separate ads.

# Conclusions

Findings, questions, limitations

One concern with the use of topic modeling was the overall accuracy of the computer's ability to discriminate between similar ads.  Through analysis of the topic models for various states, it was found to have a high degree of reliability.  Out of the 398 Texas Gazette ads, the topic model sorting method split the ads into 195 jailors' ads and 203 runaway ads.  Out of all of these, there were 3 incorrectly identified ads in the jailors' ads, and 1 in the runaway ads.  In this set, there was a 99% accuracy for differentiating between ads.

However, there are limitations to this approach.  The first issue is the fact that there are always exceptions in the content of the material.  One ad discovered in the Texas Gazette text was the report of a runaway slave found dead.  This was identified by the topic model as strongly related to the runaway topic, even though the ad itself was a report of death.  In the Arkansas ads, another ad was the report of a captured runaway who had escaped and run from the jailor.  While this ad fell into both categories, the system used would only sort the ad into one set, thus leaving it out of the other data set.
Another limitation is the drop in accuracy as the number of topics allowed in the original program are increased.  For the Arkansas ads, when searched with 15 topics rather than the original 10, the accuracy dropped significantly.  In a set of 278 ads, 45 were incorrectly identified, dropping the accuracy to 84%.


