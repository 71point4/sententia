#' Get a count of the number of positive and negative articles.
#'
#' @param source The news source for which data is sought. Data can either be drawn from all sources (sourc=all), from News24 only (source=news24), or from Business Day only (source=businessday).. 
#' @param model The name of the model to use. Even the general index (i.e. no topics) requires a model name.
#' @param topic The topic which you are interested in.
#' @param freq 	The frequency on which to aggregate the index. Available values: day, week, month.
#' @param dict The dictionary to use in sentiment characterization for the index. Available values: afinn, anew, geninqposneg, huliu, loughran, lsd2015, nrc, vader.
#' @param aggr The aggregation method to use. Available values: sent_abspropdiff, sent_relpropdiff, sent_logit, sent_vader, sent_valence.
#'
#' @return tibble.
#' @export
#'
#' @examples
#' # Get a count of the number of positive and negative articles for a specified model, topic, dictionary, aggregation method, and frequency.
#' \dontrun{
#' sent_date_polarity(
#'    source="all",
#'    model="model_2021-05-15",
#'    topic="global",
#'    freq="month",
#'    dict="loughran",
#'    aggr="sent_logit"
#'    )
#' }
#' 
sent_date_polarity <- function(source, model, topic, freq, dict, aggr){
  check_args <- missing_args() %>% 
    glue_collapse(., sep = ",")
  
  if(length(check_args)){
    stop(glue("Please specify missing argument: [{check_args}]"))
  }
  
  url <- glue(base_url(), "date_polarity?source={source}&model={model}&topic={topic}&freq={freq}&dict={dict}&aggr={aggr}")
  
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