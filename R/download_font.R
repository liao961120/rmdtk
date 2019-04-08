#' Download font dependencies for traditional Chinese Rmd PDF output
#'
#' Make sure this function is called after 1) importing Rmd template
#' and 2) setting the current working directory to that Rmd
#' template folder.
#'
#' @export
donwload_font <- function() {
  header_tex_path <- list.files(getwd(), 'header.tex', recursive = T, full.names = T)

  # Check header.tex path
  if (length(header_tex_path) == 0) {
    stop('`header.tex` not found!')
  } else if (length(header_tex_path) > 1) {
    cat('Multiple `header.tex` found at\n',
        paste0('`', header_tex_path, '`', collapse = '\n'), sep = '\n')
    stop('Multiple `header.tex` found!')
  }

  # Switch to destination folder
  ori_dir <- getwd()
  setwd(dirname(header_tex_path))
  on.exit({setwd(ori_dir)}, add = TRUE)

  download_file(ori_dir)
}



download_file <- function(ori_dir) {
  on.exit({setwd(ori_dir)}, add = TRUE)
  cwd <- getwd()

  kaiti <- 'https://liao961120.github.io/deps/fonts/bkai00mp.zip'
  mono <- 'https://liao961120.github.io/deps/fonts/NotoSansMonoCJKtc.zip'

  cat('Downloading fonts to', cwd, '\n')
  temp_kai <- tempfile()
  temp_mono <- tempfile()
  utils::download.file(kaiti, destfile = temp_kai)
  utils::download.file(mono, destfile = temp_mono)

  # Decompress
  utils::unzip(temp_kai, exdir = cwd)
  utils::unzip(temp_mono, exdir = cwd)
}
