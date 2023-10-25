
    #####################################################
    div( id="interfaceCadastrador", style="display: none;",
    #####################################################
    fluidPage( column( width = 8, offset = 2,
    
        #####################################################################
        #                                                                   #
        #                    Interface de Cadastrador                       #
        #                                                                   #
        #####################################################################
        
        #####################################################################
        #                        Barra do Status                            #
        #####################################################################

        br(),
        
        div( id="panelCadastrador", style="display: true;",
        
            wellPanel( br(), wellPanel (
            
                div( id='panelNomeCadastrador', style="display: true;", class="bg-success",
            
                    textInput( "nomeCadastrador", "Cadastrador", value = "Nome vai Aqui............" )
            
                ),
                
                div( id='panelStatusCadastrador', style="display: true;", class="bg-success",

                    textInput( "statusCadastrador", "Situação", value = "" )
                
                )
            
            ) )
            
        ),

        #####################################################################
        #                                                                   #
        #                    Cadastramento: Info Básicas                    #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelCadInfoBasic", style="display: true;",
        
            wellPanel( h4("Passo 1A - Informações Básicas do Integrante" ),
        
                actionLink( "linkHSCadInfoBasic", "Mostrar | Ocultar" ),
        
                tags$br(), br(),
                
                div( id="panelCadInfoBasicSub01", style="display: none;",
            
                    htmlOutput( "labInfoCadInteg01" ),
                    htmlOutput( "labInfoCadInteg02" ),
                    htmlOutput( "labInfoCadInteg03" ),
                    htmlOutput( "labInfoCadInteg04" ),

                    br(), 
            
                    wellPanel( id='panelInfoInteg', style="display: true;",
                    
                        tags$br( ),
            
                        textInput( "nomeIntegrante", "Nome completo", value = "", placeholder = "Nome completo do Integrante" ),
                        htmlOutput("labNomeInteg"),
                        
                        br(),
                        
                        textInput( "cpfIntegrante", "CPF", value = "", placeholder = "xxx.xxx.xxx-xx" ),
                        htmlOutput("labCpfInteg"),
                        
                        br(),
                        
                        textInput( "emailIntegrante", "e-mail", value = "", placeholder = "e-mail para contato do congresso" ),
                        htmlOutput("labMailInteg"),
                        
                        br(),
                        
                        textInput( "crachaIntegrante", "Nome para crachá", value = "", placeholder = "Nome desejado para o crachá" ),
                        htmlOutput("labCrachaInteg"),
                        
                        br(),
                        
                        textInput( "instituicaoInteg", "Afiliação Institucional", value = "", placeholder = "Instituição/Departamento de filiação do Integrante" ),
                        htmlOutput("labInstitInteg")

                    )
            
                )# <- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),#<- fecha o panelCadAval                        

        #####################################################################
        #                                                                   #
        #                Cadastramento: Paticularidades                     #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelCadParticular", style="display: true;",
        
            wellPanel( h4("Passo 2A - Particularidades do Integrante para o Evento" ),
        
                actionLink( "linkHSCadParticular", "Mostrar | Ocultar" ),
        
                tags$br(), br(),
                
                div( id="panelCadParticularSub01", style="display: none;",
            
                    htmlOutput( "labCadParticular01" ),
                    htmlOutput( "labCadParticular02" ),
                    htmlOutput( "labCadParticular03" ),
                    #htmlOutput( "labCadParticular04" ),

                    br(), 
            
                    wellPanel( id='panelInfoParticular', strong( HTML("&bull; Cadastramento de Integrantes &bull;") ), style="display: true; height: 650px", 
                    
                        tags$br( ),                        

                        tags$hr( width="100%", align="center" ),
                        
                        mainPanel( width = 12, tabsetPanel( type = "tabs",
                        
                            tabPanel("1-Inscrição",
                        
                                br(),
                        
                                HTML( "&bull; <em>Gerador de Inscrição</em> &bull;" ),
                        
                                br(),br(),
                        
                                wellPanel( id="wellGeraInsc", style="display: true;",
                                
                                    checkboxInput( "checkGeraInscInteg", "Cadastrar Participante no Evento", value = FALSE ),
                                    htmlOutput("labNumInscInteg01"),
                                    htmlOutput("labNumInscInteg02"),
                                    htmlOutput("labNumInscInteg03"),
                                    
                                    pickerInput( "modalInscIntegrante", "Modalidade da Inscrição", choices=opInscricao,
                                        options=list(
                                            "max-options" = 1,
                                            "max-options-text" = "Selecione Apenas 1 opção...",
                                            "none-Selected-Text"="Sem seleção ainda...",
                                            style="btn-outline-primary"
                                        )
                                    ),
                                    
                                    wellPanel( strong("Número de Inscrição"), fluidRow(
                                    
                                        br(),
                                    
                                        column( 3, padding='0px', margin='0px',
                                            actionButton( "butGeraNumInscInteg", "Gerar Número de Inscrição", icon( name="ok-sign", lib="glyphicon" ), width='100%' ),
                                        ),
                                        
                                        column( 9, padding='0px', margin='0px',
                                            textInput( "numeroInscIntegrante", NULL, value = "", width='100%', placeholder="Visualização do Número de Inscrição a ser gerado" )
                                        ),
                                        
                                        htmlOutput("labDataHoraInscInteg")
                                    
                                    )),
                                    
                                    htmlOutput("labModInscInteg01"),
                                    htmlOutput("labModInscInteg02"),
                                    htmlOutput("labModInscInteg03"),
                                
                                ),
                        
                            ),

                            tabPanel("2-Avaliador",
                        
                                br(),
                        
                                HTML( "&bull; <em>Informações sobre os Avaliadores de Resumos</em> &bull;" ),
                        
                                br(),br(),

                                wellPanel( id="wellFAvalRes", style="display: true;",
        
                                    checkboxInput( "checkSeraAvaliador", "Cadastrar Avaliador de Resumos", value = FALSE ),
                                
                                    pickerInput( "areaAvaliador", "Área", choices=opAreaTrab,
                                        options=list(
                                            "max-options" = 1,
                                            "max-options-text" = "Selecione Apenas 1 opção...",
                                            "none-Selected-Text"="Sem seleção ainda...",
                                            style="btn-outline-primary"
                                        )
                                    ),
                                    htmlOutput("labAreaAval"),
                                    
                                    textInput( "palavChavAval", "Palavras-Chaves da subárea do Avaliador", value = "",
                                                placeholder="Separe as palavras-chave por ponto-e-vírgula (;)"
									),
                                    
                                    htmlOutput("labAvaliadorEvento01"),
                                    htmlOutput("labAvaliadorEvento02")
                                
                                )

                            ),                            
                            
                            tabPanel("3-Membro",
                    
                                br(),
                        
                                HTML( "&bull; <em>Membros da Organização</em> &bull;" ),
                        
                                br(),br(),
                        
                                wellPanel( id="wellInfoOrg", style="display: true; width: 800px",
                        
                                    checkboxInput( "checkFuncEvento", "Cadastrar Membro da Organização do Evento", value = FALSE ),
                                    htmlOutput("labIntegFuncEvento01"),
                                    htmlOutput("labIntegFuncEvento02"),
                                    htmlOutput("labIntegFuncEvento03"),
                                    
                                    textInput( "funcaoEvento", "Função na Comissão Organizadora", value = "", placeholder = "Função desemplenhada no Evento", width='100%' ),
                                    htmlOutput("labFuncEvento01"),
                                    htmlOutput("labFuncEvento02")
                        
                                )
                        
                            ),
                            
                            tabPanel("4-Software",
                        
                                br(),
                        
                                HTML( "&bull; <em>Acesso ao Software CMS</em> &bull;" ),
                        
                                br(),br(),
                        
                                wellPanel( id="wellAcessoCMS", style="display: true;",
        
                                    checkboxInput( "checkTemFunSoftware", "Delegar funções contidas no Software CMS ao Membro da Organização do Evento", value = FALSE ),
                                
                                    pickerInput( "softwareFuncInteg", "Função Delegada", choices=c("admin","cadastrador","atribuidor","tesoureiro","subeventos","comunica"),
                                        options=list(
                                            #"max-options" = 1,
                                            #"max-options-text" = "Selecione Apenas 1 opção...",
                                            "none-Selected-Text"="Sem seleção ainda...",
                                            style="btn-outline-primary"
                                        )
                                    ),
                                    htmlOutput("labFunSoftInteg01"),
                                    htmlOutput("labFunSoftInteg02"),
                                    htmlOutput("labFunSoftInteg03")
                                
                                )

                            ),

                        ))#<- fecha mainPanel e tabsetPanel
                    
                    ),#<- fecha wellPanel 'panelInfoParticular'
                    
                    wellPanel( br(),

                        wellPanel( br(),
                
                            fluidRow( column( width = 4, offset = 4,
                
                            actionButton("butCadastrarInfo", "Cadastrar Informações", icon( name="upload", lib="glyphicon" ) )
                    
                            ))
                        
                        ),#<- fecha wellPanel do Botão "Cadastrar"
                    
                        htmlOutput("labButCadInfo01"),
                        htmlOutput("labButCadInfo02")
                        
                    ),

                )#<- fecha div "panelCadParticular01"
                
            )#<- fecha wellPanel "Passo 2 - Particularidades"
            
        ),#<- fecha div "panelCadParticular"
        
        br(),
        
        # Cria uma linha tracejada
        tags$hr( size="1", style="border:1px dashed gray;", width="25%", align="center" ),
        
        br(),
        
        #####################################################################
        #                                                                   #
        #                Visualização de Quadro de Avaliadores              #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelQuadroAval", style="display: true;",
        
            wellPanel( h4("Passo 1B - Visualização do Quadro de Avaliadores; Seleção" ),
        
                actionLink( "linkHSQuadroAval", "Mostrar | Ocultar" ),
        
                tags$br(), br(),
                
                div( id="panelQuadroAvalSub01", style="display: none;",
            
                    htmlOutput( "labTableAval01" ),
                    htmlOutput( "labTableAval02" ),
                    htmlOutput( "labTableAval03" ),
                    
                    br(),
                    
                    wellPanel(
                    
                        actionButton( "butAtualizaTableAval", "Atualizar a Tabela 2: Avaliadores Disponíveis",
                            icon( name="refresh", lib="glyphicon" ), width='100%'
                        )
                    
                    ),
                    
                    wellPanel( br(),
                    
                        wellPanel( br(), dataTableOutput('tableAval') )
                    
                    ),
                    
                    br(),
    
                    br(),br(),br(),br(),br(),br() 
                    
                
                )
        
            )
        
        ),
        
        br(),
        
        # Cria uma linha tracejada
        tags$hr( size="1", style="border:1px dashed gray;", width="25%", align="center" ),
        
        br(),
        
        #####################################################################
        #                                                                   #
        #                Visualização de Quadro da Organização              #
        #                                                                   #
        #####################################################################
        
        br(),
        
        div( id="panelQuadroOrganiz", style="display: true;",
        
            wellPanel( h4("Passo 1C - Visualização do Quadro da Organização; Seleção" ),
        
                actionLink( "linkHSQuadroOrg", "Mostrar | Ocultar" ),
        
                tags$br(), br(),
                
                div( id="panelQuadroOrgSub01", style="display: none;",
            
                    htmlOutput( "labQuadroOrg01" ),
    
                    br(),br(),br(),br(),br(),br() 
                    
                
                )
        
            )
        
        ),
        
        #####################################################################
        #                                                                   #
        #                            Rodapé                                 #
        #                                                                   #
        #####################################################################

        br(),
        
        div( id="panelRodapeCadast",
            
            wellPanel( " ",

                # Algo para o rodapé???
        
            )
        
        )
        
        ############################################

    ))# <- fecha fluidPage e column do top da página

    )# <- #<- fecha div( id="interfaceCadastrador" )

