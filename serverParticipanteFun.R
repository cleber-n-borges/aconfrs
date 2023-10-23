
    #############################################################
    #                                                           #
    #                 Declaração de diversas Funções            #
    #                                                           #
    #############################################################

    #############################################################
    #                                                           #
    #        Declaração da Função de Validação de CPF           #
    #                                                           #
    #############################################################

    cpf_val <- function( x ) {
    
        if( length( x ) == 0 ) return( "CPF Inválido" )

        if( x=='' ) return( "CPF Inválido" )
        
        res <- all( strsplit( as.character( x ), "" )[[1]][c(4,8,12)]==c('.','.','-'))
        if( is.na(res) | !res ) return( "CPF Inválido" )
        
        res <- is.valid( CPF( as.character( x ) ) )
        if( res ){
            return( NULL )
        } else {
            return( "CPF Inválido" )
        }
    
    }
    
    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "valNumInsc"              #
    #                                                           #
    #############################################################
    
    valNumInsc <- function( num ){
    
        res1 <- grep( "^[[:digit:]]{11}$", num )
        
        d <- as.Date( num, "%y%j%H%M%S" )
        
        dini <- as.Date( dataIniInsc )
        dfim <- as.Date( dataFimInsc )
        
        res2 <- dini < d & d < dfim
        
        res <- res1 & res2
        
        if( isTRUE( res ) ){
            return( NULL )
        } else {
            return( "Necessário Número de Inscrição válido" )
        }

    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcBotaoRecuperaInfo"       #
    #                                                           #
    #############################################################

    funcBotaoRecuperaInfo <- function(){
        
        req( input$enterSenhaSys )
    
        mainTableR <- get( "mainTableR", envir=envParticip )
    
        enterSenhaSys <- as.character( trimws( input$enterSenhaSys ) )
        
        # Quando usuario fizer login, comparar a senha fornecida na interface com a senha da DB
        sql <- "SELECT senha,email FROM mainTable WHERE senha = ?"
        res <- dbGetQuery( conDB, sql, params=list( enterSenhaSys ) )

        if( nrow( res ) == 1 & isTRUE( res$email == trimws( input$enterMailLogin ) ) ){
        
            # Indica cadastro na base de dados
            assign( "dados_previos_na_DB", TRUE, env=envParticip )
            
            # inicia atualizações na interface
            
            shinyjs::hide( "panelEntradaParticip" )
            shinyjs::hide( "panelPrimeiraInsc" )
            shinyjs::hide( "panelRecupInfo" )
            shinyjs::hide( "panelRodapeEntrada" )
            
            shinyjs::show( "panelStatusParticipante" )
            
            shinyjs::show( "panelInfoParticipante" )
            shinyjs::show( "panelInfoAtividades" )
            shinyjs::show( "panelInfoResumo" )
            shinyjs::show( "panelEnvioArquivos" )
            shinyjs::show( "panelSubmis" )
            shinyjs::show( "panelQuestionario" )
            shinyjs::show( "panelDesistencia" )
            shinyjs::show( "panelRodapePart" )
            
            user_login <- TRUE
            
        } else {

            user_login <- FALSE

        }

        if( user_login ){
    
            # Inicia aqui procedimento de recuperação dos Dados na Base
            sql <- "SELECT * FROM mainTable WHERE senha = ?"
            res <- dbGetQuery( conDB, sql, params=list( enterSenhaSys ) )
            
            # Guarda os dados no "enviroment" dessa sessão
            assign( "mainTableR", res, env=envParticip )
            
            # atualiza numero da inscriçao
            updateTextInput( inputId="numeroInsc", value=res$numeroInsc )
            
            # Atualiza a Data da Inscrição na Interface
            output$dataInsc <- renderText({ paste0("Data e hora da Última Submissão: ", res$dataInsc ) })
            
            # Atualiza mark
            tmp <- strsplit( res$mark, ' ' )[[1]][-1]
            output$mark <- renderText({ HTML( tmp )  })
    
            # atualiza vários dados
            updateTextInput( inputId="nome", value=res$nome )
            updateTextInput( inputId="cpf", value=res$cpf )
            updateTextInput( inputId="email", value=res$email )
            updateTextInput( inputId="modalInscricao", value=res$modalInscric )            
            updateTextInput( inputId="cracha", value=res$cracha )        
            updateTextInput( inputId="instituicao", value=res$afiliaInstit )
            updateSelectInput( inputId="palestras", selected=strsplit( res$palestras,  ',' )[[1]] )
            updateSelectInput( inputId="minicursos", selected=strsplit( res$minicursos, ',' )[[1]] )
            updateSelectInput( inputId="treinamentos", selected=strsplit( res$treinamentos, ',' )[[1]] )

            if( !is.na( res$versaoComprovaPG ) ){
            
                shinyjs::enable( "selectComprovaPgVers" )
                shinyjs::enable( "downloadPDFComprovaPG" )
            
                # Atualiza a data de envio na Interface
                output$dataComprovaPG <- renderText({ paste0("Data do Envio do Resumo: ", res$dataComprovaPG ) })

                escolhasPDFCompPG <- paste0( "versão ", 1:( as.integer( res$versaoComprovaPG ) ) )    
                updateSelectInput( inputId="selectComprovaPgVers", choices=escolhasPDFCompPG )
            
            }
            
            #####################################################################

            # Chama a função "funAtualizaMsgCompPG", que dá providências do
            # status da Inscrição -> Dependente do ***Comprovante de Pagamento***
            funAtualizaMsgSituacaoCompPG( res )
            
            #####################################################################    
            
            # converte modalidade: "Com/Sem" em "TRUE/FALSE"
            modalPart <- ifelse( res$modalParticip == "Com Resumo", TRUE, FALSE )
            
            # atualiza a modalidade do Participante
            updateCheckboxInput( inputId="modalParticip", value=modalPart )
        
            if( res$modalParticip == "Com Resumo" ){
        
                # exibe o sub painel sobre informações do Resumo
                shinyjs::show( "panelInfoResumoSub01" )
                
                # exibe o painel sobre o status da avaliação para acopanhamento
                shinyjs::show( "panelStatusResumo" )
                # mostra info status do Resumo
                updateTextInput( inputId="statusResumo", value="Aguardando..." )
                shinyjs::disable( "statusResumo" )
                
                # habilita visualização de versão de arquivo de resumo
                
                if( !is.na( res$versaoResumo ) ){
                
                    shinyjs::enable( "selectResumoVers" )
                    shinyjs::enable( "downloadPDFResumo" )
                
                    # Atualiza a data de envio na Interface
                    output$dataResumo <- renderText({ paste0("Data do Envio do Resumo: ", res$dataResumo ) })

                    escolhasPDFResumo <- paste0( "versão ", 1:( as.integer( res$versaoResumo ) ) )    
                    updateSelectInput( inputId="selectResumoVers", choices=escolhasPDFResumo )
                
                }
            
                updateTextInput( inputId="tituloTrab", value=res$tituloTrab )
                updateTextInput( inputId="autoresTrab", value=res$autoresTrab )
                updateTextInput( inputId="palavChavTrab", value=res$palavChavTrab )
                updateRadioButtons( inputId="opAreaTrab", selected=res$subAreaTrab )
                updateTextAreaInput( inputId="textoTrab", value=res$textoTrab )
                updateTextInput( inputId="institAutTrab", value=res$institAutTrab )        
                updateTextInput( inputId="orgFomTrab", value=res$orgFomTrab )
                updateTextInput( inputId="patrocTrab", value=res$patrocTrab )
        
                # Quadro tb consta no Arquivo: serverAvaliadorFun.R linha 194
                ###############################################################################
                
                # 4 Diferentes Situações No processo Avaliativo:
            
                # ----- Condição --------------------- Ação --------------
            
                # (1) Resumo Enviado            Esperando Avaliação       ---- escrever na DB: "Esperando Avaliação"
                # (2) Resumo Aprovado            Nenhuma ação necessária   ---- escrever na DB: "Resumo Aprovado"
                # (3) Resumo Reprovado            Nenhuma ação necessária   ---- escrever na DB: "Resumo Reprovado"
                # (4) Correções Necessárias        Aguardando Correções      ---- escrever na DB: "Esperando Correções"
                
                ###############################################################################

                # Chama a função "funAtualizaMsgSituacaoResumo", que dá providências do
                # status da Avaliação do Resumo
                funAtualizaMsgSituacaoResumo( res )
                
                #####################################################################
        
            }

            # Se foi feito sugestões... atualiza a tela com o dado
            if( !is.na( res$sugestoes ) ) updateTextAreaInput( inputId="sugestoes", value=res$sugestoes )
    
            # Informa ao usuário do Sucesso da ação
            showModal( modalDialog(
                tags$h4(
                    tags$p("Recuperação das Informações realizada com Sucesso!")
                    ),
                title = "Recuperação de Informações",
                footer = modalButton("Ok")
            ))
            
            
            # chama a função "resultAvaliador" para preenchimento do Questionário
            # Mesmo para quem não enviará RESUMO
            # Motivação: dar amplo conhecimento público do processo avaliativo
			resultAvaliador()
        
        }
    
        if( !user_login ){
    
            # Informa ao usuário da Operação Fracassada
            showModal( modalDialog(
                tags$h4(
                    tags$p("Os dados fornecidos não foram encontrados na base de dados!"),
                    tags$p()
                ),
                title = "Recuperação de Informações",
                footer = modalButton("Ok")
            ))

        }

    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "funcBotaoSubmissao"      #
    #                                                           #
    #############################################################
    
    funcBotaoSubmissao <- function(){
    
        # desabilita o botão de submissão
        shinyjs::disable("butSubmis")
        
        # Verifica exigências para submissão
        #funcExigenciasEnvio()                  ###  <- desabilitado para teste... está funcionando perfeitamente
        
        # cria uma cópia local por simplicidade
        mainTableR <- envParticip$mainTableR
       
		# atualiza mark
        mainTableR$mark[1] <- paste0( mainTableR$mark[[1]], ' &#10004;' )
        
        # Verifica se não há trava de edição (para casos de atualizações)
        if( is.na( mainTableR$travaEdicao ) ) mainTableR$travaEdicao <- "FALSE"
		
        if( as.logical( mainTableR$travaEdicao ) ){
        
            funcTravaEdicao()
            
            req( FALSE )
        
        }
        
        # Se TRUE: é nova inscrição
        if( is.na( mainTableR[["numeroInsc"]] ) ){

            numeroInsc <- InscNumberGenerator()
	        mainTableR$senha[1] <- password()

            
        # Se FALSE: é atualização
        } else {
            
            numeroInsc <- mainTableR$numeroInsc[1]
            
        }

        # Informações Gerais:
        mainTableR$numeroInsc[1] <- numeroInsc
        mainTableR$dataInsc[1]   <- format(Sys.time(), "%d/%m/%Y %H:%Mh")
        
        # Informações sobre o Participante:
        mainTableR$nome[1]         <- input$nome
        mainTableR$cpf[1]          <- input$cpf
        mainTableR$email[1]        <- trimws( input$email )
        mainTableR$modalInscric[1] <- input$modalInscricao
        mainTableR$cracha[1]       <- input$cracha        
        mainTableR$afiliaInstit[1] <- input$instituicao

        # Informações sobre Atividades:
        mainTableR$palestras[1]    <- paste( input$palestras, collapse=',')
        mainTableR$minicursos[1]   <- paste( input$minicursos, collapse=',')
        mainTableR$treinamentos[1] <- paste( input$treinamentos, collapse=',')
        
        # Informações sobre o Resumo:        
        mainTableR$modalParticip[1] <- ifelse( input$modalParticip, "Com Resumo", "Sem Resumo" )
        
        if( input$modalParticip == TRUE ){# "Com Resumo"

            mainTableR$tituloTrab[1]    <- input$tituloTrab    
            mainTableR$autoresTrab[1]   <- input$autoresTrab    
            mainTableR$palavChavTrab[1] <- input$palavChavTrab
            mainTableR$subAreaTrab[1]   <- input$opAreaTrab    
            mainTableR$textoTrab[1]     <- input$textoTrab
            mainTableR$institAutTrab[1] <- input$institAutTrab
            mainTableR$orgFomTrab[1]    <- input$orgFomTrab    
            mainTableR$patrocTrab[1]    <- input$patrocTrab    

        }
        
        # Envio de Arquivos: 
        # Feito efetivamente por: "funcGravaComprovaPG" e "funcGravaResumo"
        
        # Submissão:
        # checa se há Sugestoes
        if( input$checkSugestoes ) mainTableR$sugestoes[1] <- input$sugestoes

        # Resultado da Avaliação:
        # será escrita na DB pelo avaliador
        #         "dataAvaliacao"        
        #         "respObjetiv"        
        #         "respDissert"        
        #         "opResultAvalResumo"     
        #         "opRequisicaoAvalResumo"

        # Variaveis de Uso Geral:
        # mainTableR$travaEdicao[1] <- "FALSE"
        
        # guarda a tabela na vairável ambiente da Sessão corrente
        envParticip$mainTableR <- mainTableR
        
        # habilita o botão de submissão
        shinyjs::enable("butSubmis")
        
        # Chama função que efetivamente grava os Dados Gerais na DB
        resGravacaoG <- funcGravaDadosGeraisDB()
        
        # até aqui: Não houve nenhuma informação sobre envios de Arquivos
        # será executado somente na primeira vez submissão
        if( resGravacaoG & is.na( mainTableR$versaoComprovaPG ) ){
        
            # atualiza a Interface sobre Comprovante de Inscrição
            msg <- "A Inscrição estará Pendente até: 1) Envio e 2) Conferência de Comprovante de Pagamento."
            updateTextInput( inputId="statusInsc", value=msg )
            shinyjs::disable( "statusInsc" )
            addClass( "panelStatusInsc", class='bg-warning' )
            shinyjs::show( "panelStatusInsc" )

        }
        
        if( resGravacaoG & mainTableR$modalParticip == "Com Resumo" & is.na( mainTableR$versaoResumo ) ){
        
            # atualiza a Interface sobre Resumo
            msg <- "Pendência: O Envio de Arquivo PDF do Resumo é Obrigatório (Conforme Modelo)."
            updateTextInput( inputId="statusResumo", value = msg )
            shinyjs::disable( "statusResumo" )
            addClass( "panelStatusResumo", class='bg-warning' )
            shinyjs::show( "panelStatusResumo" )

        }
        
        # Chama função que efetivamente grava o Arquivo PDF do Comprovante de PG se:
        # UPLOAD_do_Comprovante_PG_esta_OK

        # Envio de Arquivos: Comprova_PG
        if( isTRUE( envParticip$UPLOAD_do_Comprovante_PG_esta_OK ) ){
    
            # Colocar pdf na DB
            resPG <- funcGravaComprovaPG()
        
        }

        # Chama função que efetivamente grava o o Arquivo PDF do Resumo se:
        # UPLOAD_do_Resumo_esta_OK
        
        # Envio de Arquivos: Resumo
        if( isTRUE( envParticip$UPLOAD_do_Resumo_esta_OK ) ){
        
            # Colocar pdf na DB
            resRes <- funcGravaResumo()
        
        }
        
        # A partir de agora terá DADOS desse usuário na DB
        if( resGravacaoG ) envParticip$dados_previos_na_DB <- TRUE
        
        # atualiza concordancia
        updateCheckboxInput( inputId="concordancia", value=FALSE )

        # Fecha panels
        shinyjs::hide( "panelInfoParticipanteSub01" )
        shinyjs::hide( "panelInfoAtividadesSub01" )
        shinyjs::hide( "paneInfoResumoSub01" )
        shinyjs::hide( "panelEnvioArquivosSub01" )
        shinyjs::hide( "panelSubmisSub01" )
        shinyjs::hide( "panelQuestionarioSub01" )
        
        # Mostra que a partir de agora, há opção de desistência do evento
        shinyjs::show( "panelDesistencia" )

        # rola página de volta ao começo
        shinyjs::runjs("window.scrollTo(0, 0)")
        
        # Atualiza mark
        res <- strsplit( mainTableR$mark, ' ' )[[1]][-1]
        output$mark <- renderText({ HTML( res )  })
        
        # Limpa memória
        r <- gc()

    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcGravaDadosGeraisDB"      #
    #                                                           #
    #############################################################

    funcGravaDadosGeraisDB <- function(){

        # Se NÃO TEM DADOS PRÉVIOS desse usuário na DB, então procede "primeira gravação"
        # É PRIMEIRO Envio de Dados
        if( is.null( envParticip$dados_previos_na_DB ) ){
        
            # cria uma cópia local (dentro do observe) por simplicidade
            mainTableR <- envParticip$mainTableR

            # Grava os Dados Gerais na DB
            dbWriteTable( conDB, "mainTable", mainTableR, append = TRUE )
            
            # Atualiza o Numero da Inscrição na Interface
            updateTextInput( inputId="numeroInsc", value=mainTableR$numeroInsc[1] )
        
            # Atualiza a Data da Inscrição na Interface
            output$dataInsc <- renderText({ paste0("Data e hora da Última Submissão: ", mainTableR$dataInsc[1] ) })
            
            # Mostra janela de diálogo modal
            showModal( modalDialog(
                tags$h4(
                    tags$p("Informações Enviadas com Sucesso!")
                    ),
                title = "Envio",
                footer = modalButton("Ok")
            ))
            
            shinyjs::show( "panelStatusParticipante" )
            
            runjs('document.getElementById("panelStatusParticipante").scrollIntoView();')
            
            return( TRUE )

        }
        
        # Se TEM DADOS PRÉVIOS desse usuário na DB, então procede "atualização"
        # É ATUALIZAÇÃO dos Dados
        if( isTRUE( envParticip$dados_previos_na_DB ) ){
        
            #showModal( funcModAtualizacao() )
            funcAtualizacaoDadosGerais()
            ########################################## :-( bypass no dialogo modal de confirmação

            # Nesse ponto, por conveniência, será requisitado
            # confirmação do usuário por uma janela modal
            
            # a implementação requer um 'observeEvent'
            
            # a continuidade do procedimento passa a ser na
            # função: "funcAtualizacaoDadosGerais"
            
            return( TRUE )
        
        }

    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcGravaComprovaPG"         #
    #                                                           #
    #############################################################
    
    funcGravaComprovaPG <- function(){
    
        # Envio de Arquivos
        # "versaoComprovaPG"         
        # "versaoSolicitCompPG"     
        # "dataComprovaPG"        
        # "situacaoAvalCompPG"
        
        # Reset a checagem
        envParticip$UPLOAD_do_Comprovante_PG_esta_OK <- NULL
        
        # cria uma cópia local por simplicidade
        mainTableR <- envParticip$mainTableR

        # busca na DB a versao do Comprovante de PG
        sql <- "SELECT versaoComprovaPG FROM mainTable WHERE numeroInsc = ?"
        res <- dbGetQuery( conDB, sql, params=list( as.character( mainTableR$numeroInsc[1] ) ) )[[1]]

        # Se não há dados prévios na DB, inicializa as variáveis
        # sobre "Versões" de Comprovante de PG
        if( is.na( res ) ){
        
            mainTableR$versaoComprovaPG[1] <- "1"
            mainTableR$versaoSolicitCompPG[1] <- "1"

            # Inicializa "versaoSolicitCompPG" na DB
            sql <- "UPDATE mainTable SET versaoSolicitCompPG = ?  WHERE numeroInsc = ? "
            dbExecute( conDB, sql, params=list( "1", as.character( mainTableR$numeroInsc[1] ) ) )
        
        }

        # Guardar Arquivo considerando possibilidade de diferentes versões
        if( as.integer( mainTableR$versaoSolicitCompPG ) > as.integer( mainTableR$versaoComprovaPG ) ) {
            versao <- as.integer( mainTableR$versaoComprovaPG ) + 1
            mainTableR$versaoComprovaPG[1] <- as.character( versao )
        } else {
            versao <- as.integer( mainTableR$versaoComprovaPG )
        }
        
        # Gera o nome do Arquivo do Comprovante de PG
        nomeArq <- paste0( mainTableR$numeroInsc[1], "-vers-", versao, "-PG" )
        
        # Grava a versao do Arquivo como Blob na DB
        resGravaPG <- funcUploadPDF( input$pdfComprovaPg$datapath, "comprovaPgTable", nomeArq )

        if( resGravaPG ){

            shinyjs::reset("pdfComprovaPg")
    
            # Recalcula versoes e atualiza interface        
            versoesArq <- paste0( "versão ", 1:versao )            
            updateSelectInput( inputId="selectComprovaPgVers", choices=versoesArq )
            
            # Habilita a interface de visualização dos Arquivos
            shinyjs::enable( "selectComprovaPgVers" )
            shinyjs::enable( "downloadPDFComprovaPG" )
            
            # Data de envio do ComprovaPG
            mainTableR$dataComprovaPG <- format(Sys.time(), "%d/%m/%Y %H:%Mh")
            
            # Atualiza a data de envio na Interface
            output$dataComprovaPG <- renderText({ paste0("Data do Envio do Comprovante: ", mainTableR$dataComprovaPG ) })
            

            # Quadro - Financeiro
            ###############################################################################
            
            # 4 Diferentes Situações No processo de conferir Comprova PG:
        
            # ----- Condição -----------------------
        
            # (1) CompPG Não Enviado            
            # (2) CompPG Enviado                
            # (3) CompPG Foi Conferido e Aceito    
            # (4) CompPG Foi Conferido e Não Aceito
            
            ###############################################################################

            # Indicativo de envio do Comprova PG: ---> Seguir o Esquema acima!!!

            # Indicativo de envio do ComprovaPG
            mainTableR$situacaoAvalCompPG <- "Comprovante de PG Enviado"
            
            
            ###############################################################################
            
            
            # Grava na DB, info sobre comprovaPG
            var1 <- as.character( versao )
            var2 <- as.character( mainTableR$dataComprovaPG[1] )
            var3 <- as.character( mainTableR$situacaoAvalCompPG[1] )
            var4 <- as.character( mainTableR$numeroInsc[1] )
            sql <- "UPDATE  mainTable SET versaoComprovaPG = ?, dataComprovaPG = ?, situacaoAvalCompPG = ? WHERE numeroInsc = ?"
            dbExecute( conDB, sql, params=list( var1, var2, var3, var4 ) )
            
            # atualiza mainTableR
            envParticip$mainTableR <- mainTableR
            
            if( is.na( res ) | mainTableR$versaoComprovaPG[1] == mainTableR$versaoSolicitCompPG[1] ){
            
                #print( 'Foi a primeira vez que houve envio do ComprovaPG' )
                msg <- "A Inscrição estará Pendente até a Conferência do Comprovante de Pagamento. Aguarde!"
                
            } else {
            
                #print( 'Houve atualização do ComprovaPG!' )
                msg <- "Atualização de Comprovante. Haverá Nova Conferência do Comprovante de Pagamento. Aguarde!"
                
            }
            
            # Atualizações na Interface
            
            # Status da Inscrição
            updateTextInput( inputId="statusInsc", value=msg )
            addClass( "panelStatusInsc", class='bg-warning' )
            shinyjs::disable( "statusInsc" )

            # Mostra panel de Situação da Inscrição
            shinyjs::show( "panelStatusInsc" )

            return( TRUE )
        
        }

    }

    #############################################################
    #                                                           #
    #    Declaração da FUNÇÃO "funAtualizaMsgSituacaoCompPG"    #
    #                                                           #
    #############################################################

    funAtualizaMsgSituacaoCompPG <- function( mainTableR ){

        # Nem teve envio, (por consequência) nem deve ter tido conferência
        res <- is.na( mainTableR$versaoComprovaPG ) & is.na( mainTableR$situacaoAvalCompPG )
        
        if( res ){
        
            msg <- "A Inscrição estará Pendente até: 1) Envio e 2) Conferência de Comprovante de Pagamento."
            addClass( id='panelStatusInsc', class="bg-warning" )

        } else {
        
            # Teve envio... 

            msg <- "A Inscrição estará Pendente até a Conferência de Comprovante de Pagamento. Aguarde!"
            addClass( id='panelStatusInsc', class="bg-warning" )

        }
        
        #Teve envio... E a conferência???
        if( !res & !is.na( mainTableR$versaoComprovaPG ) ){
        
            # Teve envio e teve avaliação POSITIVA
            if( mainTableR$situacaoAvalCompPG == "Inscrição Confirmada" ){
            
                msg <- "Inscrição Confirmada"
                addClass( id='panelStatusInsc', class="bg-success" )
    
            }
            
            # Teve envio mas teve avaliação NEGATIVA
            if( mainTableR$situacaoAvalCompPG == "Comprovante Rejeitado" ){
            
                msg <- "Inscrição Pendente: Comprovante atual Rejeitado. Necessário Novo Envio de Comprovante de Pagamento"
                addClass( id='panelStatusInsc', class="bg-danger" )
    
            }
        
        }
        
        updateTextInput( inputId="statusInsc", value = msg )
        shinyjs::disable( "statusInsc" )
        shinyjs::show( "panelStatusInsc" )
        
    }

    #############################################################
    #                                                           #
    #    Declaração da FUNÇÃO "funAtualizaMsgSituacaoResumo"    #
    #                                                           #
    #############################################################

    funAtualizaMsgSituacaoResumo <- function( mainTableR ){

        # Não teve envio
        res <- is.na( mainTableR$versaoResumo )
		situacao <- is.na( mainTableR$situacaoAvalResumo )

        if( res ){
        
            msg <- "Pendência: O Envio de Arquivo PDF do Resumo é Obrigatório (Conforme Modelo)."
            removeCssClass( id='panelStatusResumo', class="bg-success" )
			removeCssClass( id='panelStatusResumo', class="bg-danger" )
			addClass( id='panelStatusResumo', class="bg-warning" )

        } 
		
		# Teve envio... 
		if( situacao ){
        
            msg <- "Esperando Resultados da Avaliação. Aguarde!"
			removeCssClass( id='panelStatusResumo', class="bg-success" )
			removeCssClass( id='panelStatusResumo', class="bg-danger" )
            addClass( id='panelStatusResumo', class="bg-warning" )

        }
        
        situacao <- mainTableR$situacaoAvalResumo
    
        if( isTRUE( situacao == "Resumo Aprovado" ) ){

            # atualização do status da avaliação
            msg <- "Resumo Aprovado."
			removeCssClass( id='panelStatusResumo', class="bg-warning" )
			removeCssClass( id='panelStatusResumo', class="bg-danger" )
            addClass( id='panelStatusResumo', class="bg-success" )
            
        }
        
        if( isTRUE( situacao == "Esperando Correções" ) ){
        
            msg <- "Providenciar correções requisitadas e resubmeter nova versão!"
			removeCssClass( id='panelStatusResumo', class="bg-danger" )
			removeCssClass( id='panelStatusResumo', class="bg-success" )
            addClass( id='panelStatusResumo', class="bg-warning" )

        }
        
        if( isTRUE( situacao == "Esperando Avaliação" ) ){
    
            msg <- "Esperando Resultados da Avaliação. Aguarde!"
			removeCssClass( id='panelStatusResumo', class="bg-danger" )
			removeCssClass( id='panelStatusResumo', class="bg-success" )
            addClass( id='panelStatusResumo', class="bg-warning" )
        
        }
        
        if( isTRUE( situacao == "Resumo Reprovado" ) ){
    
            msg <- "Resumo Reprovado"
			removeCssClass( id='panelStatusResumo', class="bg-warning" )
			removeCssClass( id='panelStatusResumo', class="bg-success" )
            addClass( id='panelStatusResumo', class="bg-danger" )
        
        }

        updateTextInput( inputId="statusResumo", value = msg )
        shinyjs::disable( "statusResumo" )
        shinyjs::show( "panelStatusResumo" )

    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcGravaResumo"             #
    #                                                           #
    #############################################################
    
    funcGravaResumo <- function(){

        # Envio de Arquivos
        # "versaoResumo"            
        # "versaoSolicitResumo"    
        # "dataResumo"            
        # "situacaoAvalResumo"
        
        # Reset a checagem
        envParticip$UPLOAD_do_Resumo_esta_OK <- NULL
        
        # cria uma cópia local por simplicidade
        mainTableR <- envParticip$mainTableR
        
        # busca na DB a versao do resumo
        sql <- "SELECT versaoResumo FROM mainTable WHERE numeroInsc = ?"
        res <- dbGetQuery( conDB, sql, params=list( as.character( mainTableR$numeroInsc[1] ) ) )[[1]]

		# Se não há dados prévios na DB, inicializa as variáveis
        # sobre "Versões" de Resumos
        if( is.na( res ) ){
        
            mainTableR$versaoResumo[1] <- "1"
            mainTableR$versaoSolicitResumo[1] <- "1"
            
            # Inicializa "versaoSolicitResumo" na DB
            sql <- "UPDATE mainTable SET versaoSolicitResumo = ?  WHERE numeroInsc = ? "
            dbExecute( conDB, sql, params=list( "1", as.character( mainTableR$numeroInsc[1] ) ) )

        }

        # Guardar Arquivo considerando possibilidade de diferentes versões
        if( as.integer( mainTableR$versaoSolicitResumo ) > as.integer( mainTableR$versaoResumo ) ) {
            versao <- as.integer( mainTableR$versaoResumo ) + 1
            mainTableR$versaoResumo[1] <- as.character( versao )
        } else {
            versao <- as.integer( mainTableR$versaoResumo )
        }
    
        # Gera o nome do Arquivo do Resumo
        nomeArq <- paste0( mainTableR$numeroInsc[1], "-vers-", versao )
        
        # Grava a versao do Arquivo como Blob na DB
        resGravaRes <- funcUploadPDF( input$pdfResumoTrab$datapath, "resumoTable", nomeArq )
        
        if( resGravaRes ){
        
            shinyjs::reset("pdfResumoTrab")

            # Recalcula versoes e atualiza interface
            versoesArq <- paste0( "versão ", 1:versao )            
            updateSelectInput( inputId="selectResumoVers", choices=versoesArq )
            
            # Habilita a interface de visualização dos Arquivos
            shinyjs::enable( "selectResumoVers" )
            shinyjs::enable( "downloadPDFResumo" )
            
            # Data de envio do Resumo
            mainTableR$dataResumo <- format(Sys.time(), "%d/%m/%Y %H:%Mh")

            # Atualiza a data de envio na Interface
            output$dataResumo <- renderText({ paste0("Data do Envio do Resumo: ", mainTableR$dataResumo ) })


            # Quadro tb consta no Arquivo: serverAvaliadorFun.R linha 194
            ###############################################################################
            
            # 4 Diferentes Situações No processo Avaliativo:
        
            # ----- Condição --------------------- Ação --------------
        
            # (1) Resumo Enviado            Esperando Avaliação       ---- escrever na DB: "Esperando Avaliação"
            # (2) Resumo Aprovado            Nenhuma ação necessária   ---- escrever na DB: "Resumo Aprovado"
            # (3) Resumo Reprovado            Nenhuma ação necessária   ---- escrever na DB: "Resumo Reprovado"
            # (4) Correções Necessárias        Aguardando Correções      ---- escrever na DB: "Esperando Correções"
            
            ###############################################################################

            # Indicativo de envio do Resumo: ---> Seguir o Esquema acima!!!

            mainTableR$situacaoAvalResumo <- "Esperando Avaliação"
            
            
            ###############################################################################
            

            # Grava na DB, info sobre Resumo
            var1 <- as.character( versao )
            var2 <- as.character( mainTableR$dataResumo[1] )
            var3 <- as.character( mainTableR$situacaoAvalResumo[1] )
            var4 <- as.character( mainTableR$numeroInsc[1] )
            sql <- "UPDATE  mainTable SET versaoResumo = ?, dataResumo = ?, situacaoAvalResumo = ? WHERE numeroInsc = ?"
            dbExecute( conDB, sql, params=list( var1, var2, var3, var4 ) )
    
            # atualiza mainTableR
            envParticip$mainTableR <- mainTableR
            
            if( is.na( res ) | mainTableR$versaoResumo[1] == mainTableR$versaoSolicitResumo[1]  ){
            
                #print( 'Foi a primeira vez que houve envio do Resumo' )
                msg <- "Esperando Resultados da Avaliação. Aguarde!"

                
            } else {
            
                #print( 'Houve atualização do Resumo!' )
                msg <- "Resumo foi Atualizado. Aguarde por Novos Resultados da Reavaliação!"
                
            }
            
            # Atualizações na Interface
            
            # Status do Resumo
            updateTextInput( inputId="statusResumo", value=msg )
            addClass( "panelStatusResumo", class='bg-warning' )
            shinyjs::disable( "statusResumo" )
            
            # Mostra panel de Situação do Resumo
            shinyjs::show( "panelStatusResumo" )

            return( TRUE )
    
        }

    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "funcModAtualizacao"      #
    #                                                           #
    #############################################################

    funcModAtualizacao <- function(){
        modalDialog(
            tags$h4(
                tags$p('Confirma a Atualização dos Dados com a nova submissão?')
            ),
            title = "Recuperação de Informações",
            footer=tagList(
                actionButton( "modButOk", "Ok" ),
                modalButton( "Cancel" )
            )
        )
    }

    #############################################################
    #                                                           #
    #    Declaração da FUNÇÃO "funcAtualizacaoDadosGerais"      #
    #                                                           #
    #############################################################
    
    funcAtualizacaoDadosGerais <- function(){
    
        # cria cópia local dos dados
        mainTableR <- envParticip$mainTableR

        # query de deleção dos dados
        sql <- "DELETE FROM mainTable WHERE numeroInsc = ?"
        
        pool::poolWithTransaction( conDB, function(conn) {
            dbExecute( conn, sql, params=list( mainTableR$numeroInsc ) )
            dbWriteTable( conn, "mainTable", mainTableR, append = TRUE )
            }
        )
        
        # Atualiza o Numero da Inscrição na Interface
        updateTextInput( inputId="numeroInsc", value=mainTableR$numeroInsc[1] )
        
        # Atualiza a Data da Inscrição na Interface
        output$dataInsc <- renderText({ paste0("Data e hora da Última Submissão: ", mainTableR$dataInsc[1] ) })

        showModal( modalDialog(
            tags$h4(
                tags$p("Informações Atualizadas com Sucesso!")
                ),
            title = "Envio",
            footer = modalButton("Ok")
        ))
        
        # Busca result mais atuais
        if( input$modalParticip == TRUE ) resultAvaliador()
        
        shinyjs::show( "panelStatusParticipante" )
        
        runjs('document.getElementById("panelStatusParticipante").scrollIntoView();')

    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcExigenciasEnvio"         #
    #                                                           #
    #############################################################
    
    funcExigenciasEnvio <- function(){
    
        #########################################################
        #                                                       #
        #            Exigências mínimas para submissão          #
        #                                                       #
        #########################################################
    
        # Obrigatório de todas as formas
        req( input$nome, input$cpf, input$email, input$modalInscricao )
    
        
        # Obrigatório de todas as formas para os que tem RESUMO
        if( input$modalParticip == TRUE ){# "Com Resumo"
        
            req( 
                input$tituloTrab, input$autoresTrab,
                input$palavChavTrab, input$opAreaTrab,
                input$textoTrab
                )

        }
        
        # Verifica a quantidade de caracteres das entradas
        req( !verifNChar() )
    
    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "funcTravaEdicao"         #
    #                                                           #
    #############################################################

    funcTravaEdicao <- function(){
    
        showModal( modalDialog(
            tags$h4(
                tags$p( "Sua Inscrição está Temporariamente Travada para Edições" ),
                tags$p( "O Avaliador já iniciou o processo de avaliação" ),
                tags$p( "Aguarde a finalização e volte em breve..." ),    
                tags$br(),
                tags$p( "O Travamento é apenas por breve momento!" ),
                tags$p( "Nenhuma modificação será efetuada agora!" )
                
            ),
            title = "Informação",
            footer=tagList( modalButton( "Ok" ) )
        ))

    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "verifNChar"              #
    #                                                           #
    #############################################################

    verifNChar <- function(){
    
        if( 
            nchar( input$nome )          >  200 |
            nchar( input$email )         >  200 |
            nchar( input$cracha )        >  200 |
            nchar( input$instituicao )   >  200 |
            nchar( input$tituloTrab )    >  200 |
            nchar( input$autoresTrab )   >  200 |
            nchar( input$palavChavTrab ) >  200 |
            nchar( input$institAutTrab ) >  200 |
            nchar( input$orgFomTrab )    >  200 |
            nchar( input$patrocTrab )    >  200 |
            nchar( input$textoTrab )     > 2000 |
            nchar( input$sugestoes )     > 2000
         ){ 
            lab01 <- "Há caracteres excedentes nos campos preenchidos"
            lab02 <- "Por favor, revise-os!"
            funcModVerifPDF( lab01, lab02 )

            shinyjs::enable( "butSubmis" )
            return( TRUE  )
         } else {
            return( FALSE )
        }
    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "funcModalVerifPDF"       #
    #                                                           #
    #############################################################
    
    funcModalVerifPDF <- function( lab_1, lab_2 ){
    
        showModal( modalDialog(
            tags$h4(
                tags$p( lab_1 ),
                tags$br(),
                tags$p( lab_2 )
            ),
            title = "Informação",
            footer=tagList( modalButton( "Ok" ) )
        ))
        
    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "funcUploadPDF"           #
    #                                                           #
    #############################################################

    funcUploadPDF <- function( filepath, tableName, nomeArq ){
    
        # Faz leitura do PDF como Blob
		pdfBlobR <- as_blob( readBin( filepath, what="raw", n=as.numeric( tamanhoArquivoPermitido ) ) )
    
        # Verificar se existe dados de Arquivos na DB
        sql <- paste0( "SELECT EXISTS(SELECT pdfBlob FROM ", tableName , " WHERE nomeArq = ? )")
        decisao <-  dbGetQuery( conDB, sql, params=list( nomeArq ) )[[1]]


        if( decisao == 0 ) {
        
            # Grava versão pela primeira vez
            sql <- paste0("Insert INTO ", tableName," (pdfBlob,  nomeArq) VALUES ( ?, ? )")
            dbExecute( conDB, sql, params=list( pdfBlobR, nomeArq ) )
    
        }
        
        if( decisao == 1 ){
        
            # Grava versão como atualização
            sql <- paste0( "UPDATE ", tableName, " SET pdfBlob = ? WHERE nomeArq = ?" )
            dbExecute( conDB, sql, params=list( pdfBlobR, nomeArq ) )
        
        }
    
        return( TRUE )
    
    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "verifTypePDF"            #
    #                                                           #
    #############################################################
    
    verifTypePDF <- function( input, id ){
        
        falhaPDF <- FALSE
        
        res1 <- try( pdf_length( input$datapath ), silent=TRUE )
        res1 <- length( grep( "^Error", res1[[1]] ) )
        res2 <- length( grep( "pdf", input$type ) )
        
        # verifica se é o TIPO PDF
        if( res1 == 1 | res2 == 0 ){
        
            lab01 <- "Arquivo não foi detectado como PDF válido"
            lab02 <- "Por favor, refaça a formatação do mesmo!"
            funcModalVerifPDF( lab01, lab02 )
            falhaPDF <- TRUE
            shinyjs::reset( id )
            
        }
        
        ifelse( falhaPDF, return( TRUE ), return( FALSE ) )
    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "verif1PagePDF"           #
    #                                                           #
    #############################################################
    
    verif1PagePDF <- function( input, id ){
    
        falhaPDF <- FALSE
        
        # verifica se tem 1 Página com pdftools
        if( pdf_length( input$datapath ) > 1 ){
        
            lab01 <- "Detectado mais que 1 página"
            lab02 <- "Por favor, formate-o com seguindo o modelo!"
            funcModalVerifPDF( lab01, lab02 )
            falhaPDF <- TRUE
            shinyjs::reset( id )
            
        }
        
        ifelse( falhaPDF, return( TRUE ), return( FALSE ) )
    }        

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "verifA4PDF"              #
    #                                                           #
    #############################################################
    
    verifA4PDF <- function( input, id ){
    
        falhaPDF <- FALSE
        
        # verifica se Página é A4
        altura <- abs( pdf_pagesize( input$datapath )$height - paginaPropriedade$pageHeight)
        largur <- abs( pdf_pagesize( input$datapath )$width  - paginaPropriedade$pageWidth )
        
        if( altura > 2 | largur > 2 ){
        
            lab01 <- paste0( "Página não segue padrão de medidas ", paginaPropriedade$tipo )
            lab02 <- "Por favor, formate-o com seguindo o modelo!"
            funcModalVerifPDF( lab01, lab02 )
            falhaPDF <- TRUE
            shinyjs::reset( id )
    
        }
        
        ifelse( falhaPDF, return( TRUE ), return( FALSE ) )
    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "verifSizePDF"            #
    #                                                           #
    #############################################################
    
    verifSizePDF <- function( input, id ){
    
        falhaPDF <- FALSE
        
        # verifica se o arquivo é maior que 5MB        
        if( file.size( input$datapath ) > tamanhoArquivoPermitido  ){
        
            lab01 <- paste0("O arquivo não deve ter mais que ", format( tamanhoArquivoPermitido, units='auto'))
            lab02 <- "Por favor, formate-o seguindo essa especificação"
            funcModalVerifPDF( lab01, lab02 )
            falhaPDF <- TRUE
            shinyjs::reset( id )
        }
        
        ifelse( falhaPDF, return( TRUE ), return( FALSE ) )
    }

    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "resultAvaliador"         #
    #                                                           #
    #############################################################
    
    resultAvaliador <- function(){
    
        NObj <- nrow( opQuestoesObjetivas )
        NDis <- nrow( opQuestoesDissertativas )
        
        # Buscar resposta na DB ou gerar vetores de resp vazios
        
        if( isTRUE( envParticip$dados_previos_na_DB ) ){
		
            mainTableR <- get( "mainTableR", envir=envParticip )
            
            respObj <- mainTableR$respObjetiv
            
            if( is.na( respObj[[1]] ) | respObj[[1]] == "" ){
            
                respObj <- character( NObj )
            
            } else {
            
                respObj <- strsplit( respObj, split='&' )[[1]]
                respObj <- sub( "^([[:digit:]]{1,2})([[:punct:]]+)(.*)$", "\\3", trimws(respObj) )
            }
            
            respDis <- mainTableR$respDissert

            if( is.na( respDis[[1]] ) | respDis[[1]] == "" ){
            
                respDis <- character( NDis )
                
            } else {
            
                respDis <- strsplit( respDis, split='&' )[[1]]
                
            }
            
            opResultAvalResumoDB <- mainTableR$opResultAvalResumo
            if( is.na( opResultAvalResumoDB ) ) opResultAvalResumoDB <- ""
            
            opRequisicaoAvalResumoDB <- mainTableR$opRequisicaoAvalResumo
            if( is.na( opRequisicaoAvalResumoDB ) ) opRequisicaoAvalResumoDB <- ""

            dataAvaliacao <- paste0( "Data da Avaliação: ", mainTableR$dataAvaliacao )
            if( is.na( mainTableR$dataAvaliacao ) ) dataAvaliacao <- "Data da Avaliação: Não disponível"
            
        } else {    
        
            respObj <- character( NObj )
            respDis <- character( NDis )
            opResultAvalResumoDB  <- ""
            opRequisicaoAvalResumoDB <- ""
            dataAvaliacao <- "Data da Avaliação: Não disponível"
        
        }
        
        fmtPerg <- function( perg ) paste0( "<p><b>Questão ", i, '</b> - ', perg ,"</p>" )
        fmtResp <- function( resp ) paste0( "<p><em>Resp.:  ", resp ,"</em></p>" )
        fmtItem <- function( item ) paste0( '<div class="well">', item, '</div>' )
        
        relObj <- character( NObj )
        relDis <- character( NDis )
        
        for( i in 1:NObj )
            relObj[ i ] <- fmtItem( paste0( fmtPerg( opQuestoesObjetivas[i,"Pergunta"] ), fmtResp( respObj[i] ) ) )
        
        for( i in 1:NDis )
            relDis[ i ] <- fmtItem( paste0( fmtPerg( opQuestoesDissertativas[i,"Pergunta"] ), fmtResp( respDis[i] ) ) )
        
        ###################################################################
        
        output$dataAvaliacao <- renderText({ dataAvaliacao })
    
        output$labItensObj <- renderText({ "<h4><b>&bull; Itens Objetivos &bull;</b></h4>" })
        output$relatItensObj <- renderText({ HTML( relObj ) })
        
        output$labItensDis <- renderText({ "<h4><b>&bull; Itens Dissertativos &bull;</b></h4>" })
        output$relatItensDis <- renderText({ HTML( relDis ) })
        
        output$labResultAval <- renderText({ "<h4><b>&bull; Resultado &bull;</b></h4>" })
        
        labAval <- paste0( '<div class="well"><ul><li><b>Resultado da Avaliação: </b><em>', opResultAvalResumoDB, '</em></li></ul></div>' )
        output$relatConclusAval <- renderText({ HTML( labAval ) })
        
        labReq <- paste0( '<div class="well"><ul><li><b>Requisição de Nova Versão de Resumo com Correções: </b><em>', opRequisicaoAvalResumoDB, '</em></li></ul></div>' )
        output$relatRequisAval <- renderText({ HTML( labReq ) })

    }

    #############################################################
    #                                                           #
    #    Declaração da FUNÇÃO "funcModGeralCamposInvalidos"     #
    #                                                           #
    #############################################################
    
    funcModGeralCamposInvalidos <- function( inform01, inform02 ){
    
        # Mostra janela de diálogo modal
        showModal( modalDialog(
            tags$h4(
                tags$p( inform01 ),
                tags$br(),
                tags$p( inform02 ),    
                ),
            title = "Envio",
            footer = modalButton("Ok")
        ))
    
    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcDownloadPDFComprovaPG"   #
    #                                                           #
    #############################################################

    funcDownloadPDFComprovaPG <- function(...){
        
        return( downloadHandler(
    
            filename = function() {
            
                numeroInsc     <- isolate( input$numeroInsc )
                
                versao <- gsub( "^(versão )(.)$", "\\2", isolate( input$selectComprovaPgVers ) )
                
                nomeArqPDF    <- paste0( numeroInsc, "-vers-", versao, "-PG.pdf" )

                return( nomeArqPDF )

            },
        
            content = function( file ) {
    
                numeroInsc     <- isolate( input$numeroInsc )
                
                versao <- gsub( "^(versão )(.)$", "\\2", isolate( input$selectComprovaPgVers ) )
                
                nomeArq     <- paste0( numeroInsc, "-vers-", versao, "-PG" )
                
                sql <- "SELECT pdfBlob FROM comprovaPgTable WHERE nomeArq = ?"
                res <- dbGetQuery( conDB, sql, params=list( nomeArq ) )
                
                writeBin( object = unlist( res,T,F ), con = file )                    
            
            },
        
            contentType = "application/pdf"
    
        ))
    
    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcDownloadPDFResumo"       #
    #                                                           #
    #############################################################

    funcDownloadPDFResumo <- function(...){
        
        return( downloadHandler(
    
            filename = function() {

                numeroInsc <- isolate( input$numeroInsc )

                versao <- gsub( "^(versão )(.)$", "\\2", isolate( input$selectResumoVers ) )
                
                nomeArqPDF    <- paste0( numeroInsc, "-vers-", versao, ".pdf" )

                return( nomeArqPDF )

            },
        
            content = function( file ) {
            
                numeroInsc     <- isolate( input$numeroInsc )
                
                versao <- gsub( "^(versão )(.)$", "\\2", isolate( input$selectResumoVers ) )
                
                nomeArq    <- paste0( numeroInsc, "-vers-", versao )
            
                sql <- "SELECT pdfBlob FROM resumoTable WHERE nomeArq = ?"
                res <- dbGetQuery( conDB, sql, params=list( nomeArq ) )
                
                res <<- res

                writeBin( object = unlist( res,T,F ), con = file )                    
            
            },
        
            contentType = "application/pdf"
    
        ))
    
    }

    #############################################################
    #                                                           #
    #     Declaração da FUNÇÃO "funcDesistenciaBut"             #
    #                                                           #
    #############################################################

	funcDesistenciaBut <- function(){

		# Mostra janela de diálogo modal
        showModal( modalDialog(
            tags$h4(
                tags$p( 'Confirma a exclusão irreversível de todos os dados?' ),
                tags$br(),
                tags$p( '' ),    
                ),
            title = "Exclusão de Dados",
            footer=tagList(
                actionButton( "modButDesistenciaOk", "Ok" ),
                modalButton( "Cancel" )
            )
        ))
	
	}
	
	#############################################################
    #                                                           #
    #   Declaração da FUNÇÃO "funcDesistenciaModal"             #
    #                                                           #
    #############################################################

	funcDesistenciaModal <- function(){

		numeroInsc <- envParticip$mainTableR$numeroInsc
		
		# query de deleção dos dados básicos
		sql <- "DELETE FROM mainTable WHERE numeroInsc = ?"
        res <- dbExecute( conDB, sql, params=list( numeroInsc ) )

		# query de deleção dos arquivos de Comprovante de Pagamento
		sql <- "Select nomeArq FROM comprovaPgTable"
		res <- dbGetQuery( conDB, sql )[,1]
		res <- res[ grep( numeroInsc, res ) ]
		sql <- "DELETE FROM comprovaPgTable WHERE nomeArq = ?"
        res <- dbExecute( conDB, sql, params=list( res ) )

		# query de deleção dos arquivos de Resumos
		sql <- "Select nomeArq FROM resumoTable"
		res <- dbGetQuery( conDB, sql )[,1]
		res <- res[ grep( numeroInsc, res ) ]
		sql <- "DELETE FROM resumoTable WHERE nomeArq = ?"
        res <- dbExecute( conDB, sql, params=list( res ) )

		removeModal()

        session$close()

    }


