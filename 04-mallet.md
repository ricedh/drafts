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

Our first step was to generate three topic models, one for each of the three states for which we had advertisements. To do this we downloaded and ran [MALLET](http://mallet.cs.umass.edu). Because [our data](index.html#our-data) were already stored in separate text files, one for each ad, we were able to train topics on our ads using MALLET's command-line options and a [tutorial on topic modeling at the Programming Historian](http://programminghistorian.org/lessons/topic-modeling-and-mallet).

`````
[Daniel, you should put something here about the actual commands you ran, and an excerpt of the text file that has the topic-keys produced with 10 topics from one of the states. Put the text file inside two lines of backticks, as I've done here, so that Github won't get confused and think it's Markdown.]
`````

MALLET also outputs a spreadsheet showing the proportion of each document that is drawn from each of the topics; on each row, the filename of the document is followed by the number of the most prominent topic, followed by the proportion of the document associated with that topic. Other topics and proportions follow on the same row in decreasing order of weight.

In order to separate our ads, we first identified two topics in the keys file that seemed to associated, respectively, with runaway ads and captured notices. For example, in the topic-keys listed above, topic X looks more like a runaway ad because of words like .... while topic Y looks more like a captured notice because of words like ...

Thus, we hypothesized that documents in which topic X was more prominent than topic Y were more likely to be runaway ads, while documents in which topic Y was more prominent than topic X were likely to be captured notices. A [Python script](https://github.com/ricedh/adparsers/blob/master/divide_docs.py), `divide_docs.py`, enabled us to test this assumption. The script analyzes the tab-delimited file output by MALLET and separates the files in each row into two directories, based on whether topic X or topic Y appears first in that file's row. We were then able to perform a close reading on some of the separated files to see whether we had accurately separated ads for captured slaves from those that had not been captured.

# Conclusions

Findings, questions, limitations

One concern with the use of topic modeling was the overall accuracy of the computer's ability to discriminate between similar ads.  Through analysis of the topic models for various states, it was found to have a high degree of reliability.  Out of the 398 Texas Gazette ads, the topic model sorting method split the ads into 195 jailors' ads and 203 runaway ads.  Out of all of these, there were 3 incorrectly identified ads in the jailors' ads, and 1 in the runaway ads.  In this set, there was a 99% accuracy for differentiating between ads.  The Arkansas data set provided similar results.  Out of 199 jailors' notices, 9 were found in error; out of 289 runaway ads, only 6 were in error.  This gave the second data set an overall accuracy of 97%.  With these results, it is possible to trust the results from the topic models to within a reasonable margin of error.

However, there are limitations to this approach.  The first issue is the fact that there are always exceptions in the content of the material.  One ad discovered in the Texas Gazette text was the report of a runaway slave found dead.  This was identified by the topic model as strongly related to the runaway topic, even though the ad itself was a report of death.  In the Arkansas ads, another ad was the report of a captured runaway who had escaped and run from the jailor.  While this ad fell into both categories, the system used would only sort the ad into one set, thus leaving it out of the other data set.
Another limitation is the drop in accuracy as the number of topics allowed in the original program are increased.  For the Arkansas ads, when searched with 15 topics rather than the original 10, the accuracy dropped significantly.  In a set of 278 ads, 45 were incorrectly identified, dropping the accuracy to 84%.
