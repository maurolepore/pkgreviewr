# TODO: Refactor to remove dependencies.

#' Review dependency usage: Count used functions from external packages.
#' 
#' @inheritParams functionMap::map_r_package
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' \dontrun{
#' rev_dependency_usage(path = ".")
#' }
rev_dependency_usage <- function(path, include_base = FALSE) {
  map <- functionMap::map_r_package(path, include_base)$node_df
  map %>% 
  dplyr::filter(!own) %>%
  dplyr::filter(ID != "::") %>% 
  tidyr::separate(ID, into = c("package", "fn"), sep = "::") %>% 
  dplyr::group_by(package) %>% 
  dplyr::summarize(
    n = length(unique(fn)), functions = paste0(fn, collapse = ", ")
  )
}