
    #####################################################
    #                                                   #
    #                    Variáveis GLOBAIS              #
    #                                                   #
    #            Auxiliares na construção do APP        #
    #                                                   #
    #####################################################
    
    # função para a formatação das TIP's
    fmTip <- function( lab ) HTML( paste0('<span class="help-block"><ul><li><em>', lab, '</em></li></ul></span>') )

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "InscNumberGenerator"     #
    #                                                           #
    #############################################################
    
    InscNumberGenerator <- function() {Sys.sleep(2); format(Sys.time(), "%y%j%H%M%S")}
    
    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "password"                #
    #                                                           #
    #############################################################
    
    password <- function(){
    
        from <- c( letters, LETTERS, 0:9, "?", "!", "&", "%", "$"  )
        paste( sample( from, 25, replace=T ), collapse='' )
    
    }




    #############################################################
    #                                                           #
    #                                                           #
    #                                                           #
    #############################################################
	
    clearall <- function() {
        #rm( list = ls( all = TRUE ) )
        #cat("\n(Chamada no fim de cada sessão de usuário: clearall)\n\n")
        #cat("\n...Todas variaveis removidas...")
        #cat("\n\n--- Sessão finalizada ---\n")
    }

    setIniSession <- function(){
        #cat("\n####################\n")
        #cat("\nonFlush acionado\n")
        #cat("\nUsar espaço para que?? ajustar Variáveis de uma Sessão Específica???\n")
        #cat("\n--- A partir daqui começará a nova Sessão Específica ---\n")
        #cat("\n####################\n")
		
		
		# Verifica se há o cookie do Tema
		
		aconfrsTheme <- isolate( get_cookie("aconfrsTheme") )

		if( !is.null( aconfrsTheme ) ){
	
			aconfrsTheme <- paste0( 'shinythemes/css/',  aconfrsTheme, '.min.css' )
		
			js <- paste0( "$('#theme').attr('href', '", aconfrsTheme, "');"   )

			runjs( js )
			
		}
		
    }



