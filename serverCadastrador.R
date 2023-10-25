
    #############################################################
    #                                                           #
    #            Server para sessão de "Cadastrador"            #
    #                                                           #
    #############################################################
    
    connTextCadUI <- textConnection( varString_uiCadastrador )
    # Carrega a interface de "Cadastrador"
    insertUI(
    
        selector = "#uiRequisitada",
        where = "afterEnd",
        ui = source( connTextCadUI, local=TRUE )[[1]],
        immediate = TRUE
    
    )
    close( connTextCadUI ); rm( connTextCadUI )

    # Carrega as 'TIPS' da Interface do "Cadastrador"
    connTextCadTips <- textConnection( varString_serverCadastradorTips )
    source( connTextCadTips, local=TRUE )
    close( connTextCadTips ); rm( connTextCadTips )

    # # Carrega as diversas funções do ambiente do "Atribuidor"
    connTextCadastFun <- textConnection( varString_serverCadastradorFun )
    source( connTextCadastFun, local=TRUE )
    close( connTextCadastFun ); rm( connTextCadastFun )

    #######################
    #    Config Iniciais  #
    #######################
    
    # ambiente para guardar as variáveis do Cadastrador
    envCadast <- new.env( parent=globalenv() )
	
	# "mainTableR" para essa Sessão Específica
    envCadast$mainTableR <- mainTableR

	#############################
    #        Config Paineis     #
    #############################

    # Desabilita espaços que são apenas visualizão de informações
    # Usuário não deve editar em nenhum momento
	shinyjs::disable( "nomeCadastrador" )
    shinyjs::disable( "statusCadastrador" )
	shinyjs::disable( "numeroInscIntegrante" )
	

    #########################
    #        Fim: Config    #
    #########################

    #############################################################
    #                                                           #
    #        Inicio da Lógica de Funcionamento do Ambiente      #
    #                                                           #
    #############################################################
    
    # Chama a função: "getDataDB2table" para Criação da Tabela 1
    assign( "dataShowAval", funcGetAvalDB2table(), env=envCadast )

    #############################################################
    #                                                           #
    #            Inicio dos "ObserveEvent"                      #
    #                                                           #
    #############################################################

    # Gera N° de Inscrição e atualiza (mostra) a interface
    observeEvent( input$butGeraNumInscInteg, {
  
		# Gera nº da inscrição
		numInsc <- InscNumberGenerator()
		
		# Gera data da inscrição
		dataInsc <- format(Sys.time(), "%d/%m/%Y %H:%Mh")	
		labTMP <- paste0( "Data e hora da Última Submissão: ", dataInsc )

		# Guarda informação na mainTableR Temporariamente
		envCadast$mainTableR$numeroInsc[1] <- numInsc
		envCadast$mainTableR$dataInsc[1] <- dataInsc
		
		# atualiza interface
		updateTextInput( inputId="numeroInscIntegrante", value=numInsc )
		output$labDataHoraInscInteg <- renderText({ fmTip( labTMP ) })

    })

    # ação do botão "Cadastrar Informações"
    observeEvent( input$butCadastrarInfo, {
	
		if( input$checkGeraInscInteg | input$checkSeraAvaliador |
            input$checkFuncEvento | input$checkTemFunSoftware ){

			funcBotaoSubCadast()
			
		} else {
		
			# Mostra janela de diálogo modal
			showModal( modalDialog(
				tags$h4(
					tags$p( "Preencha ao menos um dos 4 itens do Passo 2" ),
					tags$p( "Após preenchimentos das informações do Passo 1" ),
					tags$br(),
					tags$p( "Preenchimento Obrigatório" ),    
					),
				title = "Informação",
				footer = modalButton("Ok")
			
			))
		
		}

    })





    
    #############################################################
    #                                                           #
    #            Inicio dos "ObserveEvent"                      #
    #                                                           #
    #############################################################
    


    #############################################################
    #                                                           #
    #    4 Monitores de LINKS de Paineis pelos "ObserveEvent"   #
    #                                                           #
    #############################################################
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSCadInfoBasic, {
    
        shinyjs::toggle( "panelCadInfoBasicSub01"  )
    
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSCadParticular, {
    
        shinyjs::toggle( "panelCadParticularSub01"  )
    
    })

    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSQuadroAval, {
    
        shinyjs::toggle( "panelQuadroAvalSub01"  )
    
    })

    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSQuadroOrg, {
    
        shinyjs::toggle( "panelQuadroOrgSub01"  )
    
    })

    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkOrganiz, {
    
        shinyjs::toggle( "wellInfoOrg"  )
    
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkFAvalRes, {
    
        shinyjs::toggle( "wellFAvalRes"  )
    
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkAcessoCMS, {
    
        shinyjs::toggle( "wellAcessoCMS"  )
    
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkGerarNumInsc, {
    
        shinyjs::toggle( "wellGeraInsc"  )
    
    })




