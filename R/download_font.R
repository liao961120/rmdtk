#' Download font dependencies for traditional Chinese Rmd PDF output
#'
#' This function is expected to run once after the package is
#' downloaded. It downloads font files into the \code{rmdtk}'s
#' R Markdown template folders, so when a template is used
#' later, it will contained the necessary fonts to work.
#'
#' @export
download_fonts <- function() {
  font_dest_dir <- system.file('rmarkdown', 'templates', 'CJKdocument', 'skeleton', 'latex', package = 'rmdtk')

  download_file2(font_dest_dir)
}

#' Download font dependencies to the directory where header.tex is
#'
#' Make sure this function is called after 1) importing Rmd template
#' and 2) setting the current working directory to that Rmd
#' template folder.
#'
#' @keywords internal
donwload_font2header <- function() {
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



download_file2 <- function(dest_dir) {

  kaiti <- 'https://github.com/sih4sing5hong5/huan1-ik8_lun7-bun5/raw/master/%E5%AD%97%E9%AB%94/kaiu.ttf'
  mono <- 'https://liao961120.github.io/deps/fonts/NotoSansMonoCJKtc.zip'

  cat('Downloading fonts to', dest_dir, '\n')
  temp_kai <- tempfile()
  temp_mono <- tempfile()

  utils::download.file(kaiti, destfile = file.path(dest_dir, 'kaiti'))
  utils::download.file(mono, destfile = temp_mono)

  # Decompress
  utils::unzip(temp_mono, exdir = dest_dir)
}
