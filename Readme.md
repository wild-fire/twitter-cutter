# Twitter Cutter

## What is this repo for?

For an analysis on Twitter datasets we found that formats and different data available on each dataset was a problem.

We decided that we needed to homegeneize all the data, extracting a combined dataset with a minimum of information (user id, tweet id, content, date...).

This is the goal of this repo, to be able to homogeneize datasets currently handled by our group with research purposes.

## Why Wukong?

When we analyzed the problem we found out that this is a problem suitable for a Map/Reduce approach, and so we studied how to integrate easily with Hadoop.

While evaluating using Java or some of the ruby bindings for Hadoop Streaming we came into [Wukong](https://github.com/infochimps-labs/wukong) which defines itself as `friends with Hadoop the elephant, Pig the query language, and the cat on your command line.`.

So basically we could develop without Hadoop (just with plain good old cats and pipes) and when datasets get big enough jump to something more advanced such as Hadoop. Well, that sounds as not overoptimizing which is cool. We could deal with problems just when we get into them, not at the very begginning!

If, finally, we have to leave Ruby and embrace Java we will do it with some datasets that will make worthy this working time.

## What's implemented so far

### Datasets normalized

We have included some samples of the datasets we are currently working with:

  * CIKM 2010
  * Edinburgh
  * Gayo-Avello
  * M. De Choud
  * O'Connor
  * SNAP
  * UMAP

Then we developed normalizers to reduce all these datasets to a normalized version each. These normalized versions include the following fields:

  * Tweet id
  * Unix timestamp od the creation time
  * Creation time on a readable format
  * User id
  * User name
  * Tweet text

Not all datasets had all the information. When some data is not found we just put a `NULL` instead.

## TODO

  * Merge normalized datasets into one large normalized dataset
  * Sort normalized dataset

## Contribution? Issues?

If you want to submit some code just fork the project and request a pull.

If you want to discuss something feel free to use the issues section.