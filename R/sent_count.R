#' Get a count of the number of articles for a specified media source.
#'
#' @param source The news source for which data is sought. Data can either be drawn from all sources (sourc=all), from News24 only (source=news24), or from Business Day only (source=businessday).. 
#' @param model The name of the model to use. Even the general index (i.e. no topics) requires a model name.
#' @param topic The topic which you are interested in.
#' @param freq 	The frequency on which to aggregate the index. Available values: day, week, month.
#'
#' @return tibble.
#' @export
#'
#' @examples
#' # Get a count of the number of articles for a specified media source, model, topic, and frequency of aggregation.
#' \dontrun{
#' sent_counts(
#'    source="all",
#'    model="model_2021-05-15",
#'    topic="global",
#'    freq="month",
#'    )
#' }
#' 
sent_counts <- function(source, model, topic, freq){
  
  url <- glue(base_url(), "counts?source={source}&model={model}&topic={topic}&freq={freq}")
  
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