---
title: Detecting Locations with NER
author: Aaron Braunstein, Clare Jensen, and Kaitlyn Sisk
...

## Rationale

A close reading of the runaway ads from our corpora suggested that Texas ads were more self-referential than those of Arkansas and Mississippi, which seemed to include a more diverse interaction with states outside of themselves. In addition, mentions of Mexico seemed to appear exclusively in Texas ads. However, without digital tools to sift through the information, and with over 1000 advertisements in the Mississippi corpora alone, analysis and trends are challenging to prove through close reading. In order to test these hypotheses, then, we needed comprehensive lists of state mentions in each of the three runaway ad corpora (Arkansas, Mississippi, and Texas). These locations lists required a method of large data collection and organization, since the number of advertisements prohibited the possibility of manual labeling.

Extracting geographic place names from the runaway advertisements through Named Entity Recognition (NER) gave us the ability to process the large amounts of data. The script was able to collect a relatively comprehensive list of all location mentions in the corpora. The possibilites of NER extend beyond the geographic as well, through NER's ability to extract names of people and organizations. Without computer coding, we would have been unable to collect a relatively complete data set of locations, given the enormous size of our sources and the manual labor necessary for the task. Through NER, however, we were able to achieve an approximation, a broad overview of the number trends in state references for Arkansas, Mississippi, and Texas.


## Methodology

To compute for each state in the United States (and Mexico) the number of ads in a corpus that referenced that state, we decided to utilize a combination of named entity recognition, via [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml), and address lookup, via the [geopy Python library](https://github.com/geopy/geopy) using the GoogleV3 geocoder. Since this article is about named entity recognition, this article will focus on the first part, in the context of locations identification.

### Named Entity Recognition

Wikipedia defines named entity recognition succinctly: 

> Given a stream of text, determine which items in the text map to proper names, such as people or places, and what the type of each such name is (e.g. person, location, organization).

Stanford's implementation of NER uses a Conditional Random Field (CRF) in order to label a string of text with entities. If you have taken statistics courses, you might be familiar with Hidden Markov Models, which are widely used in the realm of natural language processing for tasks like speech recognition and identifying part of speech of words in a sentence. CRF is very similar to that: the classifier used by NER is trained on a large data set containing a sequence of words in sentences, where each word is annotated with an entity category, if there is one. Then, using sliding windows that take into account words that come before and words that come after the tokens (words) in question, the program maximizes the conditional probability of computed labels (unobserved data) given the tokens (observed data) and the classifier (training data set). Because it is probabilistic, there will always be errors, both false positives and false negatives.

Our goal was to find all location names. We used the built-in classifier, english.conll.4class, but if you want to train your own classifier, you can of course do that. The Wilkens Group at the University of Notre Dame has a good [tutorial on training your own classifier](https://blogs.nd.edu/wilkens-group/2013/10/15/training-the-stanford-ner-classifier-to-study-nineteenth-century-american-fiction/) if you are interested. They used NER on a 19th century American Fiction data set, and their tutorial outlines the advantages of training your own classifier.

As mentioned, we chose Stanford's Named Entity Recognition software to use to identify locations in our corpora of runaway slave ads. We chose to write our entity tagger script in Python, and fortunately there is an interface called [Pyner](https://github.com/dat/pyner) that hooks calls to the NER program.

Once we downloaded NER and cd'd to the directory, we started it with the following UNIX command:

```
java -mx1000m -cp stanford-ner.jar edu.stanford.nlp.ie.NERServer -loadClassifier classifiers/english.conll.4class.distsim.crf.ser.gz -port 8080 -outputFormat inlineXML
```

Then in Python, after installing Pyner, we initialized the tagger with the following command:
```python
tagger = ner.SocketNER(host='localhost', port=8080)
```

Next, we called the get_entities method of the tagger, iteratively using each runaway slave ad in the corpus (a directory name) as the parameter:
```python
for filename in os.listdir(directory):
    if filename.endswith(".txt"):
        with open(os.path.join(directory, filename), 'r') as f:
            text = f.read().decode("utf8")
            entities = tagger.get_entities(text)
```

We checked if the LOCATION key existed in the entities dictionary (it also tags person, organization, etc), and if so, stored the LOCATION values in a locations dictionary that maps each filename to the detected locations:
```python
if 'LOCATION' in entities:
    locations[filename] = entities['LOCATION']
```

One problem that came up was that location tokens were as small as possible--usually at the word level. That means, if the text contained the phrase "Springfield, Virginia", the locations list would usually separate entries for "Springfield" and "Virginia." That behavior is not ideal since it can lead to ambiguity in the location names, and excess results. For example, there are dozens of towns named Springfield in the U.S. More on the ambiguity problem in a bit, but for now, our solution was a function that merges detected locations if they are situated within a certain threshold apart in the original text. We chose a maximum gap length of 2 between the tagged locations for them to be classified as an expression.
```python
def merge_locations(locs, text):
    """Merges all words in locs list that are spaced at most two characters
    apart in text. (i.e. ", "). Assumes locs are in order in text.
    """
    idx = 0
    last_idx = len(locs) - 1
    merged = []
    while idx <= last_idx:
        loc = locs[idx]
        while not idx is last_idx:
            # "Trims" the text after looking at each location to prevent
            # indexing the wrong occurence of the location word if it
            # occurs multiple times in the text.
            gap, text, merge = gap_length(locs[idx], locs[idx+1], text)
            if gap <= 2:
                loc += merge
                idx += 1
            else:
                break
        merged.append(loc)
        idx += 1
    return merged
    
def gap_length(word1, word2, text):
    """Returns the number of characters after the end of word1 and
    before the start of word2 in text. Also returns the "trimmed"
    text with whitespace through word1's position and the
    merged words expression.
    """
    pos1, pos2 = text.index(word1), text.index(word2)
    pos1_e, pos2_e = pos1 + len(word1), pos2 + len(word2)
    gap = pos2 - pos1_e
    
    # Substitute characters already looked at with whitespace
    edited_text = chr(0)*pos1_e + text[pos1_e:]
    inter_text = text[pos1_e:pos2_e]
    return gap, edited_text, inter_text
```

Finally, we dumped the resulting filename -> locations dictionary as a JSON file:
```python
with open(directory + '.json', 'w') as f:
    f.write(json.dumps(
                    locations,
                    indent=4,
                    separators=(',', ': ')
                    )
                )
```

If you would like to view the entire script or use it in your project, please visit [this gist](https://gist.github.com/br0nstein/11288492). Note the script also does some preprocessing of the text specific to our data set to aid in the location detection.

### Application

Going back to our original problem of counting the number of ads that referenced each state for each of our Arkansas, Mississippi, and Texas corpora, we can use the above technique to help compute that.

The algorithm:

![CountStateReferences](https://cloud.githubusercontent.com/assets/6469656/2800861/3f34bee2-cc7a-11e3-983f-0dd6e915d751.png)

The above algorithm makes a few assumptions about the model governing the types of locations that appear in the text. Notice how first, we try to directly match the location to a known list of state names (e.g. "Arkansas") and abbreviations (e.g. "AR" and "Ark."). If it fails, we next try to look up an address for the location. We implemented this using the geopy library with the GoogleV3 geocoder. The [github for the project](https://github.com/geopy/geopy) contains some examples of doing geolocating and address lookup similar to this. Because NER often produces false positives--for example in our data, subscriber names often appeared in all caps and were inaccurately tagged as locations--we check that the result is an address in the region. We chose to make the assumption that true locations always either:
* Include a state name in the merged location entity, or
* Are a reference to a local or nearby county or city

This helps reduce the number of false positives (e.g. names of people) that are considered as state references, since Google Maps is very good at finding locations for partial matches, and this is very bad for us. The probability that the address it chooses to return for non-location terms is in the nearby area (for example, Arkansas, Mississippi, Texas, Georgia, Tennessee, Louisiana, and Missouri) is low but of course non-negligible.

Because of time constraints, we didn't implement that exact algorithm. We started by just directly using whatever result the geocoder returned as the state for each location, but found that the number of false matches was enormous due to ambiguity in the data and noise. We ended up just implementing the "direct hit" part of the algorithm, under the assumption that this would underestimate the true state reference numbers but not bias any particular states, or bordering states vs the local state within a corpus. This means the counts we used to produce the maps are only location names that contain the state name or abbreviation.

Finally, with the state reference numbers in hand, we were able to produce some pretty Google Fusion tables displaying our results. See the next section for that.

## Conclusions
*Findings, questions, limitations.*

There are some limitations of NER that should be kept in mind. For one, it can sometimes tag items incorrectly. For example, we found that names of slaves or slave owners were sometimes tagged as locations, and places such as rivers could be tagged innacurately as the location "Colorado" as opposed to being interpreted as "Colorado River." These outliers can be cleaned up manually, but with a large corpus such as ours, it can be very time consuming. Even a well-written NER script will still make some mistakes, so cleaning up the data is a necessary step when using NER. That said, due to the nature of our project and the focus on the tool rather than the conclusions, we did not manually clean up our tagged locations but only the final state counts (false positives "Colorado" and "Washington") and designed the script to address these issues as intelligently as possible.

A limitation of the extension of NER in computing state counts is ambiguous place names, as previously mentioned with the Springfield example. Not to mention, state counts are affected by noise in the tagged locations data. To address this, in addition to the algorithm's design, we could reduce the noise at the locations tagging level by being more strict about tagged location matches. Right now, we only ran the data with one classifier, but to reduce the number of false positives (at the risk of reducing true positives), we could run the data with multiple classifiers, and only take as true the tagged locations that were matched by every classifier. If that produces too little data, we could set a threshold such as 2/3 for the number of classifiers that have to match a given token.


###Using NER with Google Fusion Tables

Using the NER script, we were able to analyze our hypotheses that Texas was more self-referential and the only state to mention Mexico by getting a count of how many times a state was mentioned in the Mississippi, Arkansas, and Texas newspapers. One way to visualize the results of this data is through Google Fusion Tables. ([This tutorial](http://commons.trincoll.edu/jackdougherty/how-to/gft-thematic-maps/) is helpful for learning how to use Google Fusion Tables). By shading each mentioned state with a color intensity based on its percentage of total references, we were quickly able to illustrate the results of the NER counts. 

<iframe width="500" height="300" scrolling="no" frameborder="no" src="https://www.google.com/fusiontables/embedviz?q=select+col2%3E%3E1+from+1eqWyjk4LrP4cnkB2-O9YD-FZKIfg8KE2f2a2s2ST&amp;viz=MAP&amp;h=false&amp;lat=32.30456213321756&amp;lng=-89.39054218750005&amp;t=1&amp;z=4&amp;l=col2%3E%3E1&amp;y=2&amp;tmplt=2&amp;hml=KML"></iframe>
Texas map

<iframe width="500" height="300" scrolling="no" frameborder="no" src="https://www.google.com/fusiontables/embedviz?q=select+col2%3E%3E1+from+1zqezAZk0FRZnfDEraQRD1dcl471zN8VzsI6Up-L5&amp;viz=MAP&amp;h=false&amp;lat=33.26511829579128&amp;lng=-91.80753437500006&amp;t=1&amp;z=4&amp;l=col2%3E%3E1&amp;y=2&amp;tmplt=2&amp;hml=KML"></iframe>
Mississippi map

<iframe width="500" height="300" scrolling="no" frameborder="no" src="https://www.google.com/fusiontables/embedviz?q=select+col2%3E%3E1+from+1WSnfP2-F62Do3GsH-_Cey1qIzP94Ox-0n-5Hzl93&amp;viz=MAP&amp;h=false&amp;lat=34.83073025937851&amp;lng=-91.89542500000006&amp;t=1&amp;z=4&amp;l=col2%3E%3E1&amp;y=2&amp;tmplt=2&amp;hml=KML"></iframe>
Arkansas map

When viewed in conjunction, the three maps show that Texas runaway slave advertisements were indeed slightly more self-referential than advertisements in Arkansas and Mississippi, which confirms our hypothesis. This could be due to the fact that Texas was a border land, so many runaway slaves were likely heading towards more remote areas, such as western Texas and Mexico, and not towards the rest of the Southern states. Texas is additionally the only state of the three to mention Mexico, but it does so fewer times than we were expecting. Arkansas is the least self-referential, which supports our earlier hypothesis outlined in the [Palladio section](01-palladio.html) that Arkansas was somewhat of a border land as well. The fact that about half of the total state references in the corpus are locations outside of Arkansas could be because Arkansas had more capture notices that advertised runaway slaves from other states.  

Google Fusion Tables is still an experimental tool and had a few limitations for us during this project. Because our data was not distributed evenly across percentage groups, we could not utilize the gradient tool to separate the colors and data nicely. Instead, we divided the number range into buckets to get a better sense of where the data was most heavily weighted. However, this makes the intervals appear random at first glance, and the colors are difficult to tell apart. 

Another technical limitation of Google Fusion Tables to keep in mind is that it only allows viewers to see what the author has published, rather than giving them the ability to experiment with the gradient and bucket tools for themselves. Our Google Fusion Tables have data columns for total number of counts, percentage including the state of the newspaper corpus, and percentage without the counts of the main state, yet we published the map that colors states based on the percentage including the main state. Giving the viewer the ability to play with the different features themselves could allow the viewer to make their own conclusions about what the data shows.

These Google Fusion Tables can continue to improve as the results from the NER become cleaner and more precise. Additional research could focus just on jailer's notices (with help from [MALLET](04-mallet.html)). Since regular runaway slave advertisements mostly only mention the owner's location and a projected location, looking at capture notices would eliminate many of the self-referential advertisements. It also changes the lens through which we look at the data, as the out of state references would have been provided by the slaves rather than the slave owners. In addition, the Google Fusion Tables that we made could be enhanced by using Javascript to change the map shown depending on which state the user's mouse is hovering over. This would enable the viewer to better see the differences between each state. NER is a useful tool to collect and analyze data, but geographic tools such as Google Fusion Tables allow this data to be presented and shared. 
