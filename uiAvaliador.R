
    #####################################################
    div( id="interfaceAvaliador", style="display: none;",
    #####################################################
    fluidPage( column( width = 8, offset = 2,
    
        #####################################################################
        #                                                                   #
        #                    Interface de Avaliador                         #
        #                                                                   #
        #####################################################################
    
        #####################################################################
        #                        Barra do Status                            #
        #####################################################################
        
        br(),
        
        div( id="panelAvaliador", style="display: true;",
            
            wellPanel( br(), wellPanel (
            
                div( id='panelNomeAvaliador', style="display: true;", class="bg-success",
            
                    textInput( "nomeAvaliador", "Avaliador", value = "Nome vai Aqui............" )
            
                ),
                
                div( id='panelStatusAliador', style="display: true;", class="bg-success",

                    textInput( "statusAvaliador", "Situação", value = "" )
                
                ),
                
                div( id='panelTravaEdResumo', style="display: true;", class="bg-success",

                    textInput( "statusTravaEdResumo", "Trava de Edição", value = "Liberada" )
                
                )
                
            ) )
            
        ),

        #####################################################################
        #                                                                   #
        #                Tabela dos Resumos a serem avaliados               #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelTabVisInfoRes",
        
            wellPanel( h4(" Passo 1 - Visualização das Informações sobre os Resumos e Seleção "),
            
                actionLink( "linkHStabRes", "Mostrar | Ocultar" ),
            
                tags$br(), br(),
            
                div( id="panelTabVisInfoResSub01", style="display: none;",
            
                    htmlOutput("labTable01"),
                    htmlOutput("labTable02"),
                    htmlOutput("labTable03"),
                    
                    br(),
                    
                    uiOutput( "labTable04" ),
                
                    br(),
        
                    wellPanel( br(),
                    
                    wellPanel( br(), dataTableOutput('table') ),
                    
                    br(),
                    
                    verbatimTextOutput( "infoContabil" )
                    
                    ),
                    
                    br(),
                    
                    actionLink( "linkHSDetalhesRes", "+ Mais Detalhes do Resumo" ),
                
                    div( id="panelDetalhesRes", style="display: none;",
                
                        br(),
                    
                        wellPanel( br(), uiOutput('detalhesResumo') )
                    
                    )

                )# <- fecha Sub01
                
            )#<- fecha wellPanel
    
        ),#<- fecha o panelTabVisInfoRes
    
        #####################################################################
        #                                                                   #
        #                Pausar Edições do Participante                     #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelPausaEdParticip",
            
            wellPanel( h4(" Passo 2 - Pausar Edições do Participante"),
            
                actionLink( "linkHSPausaEdParticip", "Mostrar | Ocultar" ),
            
                tags$br(), br(),
            
                div( id="panelPausaEdParticipSub01", style="display: none;",
            
                    htmlOutput("labPausa01"),
                    htmlOutput("labPausa02"),
                    htmlOutput("labPausa03"),
                    htmlOutput("labPausa04"),
                    
                    br(),
                    
                    htmlOutput("labPausa05"),
                    
                    br(),
                    
                    wellPanel(
                    
                    checkboxInput( "checkPausaEdParticip", "Pausar as possibilidade das edições do participante termporariamente", value = FALSE ),
                    
                    br(),
                    
                    verbatimTextOutput( "avisoPausa" ),
                    verbatimTextOutput( "avisoPasso1" ),
                    verbatimTextOutput( "avisoPasso2" ),
                    verbatimTextOutput( "avisoPasso3" )
                    
                    )
                
            
                )#<- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),#<-fecha panelPausaEdParticip
        
        #####################################################################
        #                                                                   #
        #            Download do Resumo Específico Selecionado              #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelSelecDownRes",
        
            wellPanel( h4(" Passo 3 - Download do Resumo Específico Selecionado "),
            
                actionLink( "linkHSselecDownRes", "Mostrar | Ocultar" ),
            
                tags$br(), br(),
            
                div( id="panelSelecDownResSub01", style="display: none;",
                
                    uiOutput( "labDownload01" ),
                    uiOutput( "labDownload02" ),
    
                    tags$br(),
                    
                    uiOutput( "labDownload03" ),
                    
                    br(),
                
                    wellPanel( h4("Download das Versões: "),
                
                        tags$br(),
                        
                        selectInput( "avalVersPdfRes", "Versões disponíveis", multiple=F, selectize=T, choices=c("versão 1") ),
                        
                        downloadButton( "downPDFResAval", "Download", contentType="application/pdf" )#, style = "visibility: hidden;" )

                    ),
                
                )#<- fecha Sub01
            
            )#<- fecha wellPanel
        
        ),#<- fecha panelSelecDownRes

        #####################################################################
        #                                                                   #
        #                            Questionário                           #
        #                                                                   #
        #####################################################################

        br(),
        
        div( id="panelRespQuestionario",
        
            wellPanel( h4(" Passo 4  -  Questionário "),
            
                actionLink( "linkHSrespQuest", "Mostrar | Ocultar" ),
                
                tags$br(), br(),
                
                div( id="panelRespQuestionarioSub01", style="display: none;",
                
                br(),# tags$br(),
                
                uiOutput( "labQuestionarioAval01" ),
                uiOutput( "labQuestionarioAval02" ),
                uiOutput( "labQuestionarioAval03" ),
                uiOutput( "labQuestionarioAval04" ),
                uiOutput( "labQuestionarioAval05" ),
                uiOutput( "labQuestionarioAval06" ),
                
                br(),
                
                uiOutput( "labQuestionarioAval07" ),
                
                br(),
                
                wellPanel(
                
                br(),
        
                fluidRow(
            
                column(6,
            
                    actionButton( 'itObjetivos', 'Itens Objetivos', width='100%', icon( name="question-sign", lib="glyphicon" ) ),
                    br(),tags$br(),
                    verbatimTextOutput( "infoObjResp" ),
                    tableOutput("tableViewRespObj")
                ),
                    
                column(6,
                    
                    actionButton( 'itDissertat', 'Itens Dissertativos',  width='100%', icon( name="question-sign", lib="glyphicon" ) ),
                    br(),tags$br(),
                    verbatimTextOutput( "infoDisResp" ),
                    tableOutput("tableViewRespDis")
                )
                
                ),
        
                br(), 
            
                # Espaço para mostrar TODAS Perguntas: MAS Começa mostrando a 1ª Questão Objetiva
                textAreaInput( "showQuestion", "Questão 1 - Objetiva", rows=2, resize="vertical",
                            value=as.character( opQuestoesObjetivas[ 1, 1 ] ) ),
        
                div( style="min-height: 165px; ",
                
                # Mostra opções para itens objetivos: Começa mostrando a 1ª Questão Objetiva
                radioButtons( inputId="respQuestObjetiv", label="Opções das Questões Objetivas", choices=as.character( opQuestoesObjetivas[ 1, -1 ] ), selected=character(0) ),
                
                # Mostra espaço para escrita de resposta dissertativa
                textAreaInput( inputId="respQuestDissert", "Respostas das Questões Dissertativas", rows=4, resize="vertical", value="",
                    placeholder="Espaço para escrita das respostas dissertativas" ),

                uiOutput( 'ncaract', style="display: none;" )

                ),
            
                # Mostra botão Registrar
                actionButton( 'regResposta','Registrar resposta ao item', width='100%', icon( name="ok-sign",  lib="glyphicon" ) ),
            
                # Mostra a ação atual do usuário
                tags$br(), br(), verbatimTextOutput( "regItemCurrent" ),
            
                # Mostra botões direcionais
                fluidRow( column(6, actionButton( 'pergAnterior','Anterior', width='100%', icon( name="circle-arrow-left",  lib="glyphicon" ) ) ),
                    column(6, actionButton( 'pergProxima', 'Próxima',  width='100%', icon( name="circle-arrow-right", lib="glyphicon" ) ) ) 
                ),
            
                # Mostra o registro geral
                br(), textAreaInput( 'showRegistro', "Somente Visualização dos Registros", value="", rows=4, resize="vertical" )

                )
        
                )#<- fecha Sub01
            
            )# <- fecha o wellPanel
        
        ),#<- fecha "panelRespQuestionario"
        
        #####################################################################
        #                                                                   #
        #                            Conclusão                              #
        #                                                                   #
        #####################################################################

        br(),
        
        div( id="panelConclusao",
        
            wellPanel( h4(" Passo 5 - Conclusão e Envio dos Resultados "),
            
                actionLink( "linkHSconclusao", "Mostrar | Ocultar" ),
            
                tags$br(), br(),
            
                div( id="panelConclusaoSub01", style="display: none;",

                    #tags$br(),
                    
                    uiOutput( "labConclusAval00" ),
                    
                    br(),
                    
                    uiOutput( "labConclusAval01" ),
                    uiOutput( "labConclusAval02" ),
                    uiOutput( "labConclusAval03" ),
                    uiOutput( "labConclusAval04" ),

                    br(),
                    
                    wellPanel(
                    
                    br(),
                    
                    radioButtons( "radAval", "Avaliação - Conclusão", choices=opResultAvalResumo[[1]], selected = "0" ),
                    
                    uiOutput( "avaliacaoAnterior" ),
                    
                    br(),br(),
                    
                    radioButtons( "radRequisicao", "Requisição de Nova Versão do Resumo", choices=opRequisicaoAvalResumo[[1]], selected = "0" ),
                    
                    uiOutput( "requisicaoAnterior" ),
                    
                    br()
                    
                    ),
                    
                    br(),
                    
                    wellPanel(
                    
                        fluidRow( column( width = 4, offset = 4,
                    
                        br(),
                    
                        actionButton( "butEnvioAval", "Enviar Resultados da Avaliação",
                            icon( name="upload", lib="glyphicon" )
                        )
                        
                        )),
                        
                        br()
                        
                    )
                    
                )#<- fecha Sub01
                
            )#<- fecha wellPanel
            
        ),#<- fecha panelConclusao

        #####################################################################
        #                                                                   #
        #                            Rodapé                                 #
        #                                                                   #
        #####################################################################

        br(),
        
        div( id="panelRodapeAval",
            
            wellPanel( " ",

                # Algo para o rodapé???
        
            )
        
        )

        
    ))#<- fecha fluidPage e column do top da página
    
    )#<- fecha div( id="interfaceAvaliador" )
