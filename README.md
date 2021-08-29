
# sententia <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![](https://img.shields.io/github/last-commit/71point4/sententia.svg)](https://github.com/71point4/sententia/commits/develop)

[Sententia](https://github.com/71point4/sententia) provides access to
media sentiment data from the Bureau for Economic research.

The homepage for the {sententia} R package is at
<https://github.com/71point4/sententia>.

## Installation

Install from GitHub.

``` r
remotes::install_github("71point4/sententia")
```

If you want availability to the latest features (at your own risk) then
you can also install from the development branch.

``` r
remotes::install_github("71point4/sententia", ref = "dev")
```

## Usage

``` r
library(sententia)
```

Check version.

``` r
packageVersion("sententia")
```

### Set API Key

To access the API you’ll need to first specify an API key as provided to
you by the BER.

``` r
# Example API key (this key will not work).
set_api_key("7b58ffa5afcf893d678433a56e0edca4")
get_api_key()
```

If you wish not to set the key every time, use
`usethis::edit_r_environ()` to set the key to `SENTENTIA_KEY`.

To obtain a key, please get in touch. Contact details are in
`DESCRIPTION`.

## Sentiment Index

Get media sentiment index values for specified media source, model,
topic, dictionary, frequency, and aggregation method combination.

``` r
sent_index(
   source = "all",
   model = "model_2021-05-15",
   topic = "global",
   freq = "month",
   dict = "loughran",
   aggr = "sent_logit"
   )

# # A tibble: 734 × 9
#    source published_date dict_name type     aggr_type  mean_sentiment relative absolute sent_log
#    <chr>  <chr>          <chr>     <chr>    <chr>               <dbl>    <int>    <dbl>    <int>
#  1 all    1970-01-01     loughran  polarity sent_logit        -0.0058        0        0        0
#  2 all    1970-01-01     loughran  polarity sent_logit        -0.969        -1       -1        0
#  3 all    1970-01-01     loughran  polarity sent_logit         0.713         1        1        0
#  4 all    2001-01-01     loughran  polarity sent_logit        -1.49         -1       -1        0
#  5 all    2001-01-01     loughran  polarity sent_logit         0             0        0        0
#  6 all    2001-01-01     loughran  polarity sent_logit         0.741         1        1        0
#  7 all    2001-02-01     loughran  polarity sent_logit        -1.25         -1       -1        0
#  8 all    2001-02-01     loughran  polarity sent_logit        -0.0026        0        0        0
#  9 all    2001-02-01     loughran  polarity sent_logit         0.818         1        1        0
# 10 all    2001-03-01     loughran  polarity sent_logit        -0.0008        0        0        0
# # … with 724 more rows
```

# Count of articles that make up sentiment

Get a count of the number of articles for a specified media source,
model, topic, and frequency of aggregation.

``` r
sent_counts(
   source = "all",
   model = "model_2021-05-15",
   topic = "global",
   freq = "week"
   )

# # A tibble: 1,049 × 2
#    published_date article_count
#    <chr>                  <int>
#  1 1969-12-29                91
#  2 2001-01-01                37
#  3 2001-01-08                56
#  4 2001-01-15                76
#  5 2001-01-22                70
#  6 2001-01-29                19
#  7 2001-02-05                46
#  8 2001-02-12                63
#  9 2001-02-19               140
# 10 2001-02-26               178
# # … with 1,039 more rows
```

# Date polarity

Get a count of the number of positive and negative articles for a
specified model, topic, dictionary, aggregation method, and frequency.

``` r
sent_date_polarity(
   source = "all",
   model = "model_2021-05-15",
   topic = "global",
   freq = "week",
   dict = "loughran",
   aggr = "sent_logit"
   )

# # A tibble: 3,122 × 7
#    source published_date dict_name type     aggr_type  positive_words negative_words
#    <chr>  <chr>          <chr>     <chr>    <chr>               <int>          <int>
#  1 all    1969-12-29     loughran  polarity sent_logit              0             59
#  2 all    1969-12-29     loughran  polarity sent_logit              0              0
#  3 all    1969-12-29     loughran  polarity sent_logit             28              0
#  4 all    2001-01-01     loughran  polarity sent_logit              0             32
#  5 all    2001-01-01     loughran  polarity sent_logit              5              0
#  6 all    2001-01-08     loughran  polarity sent_logit              0             40
#  7 all    2001-01-08     loughran  polarity sent_logit              9              0
#  8 all    2001-01-08     loughran  polarity sent_logit              0              0
#  9 all    2001-01-15     loughran  polarity sent_logit             11              0
# 10 all    2001-01-15     loughran  polarity sent_logit              0              0
# # … with 3,112 more rows
```

# Word polarity

Get the top 50 most frequently occurring positive and negative words for
a specified model, topic, dictionary, aggregation method, and frequency.
The timeframe over which these words are selected depends on the
specified frequency (day = 30 days, week = 3 months, month = 6 months).

``` r
sent_word_polarity(
   source = "all",
   model = "model_2021-05-15",
   topic = "economy",
   freq = "month",
   dict = "loughran"
   )

# # A tibble: 100 × 8
#    source topic_econ tokens       dict_name sentiment mentions word_rank date_range             
#    <chr>  <chr>      <chr>        <chr>     <chr>        <int>     <int> <chr>                  
#  1 all    economy    against      loughran  negative      1670         1 2021-02-28 - 2021-08-28
#  2 all    economy    concerns     loughran  negative       852         2 2021-02-28 - 2021-08-28
#  3 all    economy    lost         loughran  negative       790         3 2021-02-28 - 2021-08-28
#  4 all    economy    crisis       loughran  negative       754         4 2021-02-28 - 2021-08-28
#  5 all    economy    losses       loughran  negative       604         5 2021-02-28 - 2021-08-28
#  6 all    economy    unrest       loughran  negative       583         6 2021-02-28 - 2021-08-28
#  7 all    economy    unemployment loughran  negative       554         7 2021-02-28 - 2021-08-28
#  8 all    economy    challenges   loughran  negative       552         8 2021-02-28 - 2021-08-28
#  9 all    economy    late         loughran  negative       530         9 2021-02-28 - 2021-08-28
# 10 all    economy    violence     loughran  negative       528        10 2021-02-28 - 2021-08-28
# # … with 90 more rows
```