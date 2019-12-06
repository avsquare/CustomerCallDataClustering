# CustomerCallDataClustering

## Introduction
The Mobile phone activity dataset is composed by one week of Call Details Records (CDRs) from the city of Milan and the Province of Trentino (Italy).

## Description of the dataset
Every time a user engages a telecommunication interaction, a Radio Base Station (RBS) is assigned by the operator and delivers the communication through the network. Then, a new CDR is created recording the time of the interaction and the RBS which handled it. The following activities are present in the dataset:

* received SMS
* sent SMS
* incoming calls
* outgoing calls
* Internet activity

In particular, Internet activity is generated each time a user starts an Internet connection or ends an Internet connection. Moreover, during the same connection a CDR is generated if the connection lasts for more than 15 min or the user transferred more than 5 MB.

The datasets is spatially aggregated in a square cells grid. The area of Milan is composed of a grid overlay of 1,000 (squares with size of about 235×235 meters. This grid is projected with the WGS84 (EPSG:4326) standard. For more details we link the original paper enter link description here http://go.nature.com/2fcOX5E

The data provides CellID, CountryCode and all the aforementioned telecommunication activities aggregated every 60 minutes.

## Original datasource
The Mobile phone activity dataset is a part of the Telecom Italia Big Data Challenge 2014, which is a rich and open multi-source aggregation of telecommunications, weather, news, social networks and electricity data from the city of Milan and the Province of Trentino (Italy). The original dataset has been created by Telecom Italia in association with EIT ICT Labs, SpazioDati, MIT Media Lab, Northeastern University, Polytechnic University of Milan, Fondazione Bruno Kessler, University of Trento and Trento RISE. In order to make it easy-to-use, here we provide a subset of telecommunications data that allows researchers to design algorithms able to exploit an enormous number of behavioral and social indicators. The complete version of the dataset is available at the following link: http://go.nature.com/2fz4AFr

## Relevant, external, data sources
The presented datasets can be enriched by using census data provided by the Italian National Institute of Statistics (ISTAT) (http://www.istat.it/en/), a public research organization and the main provider of official statistics in Italy. The census data have been released for 1999, 2001 and 2011. The dataset (http://www.istat.it/it/archivio/104317), released in Italian, is composed of four parts: Territorial Bases (Basi Territoriali), Administrative Boundaries (Confini Amministrativi), Census Variables (Variabili Censuarie) and data about Toponymy (Dati Toponomastici).

Motivational video: https://www.youtube.com/watch?v=_d2_RWMsUKc

