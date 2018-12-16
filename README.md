# Overview
The two files, app.r and mark-off.r, are an attempt to implement a word prediction algorithm for the Coursera Data Science capstone.

# mark-off.r
This file contains two functions: mkgrams and checkit, with the latter appearing in app.r. The mkgrams function builds a ngram dictionary, storing from 1 to 4 ngrams, where each key is associated with a list of seen single words that have followed the ngram. 

# The Markov assumption and the backoff alogorithm
With the dictionary used as a lookup for seen ngrams, it's with this Markov chain that a probability determines which word from a given matched ngram is returned. Should there be no match in a given ngram, the backoff algorithm naively moves to the next ngram set to seek a match.
