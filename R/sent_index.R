#' Pull a specific media sentiment index
#'
#' @param source The news source for which data is sought. Data can either be drawn from all sources (sourc=all), from News24 only (source=news24), or from Business Day only (source=businessday).. 
#' @param model The name of the model to use. Even the general index (i.e. no topics) requires a model name.
#' @param topic The topic which you are interested in.
#' @param freq 	The frequency on which to aggregate the index. Available values: day, week, month.
#' @param dict The dictionary to use in sentiment characterization for the index. Available values: afinn, anew, geninqposneg, huliu, loughran, lsd2015, nrc, vader.
#' @param aggr The within article aggregation method to use. Available values: sent_abspropdiff, sent_relpropdiff, sent_logit, sent_vader, sent_valence.
#'
#' @return tibble.
#' @export
#'
#' @examples
#' # Get global sentiment index.
#' \dontrun{
#' sent_index(
#'    source="all",
#'    model="model_2021-05-15",
#'    topic="global",
#'    freq="month",
#'    dict="loughran",
#'    aggr="sent_logit"
#'    )
#' }
#' 
sent_index <- function(source, model, topic, freq, dict, aggr){

  url <- glue(base_url(), "index?source={source}&model={model}&topic={topic}&freq={freq}&dict={dict}&aggr={aggr}")
  
  response <- GET(url)
  
  check_response_error(response)
  check_response_json(response)
  
  result <- response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    arrange(published_date) %>% 
    as_tibble()
  
  return(result)
  
}