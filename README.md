# UberSocialNet - applying the Lambda Architecture

**Summary**

Recently, Nathan Marz introduced the Lambda Architecture for realising 
large-scale data processing applications. In this article, we step-by-step 
walk through how to build an application based on this architecture:
*UberSocialNet* (USN), a little helper tool that allows us to keep track of
where we know people from. USN lets us record if we happen to know someone 
from either the digital world, that is, social networks such as Twitter,
Facebook, LinkedIn, G+, etc. or the real life. The goal is that USN can serve 
more than one billion users while providing low-latency access to the 
annotations we keep about where and how we know people.

## Data

The [raw 
data](https://github.com/mhausenblas/usn-app/blob/master/data/usn-base-data.csv)
resides in the `data/` directory and has the following shape in the
base (CSV) format:

	timestamp,originator,action,network,target,context
	2012-03-12T22:54:13-07:00,Michael,ADD,I,Ora Hatfield,Some witty stuff here 
	2012-11-23T01:53:42-08:00,Michael,REMOVE,I,Marvin Garrison,Whatever note ...

with the following schema:

* `timestamp` is an ISO 8601 formatted datetime stamp that states when the 
action was performed (range: January 2012 till May 2013)
* `originator` is the name of the person who added or removed a person to or
from one of his or her networks
* `action` MUST be either `ADD` or `REMOVE`, self-explanatory. 
* `network` is a single character, MUST be one out of `{I, T, L, F, G}`, 
indicating the respective network where the action has been performed, with: 
 * `I` … in-real-life
 * `T` … Twitter
 * `L` … LinkedIn
 * `F` … Facebook
 * `G` … Google+
* `target` is the name of the person added or removed to or from the network
* `context` is a free-text comment, providing a hint why the person has been
added or where one has met the person in the first place

All fields are always present, that is, there are no optional fields. The test
data has been generated using [generatedata.com](http://www.generatedata.com/) 
in five runs totaling some 500 rows of raw data. 


## Processing

The raw data is first 
[pre-processed
](https://github.com/mhausenblas/usn-app/blob/master/data/usn-preprocess.sh) and 
[loaded](https://github.com/mhausenblas/usn-app/blob/master/hive-cmds.txt) into 
Hive:

	hive> CREATE TABLE usn_base (
	 actiontime STRING,
	 originator STRING,
	 action STRING,
	 network STRING,
	 target STRING,
	 context STRING
	) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|';

	hive> LOAD DATA LOCAL INPATH 
	'/Users/mhausenblas2/Documents/repos/usn-app/data/usn-base-data.csv'
	INTO TABLE usn_base;

## Architecture

TBD.

## Dependencies 

* Hive 0.10.0
* HBase 0.94.4

## To do

* Generate the data - DONE
* Implement the batch layer using Hive - DONE
* Implement the serving layer using HBase
* Implement user interface and some examples

## License

All artifacts in this repository, including data and code are donated into
the Public Domain. The author would like to thank MapR Technologies for
sponsoring the work on the USN app.
