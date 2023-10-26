dirRootApp <- paste0( Sys.getenv("USERPROFILE"), "\\Google Drive\\aconfrs\\aconfrs\\bookdown" )
if( dir.exists( dirRootApp ) ) setwd( dirRootApp )
dirRootApp <- paste0( Sys.getenv("USERPROFILE"), "\\Meu Drive\\aconfrs\\aconfrs\\bookdown" )
if( dir.exists( dirRootApp ) ) setwd( dirRootApp )
dirRootApp <- getwd()
dirRootApp
dir()

outup_dir <- paste0( dirname(dirRootApp), '/www/sitebook' )
 
library( bookdown )
rmarkdown::find_pandoc(dir='c:/pandoc')
rmarkdown::pandoc_available()
rmarkdown::pandoc_version()

#create_bs4_book('.')

# verificar template
# res <- bs4_book( template = "default" )
res <- bs4_book( template = "bs4_book_modificado.html" )

render_book( input=".", output_format=res, output_dir=outup_dir )



# Inserir esse trech0:
#-------------------------
#	p {
#	  text-align: justify;
#	}
#-------------------------
# No arquivo: bs4_book.css dentro da pasta: sitebook/bs4_book-1.0.0



rmarkdown::render_site(encoding = 'UTF-8')
rmarkdown::clean_site()

