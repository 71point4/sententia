#' Get the top 50 most frequently occurring positive and negative words.
#' @description Get the top 50 most frequently occurring positive and negative words for a specified model, topic, dictionary, aggregation method, and frequency. The timeframe over which these words are selected depends on the specified frequency (day = 30 days, week = 3 months, month = 6 months).
#' @param source The news source for which data is sought. Data can either be drawn from all sources (sourc=all), from News24 only (source=news24), or from Business Day only (source=businessday).. 
#' @param model The name of the model to use. Even the general index (i.e. no topics) requires a model name.
#' @param topic The topic which you are interested in.
#' @param freq 	The frequency on which to aggregate the index. Available values: day, week, month.
#' @param dict The dictionary to use in sentiment characterization for the index. Available values: afinn, anew, geninqposneg, huliu, loughran, lsd2015, nrc, vader.
#'
#' @return tibble.
#' @export
#'
#' @examples
# Get the top 50 most frequently occurring positive and negative words. (day = 30 days, week = 3 months, month = 6 months)
#' 
#' \dontrun{
#' sent_word_polarity(
#'    source="all",
#'    model="model_2021-05-15",
#'    topic="global",
#'    freq="month",
#'    dict="loughran"
#'    )
#' }
#' 
sent_word_polarity <- function(source, model, topic, freq, dict){
  check_args <- missing_args() %>% 
    glue_collapse(., sep = ",")
  
  if(length(check_args)){
    stop(glue("Please specify missing argument: [{check_args}]"))
  }
  
  url <- glue(base_url(), "word_polarity?source={source}&model={model}&topic={topic}&freq={freq}&dict={dict}")
  
  response <- GET(url)
  
  check_response_error(response)
  check_response_json(response)
  
  result <- response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble()
  
  return(result)
  
}