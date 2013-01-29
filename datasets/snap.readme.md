# Dataset

Snap

## Paper

## Contents

In this dataset tweets are splitted over three lines:

```
T    [date(YYYY-MM-DD HH:mm:ss)]
U    [link_to_user_profile]
W    [tweet]
```
Because of this we had to do some preprocessing on the files, joining the fields in just one line

```
  cat datasets/snap.example | sed -r ':a;N;$!ba;s/\n[TUW]\s*/\t/g'
```

This way we get the following structure:

```
[junk_or_blank]\t[date(YYYY-MM-DD HH:mm:ss)]\t[link_to_user_profile]\t[tweet]
```

## Date ranges

2009/06 - 2009/12

