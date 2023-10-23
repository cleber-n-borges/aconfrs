
	# orienta que o Firefox tem BUG
	callFirefoxAlert <- function(){
	
		showModal( modalDialog( fade = TRUE,
			tags$h4(
				tags$p("O navegador Firefox possui BUG quanto ao:"),
				tags$br( ),
				tags$p("- CACHE Persistente de Dados em formulários"),
				tags$br( ),
				tags$p("O mesmo prejudica o perfeito funcionamento do aplicativo."),
				tags$p("Por favor, utilize outro navegador!") 
				),
			title = "Funcionalidade do Aplicativo",
			footer=tagList(
				actionButton( "firefoxButOk", "Ok" ),
				modalButton( "Ignorar" )
			)
		))
		
		observeEvent( input$firefoxButOk, { session$close() } )
	}


	# library( pryr )  ?mem_used <- copia
	mem_used <- function() {
		r <- sum( gc()[,1] * c(56,8) )
		class( r ) <- "object_size"
		r <- format( r, units='Mb')
		return( paste0( "memória usada: ", r ) )
	}
	#print( mem_used() )


	onStop( function() {
		cat( "\nSessão de Usuário Terminada - App continua!\n" )
		ls()
		gc()
		print( mem_used() )
	})
