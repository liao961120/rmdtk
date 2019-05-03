rmarkdown::render('index.Rmd')

if (!dir.exists('docs')) {
  dir.create('docs')
} else {
  unlink('docs', recursive = TRUE)
  dir.create('docs')
}

file.copy(from = c('index_files', 'addons', 'img', 'index.Rmd', 'index.html'), to = 'docs', overwrite = TRUE, recursive = TRUE)
