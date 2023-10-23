aconfrs <- function(){

	source( paste0( system.file( package = 'aconfrs' ), "/global.R" ), local=TRUE, encoding = "UTF-8" )
	source( paste0( system.file( package = 'aconfrs' ), "/server.R" ), local=TRUE, encoding = "UTF-8" )
	source( paste0( system.file( package = 'aconfrs' ), "/ui.R" ),     local=TRUE, encoding = "UTF-8" )
	app <- shinyApp( ui, server )
	runApp( app )

}
