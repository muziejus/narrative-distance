# narrative-distance
Take a chunk of text and measure the distances between specified tokens and then do a nearest neighbor analysis.

## Plan

This program takes a chunk of text (tentatively class `Chunk`) and has a list of `Token`s that sit in a dm database. It iterates through the `Chunk` and measures the word distance between every instance of every token as an `Edge`. It then does a nearest neighbor analysis on the various `Token`s, to see which are close and which are distant from one another.

The "original" application is to make a different kind of spatial map of a novel that can run alongside a more conventional spatial mapping of the events of a novel

## info

This project is licensed under the MIT license and was written by Moacir P. de Sá Pereira. Its home is http://github.com/muziejus/narrative-distance.
