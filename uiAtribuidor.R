
    #####################################################
    div( id="interfaceAtribuidor", style="display: none;",
    #####################################################
    fluidPage( column( width = 8, offset = 2,
    
        #####################################################################
        #                                                                   #
        #                    Interface de Atribuidor                        #
        #                                                                   #
        #####################################################################
        
        #####################################################################
        #                        Barra do Status                            #
        #####################################################################

        br(),
        
        div( id="panelAtribuidor", style="display: true;",
        
            wellPanel( br(), wellPanel (
            
                div( id='panelNomeAtribuidor', style="display: true;", class="bg-success",
            
                    textInput( "nomeAtribuidor", "Atribuidor", value = "Nome vai Aqui............" )
            
                ),
                
                div( id='panelStatusAtribuidor', style="display: true;", class="bg-success",

                    textInput( "statusAtribuidor", "Situação", value = "" )
                
                )
            
            ) )
            
        ),

        #####################################################################
        #                                                                   #
        #    Informação sobre a Atribuição dos Resumos aos Avaliadores      #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelInformaAtribuicao", style="display: true;",
        
            wellPanel( h4("Passo 1 - Visualizar Informações sobre Atribuições" ),
        
                actionLink( "linkHSAtribuicaoResumo", "Mostrar | Ocultar" ),
        
                tags$br(), br(),
                
                div( id="panelAtribuicaoResumoSub01", style="display: none;",
            
                    htmlOutput( "labInfoAtrib01" ),
    
                    br(), 
            
                    wellPanel( id='panelInformativo', h4("Situação"), style="display: true;",
            
                        wellPanel( strong("Área(s):"), div( align="center", tableOutput('infoArea') ) ),
    
                        wellPanel( strong("Avaliador(es):"), div( align="center", tableOutput('tableResAtrib') ) )
            
                    )
            
                )# <- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),#<- fecha o panelAtribuicaoResumo
        
        #####################################################################
        #                                                                   #
        #            Dados sobre Resumo a serem atribuidos                  #
        #                                                                   #
        #####################################################################

        br(),
        
        div( id='panelDadosAtribResumo',
        
            wellPanel( h4("Passo 2 - Visualizar Informações sobre Resumo"), style="display: true;",
            
                actionLink( "linkHSDadosAtribResumo", "Mostrar | Ocultar" ),
                
                tags$br(), br(),
                
                div( id='panelDadosAtribResumoSub01', style="display: none;",
                
                    htmlOutput("labDadosAtribRes01"),
                    htmlOutput("labDadosAtribRes02"),
                    htmlOutput("labDadosAtribRes03"),
                    htmlOutput("labDadosAtribRes04"),
                    
                    br(),
                
                    wellPanel( id='infoResAtrib',
                
                        textAreaInput( "tituloCand", "Título do Trabalho", rows=3, resize="vertical", value="" ),
                    
                        textAreaInput( "autoresCand", "Autores do Trabalho", rows=2, resize="vertical", value="" ),
                    
                        textAreaInput( "palavChaveCand", "Palavras-Chave", rows=2, resize="vertical", value="" ),
                        
                        selectInput( "areaDeclaradaCand", "Area do Trabalho Declarada", choices=opAreaTrab ),
                        
                        ###################################
                        actionButton("butHSadversa", NULL ),
                        ###################################
                        
                        br(),
                        
                        wellPanel( id="panelAreaAdversa", style="display: none;",
                        
                            htmlOutput( "labAreaAderenciaAdversa" ),
                            
                            br(),
                            
                            selectInput( "areaAderenciaResumo", HTML("&bull; Atribuir à Área Adversa &bull;"), choices=opAreaTrab )
                        
                        ),
                        
                        actionLink( "linkHSdetalhesResAtrib", "+ Detalhes" ),
                        
                        br(),br(),

                        wellPanel( id='detalhes-Particip-Avaliador', h4("Detalhes sobre"), style="display: none;",
        
                            wellPanel( strong("Participante:"),

                                br(),br(),
                                
                                htmlOutput("detalhesParticipAtrib")

                            ),
                
                            wellPanel( strong("Avaliador:" ),

                                br(),br(),
                                
                                htmlOutput("detalhesAvaliadorAtrib")

                            )
                        
                        )
                    
                    ),#<- fecha wellPanel 'infoResAtrib'

                    wellPanel( id='botoesDirecionaisAtribuicao',
                
                        fluidRow(
                
                            column( 6, actionButton( "butAtribAnterior", "Anterior", width='100%', icon( name="circle-arrow-left",  lib="glyphicon" ) ) ),
        
                            column( 6, actionButton( "butAtribProximo", "Proximo",  width='100%', icon( name="circle-arrow-right", lib="glyphicon" ) ) )
                
                        )
        
                    ),
            
                )# <- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),# <- fecha panelDadosAtribResumo
        
        #####################################################################
        #                                                                   #
        #            Opção de Avaliadores para Atribuição                   #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelOpcaoAvaliad",
        
            wellPanel( h4("Passo 3 - Opções de Avaliadores"),
            
                actionLink( "linkHSOpcaoAvaliad", "Mostrar | Ocultar" ),
                
                tags$br(), br(),
                
                div( id="panelOpcaoAvaliadSub01", style="display: none;",
                
                    htmlOutput("labOpcaoAvaliad01"),
                    htmlOutput("labOpcaoAvaliad02"),
                    
                    br(),
            
                    fluidRow(
        
                        column( 6,
                        
                            wellPanel(
                            
                                pickerInput( "atribuido", "Atribuído ao Avaliador", choices=c( "Sem Atribuição Ainda" , NULL ) )
            
                            )
                    
                        ),
                
                        column( 6,
                    
                            wellPanel( id='W04',
                        
                                pickerInput( "fonteAvaliadores", "Avaliadores Cadastrados", choices=NULL )            
                        
                            )
                        
                        )
                    
                    )
            
                )#<- fecha Sub01
        
            )#<- fecha wellPanel
            
        ),#<-fecha panelOpcaoAvaliad
        
        #####################################################################
        #                                                                   #
        #            Atribuição dos Resumos aos Avaliadores                 #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelAcaoAtrib",
        
            wellPanel( h4("Passo 4 - Ação de Atribuição"),
            
                actionLink( "linkHSAcaoAtrib", "Mostrar | Ocultar" ),
            
                tags$br(), br(),
            
                div( id="panelAcaoAtribSub01", style="display: none;",
                
                    htmlOutput( "labAcaoAtrib01" ),
                    htmlOutput( "labAcaoAtrib02" ),
                    
                    br(),
            
                    fluidRow(
        
                        column( 6,
                        
                            wellPanel(
                            
                                actionButton( "atribuirResAval", "Atribuir Resumo ao Avaliador Escolhido", width='100%', icon( name="ok-sign", lib="glyphicon" ) )
            
                            )
                    
                        ),
                
                        column( 6,
                    
                            wellPanel(
                        
                                actionButton( "removerResAval", "Remover a atribuição do Avaliador", width='100%', icon( name="remove", lib="glyphicon" ) )
                        
                            )
                        
                        )
                    
                    )
                
                )#<- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),#<- fecha panelAcaoAtrib
        
        #####################################################################
        #                                                                   #
        #                            Rodapé                                 #
        #                                                                   #
        #####################################################################

        br(),
        
        div( id="panelRodapeAtrib",
            
            wellPanel( " ",

                # Algo para o rodapé???
        
            )
        
        )
        
        ############################################

    ))# <- fecha fluidPage e column do top da página

    )# <- #<- fecha div( id="interfaceAtribuidor" )

