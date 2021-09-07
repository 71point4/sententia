#' Check that API response is JSON
#'
#' @param response A response object.
#'
#' @return NULL. Raises an error if the response is not JSON.
check_response_json <- function(response) {
  if (http_type(response) != "application/json") {
    stop("API did not return json.", call. = FALSE)
  }
}

#' Check API response for errors
#'
#' @param response A response object.
#'
#' @return NULL. Raises an error if response has an error code.
check_response_error <- function(response) {
  if (http_error(response)) {
    status <- status_code(response)
    error <- glue("API request failed [{status}]")
    
    message <- content(response)$message
    if (!is.null(message)) {
      error <- glue("{error}: {message}")
    }
    
    stop(error, call. = FALSE
    )
  }
}

#' Check if user has specified all the parameters
#'
#' @return character
missing_args <- function()
{
  calling_function <- sys.function(1)
  all_args <- names(formals(calling_function))
  all_args <- all_args[all_args != "..."]
  matched_call <- match.call(
    calling_function, 
    sys.call(1), 
    expand.dots = FALSE
  )
  passed_args <- names(as.list(matched_call)[-1])
  setdiff(all_args, passed_args)
}

#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
#' @param retry Number of times to retry request on failure.
GET <- function(url = NULL, config = list(), retry = 5, ...) {
  headers = list()
  
  api_key <- NULL
  try(api_key <- get_api_key(), silent = TRUE)
  
  if (!is.null(api_key)) {
    headers = list("token" = api_key)
  }

  response <- httr::RETRY(
    "GET",
    url,
    config,
    httr::user_agent(glue("sententia [R] ({PKG_VERSION})")),
    ...,
    do.call(add_headers, headers),
    handle = NULL,
    times = retry,
    terminate_on = c(400, 404, 429, 500)
  )
  
  # Check for "400 UNAUTHORISED".
  # Check for "429 LIMIT EXCEEDED".
  #
  if (response$status_code %in% c(400, 429)) {
      out <- response %>% 
        content(as = "text", encoding = "UTF-8") %>%
        fromJSON() %>%
        toJSON(pretty = TRUE)
      
      stop(out, call. = FALSE)
  }
  
  response
}
