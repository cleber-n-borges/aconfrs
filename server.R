server <- function( input, output, session ) {

    #######################
    #    Config Iniciais  #
    #######################
    
    # função "clearall" definida em global.R
    session$onSessionEnded( clearall )
    # função "setIniSession" definida em global.R
    session$onFlushed( setIniSession, once=TRUE )

    # Tamanho Máximo de Arquivo permitido para Upload
    options( shiny.maxRequestSize=15*1024^2 )
    
    # Carrega funções do Server Geral
    connTextServerFun <- textConnection( varString_serverFun )
    source( connTextServerFun, local = TRUE )
    close( connTextServerFun ); rm( connTextServerFun )

    ############################################################
    # Personalização da tela de desconexão: 
    # https://sever.john-coene.com/sever/ 
    disconnected <- sever_default(
        subtitle = "Sucesso na Desconexão do Sistema!", 
        title = "Sessão Finalizada", 
        button = "Reconectar", 
        button_class = "info"
    )
    
    sever( html = disconnected, bg_color = "white", color = "black" )
	
    #############################################################
    #                                                           #
    #        Determina Qual Interface será Carregada            #
    #                                                           #
    #############################################################

    login <- "XXX"
    
    login <- "participante"
    
    connTextServerParticip <- textConnection( varString_serverParticipante )
    if( login == "participante" ) source( connTextServerParticip, local = TRUE )
    close( connTextServerParticip ); rm( connTextServerParticip )
    
    login <- "avaliador"
    
    connTextServerAval <- textConnection( varString_serverAvaliador )
    if( login == "avaliador" ) source( connTextServerAval, local = TRUE )
    close( connTextServerAval ); rm( connTextServerAval )

    login <- "atribuidor"

    connTextServerAtrib <- textConnection( varString_serverAtribuidor )
    if( login == "atribuidor" ) source( connTextServerAtrib, local = TRUE )
    close( connTextServerAtrib ); rm( connTextServerAtrib )
    
    login <- "cadastrador"

    connTextServerCadAval <- textConnection( varString_serverCadastrador )
    if( login == "cadastrador" ) source( connTextServerCadAval, local = TRUE )
    close( connTextServerCadAval ); rm( connTextServerCadAval )
    

    #############################################################
    #                                                           #
    #            Inicio dos "ObserveEvent"                      #
    #                                                           #
    #############################################################
    
    shinyjs::disable( "ToggleUIAdmin" )
    shinyjs::disable( "ToggleUIFinanca" )
    shinyjs::disable( "ToggleUISubevento" )
    shinyjs::disable( "ToggleUIComunica" )
    
    # orienta que o Firefox tem BUG
    # observe( if( shinybrowser::is_browser_firefox() ) callFirefoxAlert() )
    
    # desconectar com Segurança
    observeEvent( input$desconectSeg, {

        session$close()
        res <- session$isClosed()
        #print( paste0( "resultado da função isClosed() é: ", res ) ) 
        #print( paste0( "input$enterNumeroInsc: ", input$enterNumeroInsc ) )
        
    })
    
    shinyjs::show( "interfaceParticipante" )
    
    #############################################################
    #                                                           #
    #        Inicio dos Botões Toggle (Facilitar DEMO)          #
    #                                                           #
    #############################################################
    
    #---8<-----------------------------------------------------------
    # INI: aqui vai um monte de coisa temporaria
    
    observeEvent( input$ToggleUIParticipante, {
        shinyjs::hide(selector="[id^='interface']")
        shinyjs::show("interfaceParticipante")
        print( mem_used() )
    })
    
    observeEvent( input$ToggleUIAvaliador, {
        shinyjs::hide(selector="[id^='interface']")
        shinyjs::show("interfaceAvaliador")
        print( mem_used() )
    })
    
    observeEvent( input$ToggleUIAtribuidor, {
        shinyjs::hide(selector="[id^='interface']")
        shinyjs::show("interfaceAtribuidor")
        print( mem_used() )
    })
    
    observeEvent( input$ToggleUICadastroAval, {
        shinyjs::hide(selector="[id^='interface']")
        shinyjs::show("interfaceCadastrador")
        print( mem_used() )
    })
    
    observeEvent( input$butSobre, {
        shinyjs::hide(selector="[id^='interface']")
        insertUI(
            selector = "#uiSobre",
            where = "afterEnd",
            ui = source( "uiSobre.R", local=TRUE )[[1]],
            immediate = TRUE
        
        )
        shinyjs::show("interfaceSobre")
        print( mem_used() )
    })
	
	observeEvent( input$butFAQ, {
        shinyjs::hide(selector="[id^='interface']")
        insertUI(
            selector = "#uiFAQ",
            where = "afterEnd",
            ui = source( "uiFAQ.R", local=TRUE )[[1]],
            immediate = TRUE
        
        )
        shinyjs::show("interfaceFAQ")
        print( mem_used() )
    })
    
    observeEvent( input$butConferencia, {
        shinyjs::hide(selector="[id^='interface']")
        insertUI(
            selector = "#uiConferencia",
            where = "afterEnd",
            ui = source( "uiConferencia.R", local=TRUE )[[1]],
            immediate = TRUE
        
        )
        shinyjs::show("interfaceConferencia")
        print( mem_used() )
    })
    
    .simpleCap <- function(x) {
        s <- strsplit(x, " ")[[1]]
        paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
    }
    
    oldBtnClicks <- rep(0,17)
    
    #####################################################
    temas <- c( "bootstrap", "cerulean", "cosmo", "cyborg", "darkly", "flatly", "journal",
                "lumen", "paper", "readable", "sandstone", "simplex", "slate", "spacelab",
                "superhero", "united", "yeti" )
    #####################################################    
    
    observeEvent({ butTemaObs <<- list( input$butTemaDefault, input$butTemaCerulean, input$butTemaCosmo,
        input$butTemaCyborg, input$butTemaDarkly, input$butTemaFlatly, input$butTemaJournal, input$butTemaLumen, 
        input$butTemaPaper, input$butTemaReadable, input$butTemaSandstone, input$butTemaSimplex,
        input$butTemaSlate, input$butTemaSpacelab, input$butTemaSuperhero, input$butTemaUnited, 
        input$butTemaYeti ) }, ({
        
        buttonClicked <- match(1, unlist( butTemaObs ) - oldBtnClicks)
        
        oldBtnClicks <<- unlist( butTemaObs )
        
        if( is.na(buttonClicked ) | buttonClicked == 1 ){# Default: Bootstrap
        
            js <- "$('#theme').attr('href', 'css/bootstrap.min.css');"
            
            runjs( js )
            
            msg <- "<p class='text-primary'>Tema padrão: Bootstrap</p>"

        } else {
        
            curThemePath <- paste0( 'shinythemes/css/',  temas[ buttonClicked ], '.min.css' )
        
            js <- paste0( "$('#theme').attr('href', '", curThemePath, "');"   )
        
            runjs( js )
            
            msg <- .simpleCap( temas[ buttonClicked ] )
            msg <- paste0( "<p class='text-primary'>Tema selecionado: ", msg, "</p>" )
			
        }

        output$labTemaEscolhido <- renderText({ msg })
		
		set_cookie( cookie_name="aconfrsTheme", cookie_value=temas[ buttonClicked ] )

    }))
    
    observeEvent( input$butXXX, {
    
        showModal( modalDialog(
        
            tags$h4(
            
                tags$p( style="text-align:center;", "" ),
                
                tags$br(),
				
				tags$p( style="text-align:center;", "" ),
				
                tags$br(),
				
                tags$p( style="text-align:center;", tags$img( src = "www/muttley.webp", heigth="150", width="120" ) ),
                
                tags$br(),
                
                tags$p( style="text-align:center;", ""  )
                
            ),
            
            title = "Botão sem Função",
            
            footer=tagList( modalButton( "Ok" ) )
            
        ))
    
    })
	
   

    ### Teste provisorio - PRIMEIRA Chamada de Interface por botão
    # 
    # observeEvent( input$butYY2, {
    # 
    #     connTextServerParticip <- textConnection( varString_serverParticipante )
    #     source( connTextServerParticip, local = TRUE )
    #     close( connTextServerParticip ); rm( connTextServerParticip )
    # 
    # })
    #
    ### Teste provisorio - PRIMEIRA Chamada de Interface por botão
    












} # Fim da declaração da função "server"
    
