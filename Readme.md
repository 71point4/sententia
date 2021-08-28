
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
set_api_key("700ce27d55e27922a39232f8403602ba")
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
   freq = "week",
   dict = "loughran",
   aggr = "sent_logit"
   )
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
```
