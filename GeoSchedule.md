Monday, March 31st
-----------------
~~Split up Arkansas and Mississippi corpus into individual ad files using drsparser.py - Aaron~~
* Being done by Franco and Dr. McDaniel

~~Write python script placetagger.py to tag places using Pyner in a folder of text files and save the results - Aaron~~


Tuesday, April 1st
-----------------
~~Run placetagger.py on Arkansas, Mississippi, and Texas (Gazette and Telegraph) corpus - Aaron~~

~~Start looking over required readings from earlier in the semester for more information about trends in runaway destinations and connections among Texas, Mississippi, and Arkansas. Do additional readings if necessary - Clare~~


Wednesday, April 2nd - Friday, April 4th
--------------------------------------
Clean up Named Entity Recognitions results - Aaron and Kaitlyn

* Remove false positives

* As thoroughly as possible given the magnitude of the collection, scan through tagged documents for any obvious false negatives

* Tag each tagged location as a to or from, projected or real

~~Look over our data and outline the essay - Clare~~

Test drive [Palladio](http://palladio.designhumanities.org/) and research other mapping options for displaying our place connections results - All

Plan shaded map feature. Goal is to hover over a state, and it shades that state and other states with intensity determined by number of mentions of places in that state from the origin state's ads. Perhaps static images (using fusion tables) and Javascript to update the image depending on cursor location? - Aaron

~~Look over NER results differences from pre-processing ads text by replacing new lines with a space, and with a comma and space. - Aaron~~

* Results are approximately equal. Keeping as is (comma, space) for now.


Saturday, April 5th - Sunday, April 6th
--------------------------------------
Analyze Named Entity Recognition results - All

If a lot of NER results:

* Research [geocoding APIs](http://blog.programmableweb.com/2012/06/21/7-free-geocoding-apis-google-bing-yahoo-and-mapquest/) to parse our NER results and generate latitude/longitude coordinates for all named places - Aaron

* Write script to generate coordinates for tagged locations and execute on our data - Aaron

~~Else: Manually search for and store coordinates - Kaitlyn~~

~~Draft the close reading essay - Clare~~

~~Write progress update for course blog - Aaron and Kaitlyn~~


Monday, April 7th - Tuesday, April 8th
------------------------------------
Decide on how we want to display our place connectedness results - All

* How to display our results? Lines connecting the "to" coordinates (e.g. projected destination) and the "from" coordinates (e.g. coordinates of Houston for the Texas Register)? Something more individualized, at the ad-level? Collapse lines between cities or even states into single weighted lines by the number of that connection?

* Building onto the first question, how to indicate direction: different line shapes/colors? For example, if there is a Texas ad that says their runaway probably went to his family in Arkansas, how to we differentiate that from an Arkansas jailor notice for a runaway slave saying he is from Texas? Is it important at all for us to make this distinction? If not, we might do better with a map in the form of an undirected graph.

* How to separate projected runaway "to's" (and guessed "from's" for jailor's notices, if ads like that exist) from actual "to's" and "from's"? Do we have much more of one type (real. vs guessed) -- probably almost exclusively guessed locations?


Wednesday, April 9th - Friday, April 11th
---------------------------------------
Coordinate analysis and clean up - All

Re-assess rest of semester schedule in light of presentation format choices - All

Choose a mapping tool. Start building our map based on our decisions about to, from, projected, etc - All


Saturday, April 12th - Sunday, April 13th
------------------------------------------
Discuss our overall findings, and how our graphs and/or interactive tools share this information - All

Write and post progress report on course blog (by Monday) - All


Monday, April 14th - Wednesday, April 16th
----------------------------------------
Begin Methods page - Aaron and Kaitlyn

Begin Conclusions page, including followup questions and summary of findings - Clare

Finish our map and other graphics - All


Thursday, April 17th - Sunday, April 20th
--------------------------------------
Write and post progress report - All

Finish Methods page - Aaron and Kaitlyn

Finish Conclusions page - All


Monday, April 21st - Friday, April 25th
------------------------------------
Finalize website pages - All


Throughout, Clare will re-work the essay in light of any new info.