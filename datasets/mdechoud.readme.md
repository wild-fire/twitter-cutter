# Dataset

MDeChoud

## Paper
"How does the data sampling strategy impact the discovery of information diffusion in social media" by De Choudhury, M. and Lin, Y.R. and Sundaram, H. and Candan, K.S. and Xie, L. and Kelliher, A.

## Contents

It has 10.467.110 lines with the following structure:

```
[twitter_name]\t[date(YYYY-MM-DD HH:mm:ss)]\t[tweet]
```

Some tweets may have \n so they are splitted in lines:

```
  Palloo  2009-10-04 22:36:05     Twitter Weekly Updates for 2009-10-04: \
    Twitter Weekly Updates for 2009-09-27:\
    Twitter Weekly Updates for 2009-.. http://bit.ly/2zsrn7
```

Because of this we may have to do some preprocessing on the file, stripping those end of lines preceded by \ with sed.

```
  cat datasets/mdechoud.example | sed -r ':a;N;$!ba;s/\\\n/ /g'
```

## Date ranges

2008/11 - 2009/10

