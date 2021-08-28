
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
set_api_key("412dd2813fbf9037f5266557bbf5d1f5")
```

To obtain a key, please get in touch. Contact details are in
`DESCRIPTION`.

## Sentiment Index

``` r
sent_index(
   source="all",
   model="model_2021-05-15",
   topic="global",
   freq="month",
   dict="loughran",
   aggr="sent_logit"
   )
```
