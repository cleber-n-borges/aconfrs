
    #############################################################
    #                                                           #
    #            Server para sessão de "Participante"           #
    #                                                           #
    #############################################################

    connTextParticipUI <- textConnection( varString_uiParticipante )
    # Carrega a interface de "Participante"    
    insertUI(
    
        selector = "#uiRequisitada",
        where = "afterEnd",
        ui = source( connTextParticipUI, local=TRUE )[[1]],
        immediate = TRUE
    
    )
    close( connTextParticipUI ); rm( connTextParticipUI )
    
    # Carrega as 'TIPS' da Interface do "Participante"
    connTextParticipTip <- textConnection( varString_serverParticipanteTips )
    source( connTextParticipTip, local=TRUE )
    close( connTextParticipTip ); rm( connTextParticipTip )
    
    # Carrega as diversas funções do ambiente do "Participante"
    connTextParticipFun <- textConnection( varString_serverParticipFun )
    source( connTextParticipFun, local=TRUE )
    close( connTextParticipFun ); rm( connTextParticipFun )
    
    #######################
    #    Config Iniciais  #
    #######################
    
    # ambiente para guardar as variáveis do Participante
    envParticip <- new.env( parent=globalenv() )
    
    # Indicativo que nada se sabe sobre dados na DB
    envParticip$dados_previos_na_DB <- NULL
    
    # Para checagem do Comprovante de PG
    envParticip$UPLOAD_do_Comprovante_PG_esta_OK <- NULL
    
    # Para checagem do Resumo
    envParticip$UPLOAD_do_Resumo_esta_OK <- NULL
    
    # "mainTableR" para essa Sessão Específica
    envParticip$mainTableR <- mainTableR
    
    # Informa sobre prazos de Novas Inscrições
    output$labPrazoNovasInscricoes <- renderText({ HTML( paste0( '<span class="text-danger"><ul><li><em>', prazos$prazoNovasInscricoes, '</span></em></li></ul>' ) ) })

    # Informa sobre prazos de envios de arquivos
    output$prazoPdfComprovaPG <- renderText({ HTML( paste0( '<span class="text-danger"><ul><li><em>', prazos$prazoPdfComprovaPG, '</span></em></li></ul>' ) ) })
    output$prazoPdfResumo <- renderText({ HTML( paste0( '<span class="text-danger"><ul><li><em>', prazos$prazoPdfResumo, '</span></em></li></ul>' ) ) })

    # Data da Inscrição Preenchida
    output$dataInsc <- renderText({ "Data da Inscrição: Não disponível" })
    
    # Data dos Envios dos Arquivos
    output$dataComprovaPG <- renderText({ "Data do Envio: Não disponível" })
    output$dataResumo <- renderText({ "Data do Envio: Não disponível" })
    
    # Data da Avaliação
    output$dataAvaliacao <- renderText({ "Data da Avaliação: Não disponível" })

    # Cria objetos de validação...
    ivP00 <- InputValidator$new() # para a Entrada
    #ivP00$add_rule( "enterSenhaSys", valNumInsc )
    ivP00$add_rule( "enterSenhaSys", sv_required( message = " " ) )
    ivP00$add_rule( "enterMailLogin", sv_required( message = " " ) )
    ivP00$add_rule( "enterMailLogin", sv_email() )
    ivP00$add_rule( "enterMailReenvio", sv_required( message = " " ) )
    ivP00$add_rule( "enterMailReenvio", sv_email() )
    ivP00$enable()
    
    ivP01 <- InputValidator$new() # para informações básicas
    ivP01$add_rule( "nome", sv_required( message = " " ) )
    ivP01$add_rule( "cpf", cpf_val )    
    ivP01$add_rule( "email", sv_required( message = " " ) )
    ivP01$add_rule( "email", sv_email() )
    ivP01$add_rule( "modalInscricao", sv_required( message = " " ) )
    ivP01$enable() 

    ivP03 <- InputValidator$new() # para quem enviará Resumo
    ivP03$add_rule( "tituloTrab",    sv_required( message = " " ) )
    ivP03$add_rule( "autoresTrab",   sv_required( message = " " ) )
    ivP03$add_rule( "palavChavTrab", sv_required( message = " " ) )
    ivP03$add_rule( "opAreaTrab",    sv_required( message = " " ) )
    ivP03$add_rule( "textoTrab",     sv_required( message = " " ) )
	ivP03$add_rule( "pdfResumoTrab", sv_required( message = " " ) )
	
	ivP04 <- InputValidator$new() # para envio do Comprovante de Pagamento
	ivP04$add_rule( "pdfComprovaPg", sv_required( message = " " ) )

    #############################
    #        Config Paineis     #
    #############################
    
    # Desabilita espaços que são apenas visualizão de informações
    # Usuário não deve editar em nenhum momento
    shinyjs::disable( "numeroInsc" )
    shinyjs::disable( "statusParticipante" )
    
    # inicialmente não há arquivos de comprovante de pagamento
    shinyjs::disable( "selectComprovaPgVers" )
    shinyjs::disable( "downloadPDFComprovaPG" )
    
    # inicialmente não há arquivos dos resumos em pdf
    shinyjs::disable( "selectResumoVers" )
    shinyjs::disable( "downloadPDFResumo" )
    shinyjs::hide( "wpModalParticip" )

    # inicia "sugestoes" desabilitado
    shinyjs::disable( "sugestoes" )
    
    # O botão de Submissão começa desabilitado
    shinyjs::disable( "butSubmis" )
    # BUG conhecido: se o usuário preencher os dados obrigatorios e concordar
    # o botão será habilitado.
    # Se voltar e apagar algum dado obrigatório, o botão ainda ficará habilitado
    # Importância menor pois não irá enviar nada pois há "req" no código do envio... ;-)

    # Mostra o panel de Entrada de Participante
    shinyjs::show("panelEntradaParticip")

    #########################
    #        Fim: Config    #
    #########################

    #############################################################
    #                                                           #
    #        Inicio da Lógica de Funcionamento do Ambiente      #
    #                                                           #
    #############################################################

    # Manuseio de Download de Comprovante de Pagamento
    output$downloadPDFComprovaPG <- funcDownloadPDFComprovaPG()

    # Manuseio de Download de Resumo
    output$downloadPDFResumo <- funcDownloadPDFResumo()

    #############################################################
    #                                                           #
    #            Inicio dos "ObserveEvent"                      #
    #                                                           #
    #############################################################

    # Limpeza do input "Sugestoes"
    observeEvent( input$checkSugestoes, {
    
        res <- input$checkSugestoes 
        if( res ){
        
            shinyjs::enable("sugestoes")
            updateTextAreaInput( inputId="sugestoes", value="" )
        }
        if( !res ) shinyjs::disable("sugestoes")
    })

    # Prepara tela com somente: "Primeira Insc" e "Recup Info"
    observeEvent( input$butPrimInsc, {
    
        # Fim de Prazo para novas Inscrições
        res <- sub("^(.*)(../../....)$", "\\2", prazos$prazoNovasInscricoes )
        
        if( Sys.Date() > as.Date( res, format="%d/%m/%Y")   ){
        
            # Mostra janela de diálogo modal
            showModal( modalDialog(
                tags$h4(
                    tags$p( "Prazo para Novas Inscrições encerrado." ),
                    tags$br(),
                    tags$p( "" ),    
                    ),
                title = "Informação",
                footer = modalButton("Ok")
            ))
        
            req( FALSE )
            
        }

        shinyjs::hide( "panelEntradaParticip" )
        
        shinyjs::show( "panelInfoParticipante" )
        shinyjs::show( "panelInfoAtividades" )
        shinyjs::show( "panelInfoResumo" )
        shinyjs::show( "panelEnvioArquivos" )        
        shinyjs::show( "panelSubmis" )
        shinyjs::show( "panelQuestionario" )
        #shinyjs::show( "panelDesistencia" )
        shinyjs::show( "panelRodapePart" )
        
        #Validator de ComprovaPDF
        #ivP02$enable()
        
        # chama a função "resultAvaliador" para "somente Mostrar" o Questionário ( = será vazio!)
        resultAvaliador()
        
    })

    # Exige Concordancia com os Termos para habilitar a "Submissão"
    observeEvent( input$concordancia, {
  
        req( input$nome, input$cpf, input$email, input$modalInscricao )
        
        res <- input$concordancia
        if( res == TRUE  ) { shinyjs::enable("butSubmis") }
        if( res == FALSE ) { shinyjs::disable("butSubmis") }
        
    })
    
    # ações da Area de Texto    
    observeEvent( input$textoTrab, {
    
        ncharacter <- nchar( input$textoTrab )
        output$labTextoTrab03 <- renderText({ fmTip( paste0( "-> Número de caracteres corrente: ", ncharacter ) ) })
    
    })

    # ações do Botão de UPLOAD do Comprovante de PG
    observeEvent( input$pdfComprovaPg, {
	
		# Fim de Prazo para novas Submissões de Comprovante de PG
        res <- sub("^(.*)(../../....)$", "\\2", prazos$prazoPdfComprovaPG )
        
        if( Sys.Date() > as.Date( res, format="%d/%m/%Y")   ){
        
            # Mostra janela de diálogo modal
            showModal( modalDialog(
                tags$h4(
                    tags$p( "Prazo para Envio do Comprovante de Pagamento encerrado." ),
                    tags$br(),
                    tags$p( "Ação Não Considerada" ),    
                    ),
                title = "Informação",
                footer = modalButton("Ok")
            ))
			
			shinyjs::reset( "checkEnvioCompPG" )
            shinyjs::reset( "pdfComprovaPg" )

        }
	
        # Caso tenha tentativa de UPLOAD do Comprovante, precisa passar na Verificação
        if( !is.null( input$pdfComprovaPg$datapath ) ){
		
            # Verifica se é PDF
            req( !verifTypePDF( input$pdfComprovaPg, id="pdfComprovaPg" ) )
            
            # Verifica o limite de 5MB
            req( !verifSizePDF( input$pdfComprovaPg, id="pdfComprovaPg" ) )
            
            # Se chegar nesse ponto, então passou nos testes acima!
            envParticip$UPLOAD_do_Comprovante_PG_esta_OK <- TRUE

        }
        
        runjs('document.getElementById("panelEnvioArquivos").scrollIntoView();')

    })

    # ações do Botão de UPLOAD do Resumo
    observeEvent( input$pdfResumoTrab, {
	
		# Fim de Prazo para novas Submissões de Resumos
        res <- sub("^(.*)(../../....)$", "\\2", prazos$prazoPdfResumo )

        if( Sys.Date() > as.Date( res, format="%d/%m/%Y")   ){
           
            # Mostra janela de diálogo modal
            showModal( modalDialog(
                tags$h4(
                    tags$p( "Prazo para Participação com Submissão de Resumo encerrado." ),
                    tags$br(),
                    tags$p( "Ação Não Considerada" ),    
                    ),
                title = "Informação",
                footer = modalButton("Ok")
            ))
           
            shinyjs::reset( "modalParticip" )
			shinyjs::reset( "pdfResumoTrab" )

        }
        
        # Caso tenha tentativa de UPLOAD do Resumo, precisa passar na Verificação
        if( !is.null( input$pdfResumoTrab$datapath ) ){
            
            # Verifica se é PDF
            req( !verifTypePDF( input$pdfResumoTrab, id="pdfResumoTrab" ) )
            
            # Verifica o limite de 5MB
            req( !verifSizePDF( input$pdfResumoTrab, id="pdfResumoTrab" ) )
            
            # Verifica se tem somente 01 Página
            req( !verif1PagePDF( input$pdfResumoTrab, id="pdfResumoTrab" ) )

            # Verifica se é formato A4
            req( !verifA4PDF( input$pdfResumoTrab, id="pdfResumoTrab" ) )
            
            # Se chegar nesse ponto, então passou nos testes acima!
            envParticip$UPLOAD_do_Resumo_esta_OK <- TRUE

        }
        
        runjs('document.getElementById("panelEnvio-Resumo").scrollIntoView();')

    })

    # se o Participante não tem Resumo, oculta essas opções
    observeEvent( input$modalParticip, {
	
        res <- ifelse( input$modalParticip, "Com Resumo", "Sem Resumo" )
        
        if( res == "Com Resumo" ){
        
            shinyjs::show("wpModalParticip")
            
			updateCheckboxInput( inputId="checkEnvioResumo", value=TRUE )
			
            if( is.na( envParticip$mainTableR[["versaoResumo"]] ) ){
			
				ivP03$enable()
				
				shinyjs::show("panelEnvio-Resumo")
				
				shinyjs::show("panelEnvioArquivosSub01")
			
			}

        }

        if( res == "Sem Resumo" ){
            
            shinyjs::hide("wpModalParticip")
            
            updateCheckboxInput( inputId="checkEnvioResumo", value=FALSE )
            
			shinyjs::hide( "panelEnvio-Resumo" )
            
            ivP03$disable()

        }

    })

    # ações do checkbox: EnvioComprovaPG
    observeEvent( input$checkEnvioCompPG, {
	
        if( input$checkEnvioCompPG ){
		
			if( is.na( envParticip$mainTableR[["versaoComprovaPG"]] ) ){
			
				ivP04$enable()
				
			}
        
            shinyjs::show("panelEnvio-ComprovaPG")
        
        } else {
		
			shinyjs::hide("panelEnvio-ComprovaPG")

			ivP04$disable()
        
        }

    })
    
    # ações do checkbox: EnvioResumo
    observeEvent( input$checkEnvioResumo, {
    
        if( input$checkEnvioResumo ){
		
			if( is.na( envParticip$mainTableR[["versaoResumo"]] ) ){
			
				ivP03$enable()
				
			}
        
            shinyjs::show("panelEnvio-Resumo")
        
        } else {
        
            shinyjs::hide("panelEnvio-Resumo")
			
			ivP03$disable()
        
        }

    })

    # Procede a "Submissão"
    observeEvent( input$butSubmis, {

		res0 <- ivP01$is_valid()
		res1 <- TRUE
		res2 <- TRUE
		
		if( input$checkEnvioCompPG & is.na( envParticip$mainTableR[["versaoComprovaPG"]] ) ){
		
			res1 <- ivP04$is_valid()
		
		}
		
		if( input$modalParticip & is.na( envParticip$mainTableR[["versaoResumo"]] ) ){
		
			res2 <- ivP03$is_valid()
		
		}
			
		if( res0 & res1 & res2  ){

            funcBotaoSubmissao()        
        
        } else {
        
            inform01 <- 'Item de Preenchimento obrigátorio faltante ou inválido!'
            
            inform02 <- "Por favor, revise e tente a submissão novamente!"
        
            funcModGeralCamposInvalidos( inform01=inform01, inform02=inform02 )
            
        }
    
    })
    
    # Se já tem dados desse usuário na DB
    # e se quer realmente atualizar, então regrava
    observeEvent( input$modButOk, {
    
        funcAtualizacaoDadosGerais()
        
    })
	
	# ação do Botão de Desistência
	observeEvent( input$butDesistencia, {
    
        funcDesistenciaBut()
        
    })
	
	# ação do Botão da Janela Modal de Confirmação da Desistência
	observeEvent( input$modButDesistenciaOk, ignoreInit = TRUE, {
    
		funcDesistenciaModal()
        
    })

    # ação do botão "Recuperar Informações"
    observeEvent( input$butRecupInfo, {
    
        funcBotaoRecuperaInfo()
    
    })

    #############################################################
    #                                                           #
    #    7 Monitores de LINKS de Paineis pelos "ObserveEvent"   #
    #                                                           #
    #############################################################

    # link ocultar painel: Participante
    observeEvent( input$linkHSParticip, {
        shinyjs::toggleElement("panelInfoParticipanteSub01")
    })
    
    # link ocultar painel: Atividades
    observeEvent( input$linkHSAtividades, {
        shinyjs::toggleElement("panelInfoAtividadesSub01")
    })
    
    # link ocultar painel: Resumo
    observeEvent( input$linkHSResumo, {
        shinyjs::toggleElement("paneInfoResumoSub01")
    })
    
    # link ocultar painel: Envio de Arquivos
    observeEvent( input$linkHSEnvioArquivos, {
        shinyjs::toggleElement("panelEnvioArquivosSub01")
    })

    # link ocultar painel: Submissão
    observeEvent( input$linkHSSubimissao, {
        shinyjs::toggleElement("panelSubmisSub01")
    })
  
    # link ocultar painel: Acompanhamento
    observeEvent( input$linkHSQuestionario, {
        shinyjs::toggleElement("panelQuestionarioSub01")
    })
    
    # link ocultar painel: Itens Objetivos (Questionário)
    observeEvent( input$linkHSItensObj, {
        shinyjs::toggleElement( "panelRespItensObj" )
    })
    
    # link ocultar painel: Itens Dissertativos (Questionário)
    observeEvent( input$linkHSItensDis, {
        shinyjs::toggleElement( "panelRespItensDis" )
    })
    
    # link ocultar painel: Resultado (Questionário)
    observeEvent( input$linkHSResultAval, {
        shinyjs::toggleElement( "panelResultAval" )
    })
    
    # link ocultar painel: Desistencia
    observeEvent( input$linkHSDesistencia, {
        shinyjs::toggleElement( "panelDesistenciaSub01" )
    })


