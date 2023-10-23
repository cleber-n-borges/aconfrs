
    #############################################################
    #                                                           #
    #         Declaração da FUNÇÃO "funcBotaoSubCadast"         #
    #                                                           #
    #############################################################
    
    funcBotaoSubCadast <- function(){
	
	    # desabilita o botão de "Cadastrar Informações"
        #shinyjs::disable("butCadastrarInfo")

        # cria uma cópia local por simplicidade
        mainTableR <- envCadast$mainTableR
		
		# atualiza mark
        mainTableR$mark[1] <- paste0( mainTableR$mark[[1]], ' &#10004;' )

		#################################################################
		
	    # Informações sobre o Participante:
		#
		# Passo 1A - Informações Básicas do Integrante
		#
        mainTableR$nome[1]         <- as.character( input$nomeIntegrante )
        mainTableR$cpf[1]          <- as.character( input$cpfIntegrante )
        mainTableR$email[1]        <- as.character( input$emailIntegrante )
        mainTableR$cracha[1]       <- as.character( input$crachaIntegrante )       
        mainTableR$afiliaInstit[1] <- as.character( input$instituicaoInteg )
		
		# Passo 2A - Particularidades do Integrante para o Evento
		#
		if( input$checkGeraInscInteg ){
			
			mainTableR$modalInscric[1] <- input$modalInscIntegrante
			mainTableR$numeroInsc[1] <- input$numeroInscIntegrante
			mainTableR$senha[1] <- password()
			
			# Detalhes adicionais da DB de Participante
			mainTableR$modalParticip <- "Sem Resumo"
			mainTableR$travaEdicao <- FALSE
			
            # Grava os Dados Gerais na DB; tabela dos Participantes
            dbWriteTable( conDB, "mainTable", mainTableR, append=TRUE )

		}
		
		if( input$checkSeraAvaliador ){

			atributosAval <- data.frame(
			
				'nome'=mainTableR$nome[1],
				'cpf'=mainTableR$cpf[1],
				'senha'=password(),
				'email'=mainTableR$email[1],
				'cracha'=mainTableR$cracha[1],
				'afiliaInstit'=mainTableR$afiliaInstit[1],
				'subAreaAval'=input$areaAvaliador,
				'palavChavAreaAval'=as.character( input$palavChavAval )
			
			)

			# Grava os Dados na DB; tabela dos Avaliadores
			dbWriteTable( conDB, "avaliadoresTable", atributosAval, append=TRUE )
		
		}
		
		if( input$checkFuncEvento | input$checkTemFunSoftware  ){
		
			atributosOrganiz <- data.frame(
			
				'nome'=mainTableR$nome[1],
				'cpf'=mainTableR$cpf[1],
				'senha'=password(),
				'email'=mainTableR$email[1],
				'cracha'=mainTableR$cracha[1],
				'afiliaInstit'=mainTableR$afiliaInstit[1],
				'funcaoOrganiz'=NA,
				'funcaoSoftCMS'= NA

			)
			
			if( input$checkFuncEvento ) atributosOrganiz$funcaoOrganiz <- input$funcaoEvento	
			if( input$checkTemFunSoftware ) atributosOrganiz$funcaoSoftCMS <- input$softwareFuncInteg
			
			# Grava os Dados na DB; tabela da Organização
			dbWriteTable( conDB, "organizacaoTable", atributosOrganiz, append=TRUE )

		}

		# abilita o botão de "Cadastrar Informações"
        shinyjs::enable("butCadastrarInfo")
		
		# Mostra janela de diálogo modal
		showModal( modalDialog(
			tags$h4(
				tags$p( "Cadastro das Informações realizado com Sucesso!" ),
				tags$br(),
				tags$p( "Interface atualizada para novas ações" ),    
				),
			title = "Informação",
			footer = modalButton("Ok")
		
		))
		
		# Reset da Interface
		
		# Dados Gerais
		updateTextInput( inputId='nomeIntegrante', value="" )
		updateTextInput( inputId='cpfIntegrante', value="" )
		updateTextInput( inputId='emailIntegrante', value="" )
		updateTextInput( inputId='crachaIntegrante', value="" )
		updateTextInput( inputId='instituicaoInteg', value="" )
		
		# aba 1-Inscrição
		updateCheckboxInput( inputId='checkGeraInscInteg', value=FALSE )
		updateTextInput( inputId='numeroInscIntegrante', value="" )
		labTMP <- "Data e hora da Última Submissão: (Geração do Número de Inscrição)"
		output$labDataHoraInscInteg <- renderText({ fmTip( labTMP ) })
		
        # aba 2-Avaliador
		updateCheckboxInput( inputId='checkSeraAvaliador', value=FALSE )
		updateTextInput( inputId='palavChavAval', value="" )
		
		# aba 1-Membro
		updateCheckboxInput( inputId='checkFuncEvento', value=FALSE )
		updateTextInput( inputId='funcaoEvento', value="" )
		
		# aba 1-Software
		updateCheckboxInput( inputId='checkTemFunSoftware', value=FALSE )
		

	}








