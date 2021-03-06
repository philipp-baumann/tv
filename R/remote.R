remote_tv <- function(path, port) {
  library(shiny)
  shiny::shinyOptions(tv_path = path)
  runApp(system.file(package = "tv", "app"), port = port)
}

remote_tv_in_own_session <- function(path, port) {

  .tv_env$cl <- parallel::makeCluster(1)
  future::remote(remote_tv(path = path, port = port), workers = .tv_env$cl)

  Sys.sleep(0.5)

  tv_url <- paste0("http://127.0.0.1:", port)

  if (Sys.getenv("RSTUDIO") == "1") {
    rstudioapi::viewer(tv_url)
  } else {
    browseURL(tv_url)
  }

}

