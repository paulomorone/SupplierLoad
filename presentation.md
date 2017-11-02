Coursera: Developing Data Products - Project
========================================================
author: Paulo Morone
date: November 02, 2017
autosize: true

Introduction
========================================================

 The final Project requirements are to develop a shiny interactive application.
My choice is related to a real world Supply Chain problem and bellow is a brief explanation.
One of my customer have a huge problem to manage their supplier logistic which and control all quantity of raw material in their warehouse so the production does not stop. Nowadays they run with a very low amount of stock which means that the supplier should delivery at the right time. 
Usually, shipping companies arrange a route for that and in a single route the tuck pass in more than one supplier, load the raw materials and so on until it reaches the Yard where they have a strict control to unload the truck at the docks.


Problem
========================================================

The problem is that a lot of times the truck get late in the supplier which give more time to them to load the truck or suppliers take more time than the arranged and so on. In other words, the truck in runs behind the schedule and compromise the whole production.
The worst scenario is when the truck is more than 4 hours late in a route and they have to stop their manufacture, this causes many issues.

Solution:My proposal to solve this problem, is predict how long the supplier will take to load a truck, and near future I plan to use the Google Maps API to predict how long the truck will take between each supplier allowing me to plan ahead the route allowing the Yard and supplier better plan their logistic.
For this assessment I only implemented a simple linear regression, just to prove the concept.




Data used
========================================================

```r
raw <- read.csv('sample2.csv', sep = ';')
str(raw)
```

```
'data.frame':	19989 obs. of  6 variables:
 $ Route        : Factor w/ 148 levels "IB0201","IB0202",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Supplier     : Factor w/ 114 levels "0002-1","0006-1",..: 100 110 69 73 49 99 100 110 69 73 ...
 $ Scheduled    : Factor w/ 16629 levels "01/07/2017 00:00",..: 35 38 56 98 114 135 991 994 1380 1435 ...
 $ Scheduled_End: Factor w/ 16750 levels "01/07/2017 00:05",..: 11 24 47 84 114 154 1003 1390 1421 1471 ...
 $ Real         : Factor w/ 17001 levels "","01/07/2017 00:03",..: 19 23 48 86 103 129 1014 1017 1413 1463 ...
 $ Real_End     : Factor w/ 16889 levels "01/01/2018 22:00",..: 22 32 53 96 111 162 987 1395 1425 1473 ...
```


New Features
========================================================

<p>Improvements:</p>
<ol>
<li>Develop an ensemble with better accuracy and using more variables;</li>
<li>Integrate with Google API to plan the time between suppliers;</li>
<li>Illustrate the whole route at once instead of show each supplier;</li>
<li>Somehow save its prediction and export it;</li>
<p></p>
<p><strong>Please feel free to suggest any other improvement to it. </strong></p>
<p><strong>Thanks   &#9786; </strong></p>
</ol>
