# Dataset

Umap

## Paper

## Contents

This dataset is an sql dump of a twitter database with plenty of fields (id, user id, user name, content, creation time, replies, retweets...).

In order to extract the right info from this database and homogenize the datasets we only need an SQL Query to export it to some files:

```sql
SELECT id, UNIX_TIMESTAMP(creationTime), creationTime, userId, userName, content FROM tweets_sample LIMIT 50 INTO OUTFILE '/tmp/umap.normalized' FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
```

## Date ranges

2009/06 - 2009/12

