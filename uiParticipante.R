
    ########################################################
    div( id="interfaceParticipante", style="display: none;",
    ########################################################
    fluidPage( column( width = 8, offset = 2,
    
        div( id="panelEntradaParticip", style="display: none;",
    
            #####################################################################
            #                                                                   #
            #            Determina:                                             #
            #            1 - Se é Primeira Inscrição ou                         #
            #            2 - Se é Recuperação de dados para Edição              #
            #                                                                   #
            #####################################################################
            
            #####################################################################
            #                                                                   #
            #                            Fazer Inscrição                        #
            #                                                                   #
            #####################################################################
            
            br(),
            
            wellPanel( style="display: true; height: 600px", br(),
            
            mainPanel( width = 12, tabsetPanel( type = "tabs",

                tabPanel( h4("1-Fazer Inscrição"),
            
                    br(),
                    
                    HTML( "&bull; <em>Destinado ao preenchimento das informações para se inscrever no evento</em> &bull;" ),
                    
                    br(),br(),
                    
                    #####################################################################
                    #                                                                   #
                    #                            Fazer Inscrição                        #
                    #                                                                   #
                    #####################################################################
            
                    div( id="panelPrimeiraInsc",
            
                        wellPanel(
                    
                            htmlOutput("labPrimInsc01"),
                            htmlOutput("labPrimInsc02"),
                            
                            htmlOutput("labPrazoNovasInscricoes"),
                        
                            br(),
                        
                            actionButton("butPrimInsc", "Inscrever-se", icon( name="edit", lib="glyphicon" ) ),
                        
                            br(),
                        
                        )# fecha wellPanel
                    
                    )
            
                ),#<- fecha panelPrimeiraInsc
            
                tabPanel( h4("2-Acessar Área"),
                
                    br(),
                    
                    HTML( "&bull; <em>Acesso a Área do Inscrito</em> &bull;" ),
                    
                    br(),br(),

                    #####################################################################
                    #                                                                   #
                    #                Recuperar Informações Cadastradas                  #
                    #                                                                   #
                    #####################################################################
        
                    div( id="panelRecupInfo",
            
                        wellPanel( #h4("Conectar-se à Área do Inscrito"),
                    
                            htmlOutput("labRecupInfo01"),
                            htmlOutput("labRecupInfo02"),
                            htmlOutput("labRecupInfo03"),
                            
                            br(),
                            
                            textInput( "enterMailLogin", "Digite seu e-mail cadastrado", value = "", placeholder="e-mail de contato cadastrado" ),
                            
                            passwordInput( "enterSenhaSys", "Digite sua senha do Sistema", value = "", placeholder="Senha do Sistema" ),
                
                            actionButton("butRecupInfo", "Conectar-se ao Sistema", icon( name="sort", lib="glyphicon" ) )
                        
                        )#<- fecha wellPanel
                        
                    )#<- fecha panelRecupInfo
            
                ),
            
                tabPanel( h4("3-Reenviar Senha"),
                
                    br(),
                    
                    HTML( "&bull; <em>Solitação de reenvio da senha pessoal para o e-mail cadastrado</em> &bull;" ),
                    
                    br(),br(),
                    
                    #####################################################################
                    #                                                                   #
                    #                            Reenvio de Senha                       #
                    #                                                                   #
                    #####################################################################
            
                    div( id="panelReenvioSenha",
                    
                        wellPanel( #h4("Reenvio de Senha"),
                        
                            htmlOutput("labReenvioSenha01"),
                            htmlOutput("labReenvioSenha02"),
                            htmlOutput("labReenvioSenha03"),
                            
                            br(),
                            
                            textInput( "enterMailReenvio", "Digite seu e-mail cadastrado", value = "", placeholder="e-mail de contato cadastrado" ),
                            
                            textInput( "enterMailReenvio2", "Redigite para confirmação", value = "", placeholder="e-mail de contato cadastrado" ),
                
                            actionButton("butReevioSenha", "Reenviar Senha do Sistema", icon( name="sort", lib="glyphicon" ) )
                            
                        )#<- fecha wellPanel
                        
                    )#<- fecha panelReenvioSenha

                )
                
            ))
            
            ),

            #####################################################################
            #                                                                   #
            #                                                                   #
            #                                                                   #
            #####################################################################
            
            br(),
            
            div( id="panelRodapeEntrada",
        
                wellPanel( " ",
        
                # Colocar algo aqui de rodapé!!! Figura por exemplo
            
                )#<- fecha wellPanel
            
            )#<- fecha panelRodapeEntrada
            
        ),#<- fecha panelEntradaParticip
        
        #br(),

        #####################################################################
        #                                                                   #
        #                Interface de Participante                          #
        #                                                                   #
        #####################################################################

        #####################################################################
        #                        Barra do Status                            #
        #####################################################################

        div( id="panelStatusParticipante", style="display: none;",
        
            wellPanel( br(), wellPanel (
            
                # para: 1º movimento do Participante: SEMPRE de Imediato
                div( id='panelNumeroInsc', style="display: true;", class="bg-success",
                
                    textInput( "numeroInsc", "Número de Inscrição", value = "" )
                    
                ),

                # para: 2º movimento: livre dentro de prazos
                div( id='panelStatusInsc', style="display: none;", class="bg-warning",
                
                    textInput( "statusInsc", "Situação da Inscrição", value = "" )
                    
                ),
                
                # para 3º movimento: livre dentro de prazos
                div( id='panelStatusResumo', style="display: none;", class="bg-warning",
                
                    textInput( "statusResumo", "Situação da Avaliação", value = "" )
                    
                ),
                
                # Data da Inscrição
                htmlOutput( "dataInsc" ),
                
                br(),
                
                htmlOutput( "mark" )

            ) )
            
        ),
        
        br(),

        ####################################################################
        #                                                                  #
        #        Mostra o painel de Informações do Participante            #
        #                                                                  #
        ####################################################################

        div( id="panelInfoParticipante", style="display: none;",
            
            wellPanel( h4(" Passo 1 - Informações sobre o Participante"),
            
                actionLink( "linkHSParticip", "Mostrar | Ocultar" ),
                
                tags$br(), br(),

                wellPanel( id='panelInfoParticipanteSub01', style="display: none;",

                    tags$br( ),
        
                    textInput( "nome", "Nome completo", value = "", placeholder = "Nome completo do Participante" ),
                    htmlOutput("labNome"),
                    
                    br(),
                    
                    textInput( "cpf", "CPF", value = "", placeholder = "xxx.xxx.xxx-xx" ),
                    htmlOutput("labCPF"),
                    
                    br(),
                    
                    textInput( "email", "e-mail", value = "", placeholder = "e-mail para contato do congresso" ),
                    htmlOutput("labMail"),
                    
                    br(),
                    
                    pickerInput( "modalInscricao", "Modalidade da Inscrição", multiple=T, choices=opInscricao,
                        options=list(
                            "max-options" = 1,
                            "max-options-text" = "Selecione Apenas 1 opção...",
                            "none-Selected-Text"="Sem seleção ainda...",
                             style="btn-outline-primary"
                        )
                    ),
                    htmlOutput("labModInscricao"),
                    
                    br(),
                    
                    textInput( "cracha", "Nome para crachá", value = "", placeholder = "Nome desejado para o crachá" ),
                    htmlOutput("labCracha"),
                    
                    br(),
                    
                    textInput( "instituicao", "Afiliação Institucional", value = "", placeholder = "Instituição de filiação do Participante" ),
                    htmlOutput("labInstituicao")
                
                )#<- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),#<- fecha panelInfoParticipante
        
        ####################################################################
        #                                                                  #
        #  Mostra o painel de Informações sobre Participação em SubEvento  #
        #                                                                  #
        ####################################################################

        br(),
        
        div( id="panelInfoAtividades", style="display: none;",
            
            wellPanel( h4(" Passo 2 - Informações sobre Atividades"),
            
                actionLink( "linkHSAtividades", "Mostrar | Ocultar" ),
                
                tags$br(), br(),
                
                wellPanel( id='panelInfoAtividadesSub01', style="display: none;",

                    tags$br( ),
                    
                    pickerInput( "palestras", "Atividade: Palestras", multiple=T, choices=opPalestras,
                        options=list(
                            "max-options" = 2,
                            "max-options-text" = "Selecione Apenas 2 opções...",
                            "none-Selected-Text"="Sem seleção ainda...",
                             style="btn-outline-primary"
                        ) 
                    ),

                    htmlOutput("labPalestras01"),
                    htmlOutput("labPalestras02"),
                    htmlOutput("labPalestras03"),
                    
                    br(),
                    
                    pickerInput( "minicursos", "Atividade: Minicursos", multiple=T, choices=opMinicursos,
                        options=list(
                            "max-options" = 2,
                            "max-options-text" = "Selecione Apenas 2 opções...",
                            "none-Selected-Text"="Sem seleção ainda...",
                             style="btn-outline-primary"
                        )
                    ),
                    htmlOutput("labMinicursos01"),
                    htmlOutput("labMinicursos02"),
                    htmlOutput("labMinicursos03"),

                    br(),
                    
                    pickerInput( "treinamentos", "Atividade: Treinamentos", multiple=T, choices=opTreinamentos,
                        options=list(
                            "max-options" = 2,
                            "max-options-text" = "Selecione Apenas 2 opções...",
                            "none-Selected-Text"="Sem seleção ainda...",
                             style="btn-outline-primary"
                        )
                    ),
                    htmlOutput("labTreinamentos01"),
                    htmlOutput("labTreinamentos02"),
                    htmlOutput("labTreinamentos03")            
                    
                )#<- fecha Sub01
                
            )#<- fecha wellPanel
            
        ),#<- fecha panelInfoAtividades
        
        br(),

        ####################################################################
        #                                                                  #
        #        Mostra o painel de Informações do Resumo                  #
        #                                                                  #
        ####################################################################
        
        div( id="panelInfoResumo", style="display: none;",
            
            wellPanel( h4("Passo 3 - Informações sobre o Resumo"),
            
                actionLink( "linkHSResumo", "Mostrar | Ocultar" ),
                
                tags$br(), br(),

                div( id='paneInfoResumoSub01', style="display: none;",

                tags$br(),
                
                wellPanel(
                
                # Tomada de decisão para optar por apresentar resumo
                ######################################################
                
                checkboxInput( "modalParticip", "Participação com Submissão de Resumo", value = FALSE ),
                htmlOutput("labModalParticip01"),
                htmlOutput("labModalParticip02"),
                htmlOutput("labModalParticip03")
                
                ),
                
                br(),
                
                ######################################################
                wellPanel( id="wpModalParticip", 
                
                textAreaInput( "tituloTrab", "Titulo", value = "", placeholder = "Título do trabalho", resize="none", rows=2 ),
                htmlOutput("labTituloTrab"),
                
                br(),
                
                textInput( "autoresTrab", "Autores (separados por vírgula)", value = "", placeholder = "Nomes dos autores do trabalho" ),
                htmlOutput("labAutoresTrab"),
                
                br(),
                
                textInput( "palavChavTrab", "Palavras-Chave (separadas por vírgula)", value = "", placeholder = "Palavras-Chaves" ),
                htmlOutput("labPalavChavTrab"),
                
                br(),
                
                radioButtons( "opAreaTrab", label="SubÁreas do Trabalho", selected="0", choices=opAreaTrab[[1]] ),
                htmlOutput("labSubAreaTrab01"),
                htmlOutput("labSubAreaTrab02"),
                
                br(),
                
                textAreaInput( "textoTrab", "Informação Textual do Trabalho", rows=12, resize="vertical", value="" ),
                htmlOutput("labTextoTrab01"),
                htmlOutput("labTextoTrab02"),
                htmlOutput("labTextoTrab03"),                
                
                br(),
                
                textInput( "institAutTrab", "Afliações Institucionais (separados por vírgula)", value = "", placeholder = "Instituições dos autores" ),
                htmlOutput("labInstitAutTrab01"),
                htmlOutput("labInstitAutTrab02"),
                
                br(),
                
                textInput( "orgFomTrab", "Orgãos de Fomento (separados por vírgula)", value = "", placeholder = "Orgãos fomentadores do trabalho" ),
                htmlOutput("labOrgFomTrab01"),
                htmlOutput("labOrgFomTrab02"),
                
                br(),
                
                textInput( "patrocTrab", "Patrocinadores (separados por vírgula)", value = "", placeholder = "Patrocinadores do Trabalho" ),
                htmlOutput("labPatrocTrab01"),
                htmlOutput("labPatrocTrab02")

                )#<- fecha wellPanel só de info do resumo
                
                )#<- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),#<- fecha panelInfoResumo
        
        br(),

        ####################################################################
        #                                                                  #
        #            Mostra o painel de Envio de Arquivos                  #
        #                                                                  #
        ####################################################################

        div( id="panelEnvioArquivos", style="display: none;",
            
            wellPanel( h4(" Passo 4 - Escolha de Arquivos"),
            
                actionLink( "linkHSEnvioArquivos", "Mostrar | Ocultar" ),
                
                tags$br(), br(),
                
                wellPanel( id='panelEnvioArquivosSub01', style="display: none;",

                    tags$br( ),
                    
                    wellPanel(
            
                    checkboxInput( "checkEnvioCompPG", "Comprovante de Pagamento", value = FALSE ),
                    htmlOutput("labEnvioCompPG01"),
                    htmlOutput("labEnvioCompPG02"),
                    htmlOutput("labEnvioCompPG03")
                    
                    ),

                    wellPanel( id='panelEnvio-ComprovaPG', style="display: none;",
                    
                    ### Comprovante de Pagamento em PDF
                    
                    fileInput( "pdfComprovaPg", "1 - Escolha do Arquivo PDF do Comprovante de Pagamento da Inscrição",
                        buttonLabel=list( icon( name="upload", lib="glyphicon" ), "Enviar Arquivo" ),
                        placeholder="Comprovante em arquivo PDF a ser enviado",
                        multiple = FALSE, accept = 'application/pdf' ),
                    htmlOutput("labComprovaPG01"),
                    htmlOutput("labComprovaPG02"),
                    htmlOutput("labComprovaPG03"),
                    htmlOutput("prazoPdfComprovaPG"),
                    
                    br(),
                    
                    wellPanel( h4("Visualização do PDF do Comprovante de Pagamento: "),
                        tags$br(),                    
                        selectInput( "selectComprovaPgVers", "Comprovante arquivado", multiple=F, selectize=T, choices=c("Ainda indisponível...") ),
                        downloadButton( "downloadPDFComprovaPG", "Download", contentType="application/pdf" ), #style = "visibility: hidden;" )
                        br(),br(),htmlOutput("dataComprovaPG")
                    
                    ),
                    
                    htmlOutput("labVisComprovaPG"),
                    
                    br(),
                    
                    tags$hr( size="1", style="border:1px dashed gray;", width="5%", align="center" )
                    
                    ),#<- fecha panelEnvio-ComprovaPG
                    
                    br(),
                    
                    #################################################################################
                    #################################################################################
                    #################################################################################
                    
                    ### Resumo em PDF
                    
                    wellPanel(
                    
                    checkboxInput( "checkEnvioResumo", "Resumo", value = FALSE ),
                    htmlOutput("labEnvioResumo01"),
                    htmlOutput("labEnvioResumo02"),
                    htmlOutput("labEnvioResumo03"),
                    htmlOutput("labEnvioResumo04")
                    
                    ),
                    
                    wellPanel( id='panelEnvio-Resumo', style="display: none;",

                    fileInput( "pdfResumoTrab", "2 - Escolha do Arquivo PDF do Resumo (Em Conformidade com o Modelo)", multiple=F, accept ='application/pdf',
                        buttonLabel=list( icon( name="upload", lib="glyphicon" ), "Enviar Arquivo" ),
                        placeholder="Resumo em arquivo PDF a ser enviado" ),
                    htmlOutput("labPdfResumoTrab01"),
                    htmlOutput("labPdfResumoTrab02"),
                    htmlOutput("labPdfResumoTrab03"),
                    htmlOutput("labPdfResumoTrab04"),
                    htmlOutput("prazoPdfResumo"),

                    br(),
                    
                    wellPanel( h4("Visualização das Versões dos Resumos já arquivados: "),
                        tags$br(),
                        selectInput( "selectResumoVers", "Versões disponíveis", multiple=F, selectize=T, choices=c("Ainda indisponível...") ),
                        downloadButton( "downloadPDFResumo", "Download", contentType="application/pdf" ),# style = "visibility: hidden;" )
                        br(),br(),htmlOutput("dataResumo")
    
                    ),
                    
                    htmlOutput("labVisPdfResumoTrab")
                    
                    )#<- fecha panelEnvio-Resumo

                )#<- fecha Sub01
                
            )#<- fecha wellPanel
            
        ),#<- fecha panelEnvioArquivos
        
        br(),

        ####################################################################
        #                                                                  #
        #                    Mostra o painel de Submissão                  #
        #                                                                  #
        ####################################################################

        div( id="panelSubmis", style="display: none;",
            
            wellPanel( h4("Passo 5 - Submissão das Informações"),
            
                actionLink( "linkHSSubimissao", "Mostrar | Ocultar" ),
                
                tags$br(), br(),
                
                div( id='panelSubmisSub01', style="display: none;",

                br(),
                
                wellPanel(
				
					br(),
				
					mainPanel( width = 12, tabsetPanel( type = "tabs",
					
						tabPanel("1-Envio",
						
							wellPanel( strong("Termo de Responsabilidade"),
							
								br(),br(),
							
								htmlOutput( "termos" ),
								
								br(),
							
								checkboxInput( "concordancia", "Declaro ter ciência e concordância com os termos acima", value = FALSE ),
							
								htmlOutput( "labConcord01" ),
								htmlOutput( "labConcord02" )
							
							)
						
						),
						
						tabPanel("2-Sugestão",
						
							wellPanel(
							
								checkboxInput( "checkSugestoes", "Sugestões | Comentários", value = FALSE ),
								
								textAreaInput( "sugestoes", label=NULL, resize="vertical", rows=6, value="",
									placeholder="Área destinada para sugestões e comentários (Opcional).\nSerá direcional para o Administrador do Sistema."),
								
								htmlOutput("labSugestao01"),
								htmlOutput("labSugestao02")
							
							)
						
						)
						
					)),#<- fecha mainPanel
                
					tags$hr( size="1", style="border:1px dashed gray;", width="10%", align="center" ),
                
					wellPanel( br(),
                
						wellPanel( br(),
					
							fluidRow( column( width = 4, offset = 4,
						
								actionButton("butSubmis", "Enviar Informações", icon( name="upload", lib="glyphicon" ) )
							
							))
					
						),
					
						br(),
					
						htmlOutput( "labButSubmis01" ),
						htmlOutput( "labButSubmis02" ),
						htmlOutput( "labButSubmis03" )
					
					)
					
				)
                
                )#<- fecha Sub01
            
            )#<- fecha wellPanel
            
        ),#<- fecha panelSubmis

        tags$hr( size="1", style="border:1px dashed gray;", width="5%", align="center" ),

        ####################################################################
        #                                                                  #
        #    Mostra o painel de acompanhamento da avaliação (avaliador)    #
        #                                                                  #
        ####################################################################

        div( id="panelQuestionario", style="display: none;",
        
            wellPanel( HTML("<h4>&bull; Resultado da Avaliação &bull;</h4>"),
    
                actionLink("linkHSQuestionario", "Mostrar | Ocultar"),
            
                tags$br(),br(),
            
                div( id="panelQuestionarioSub01", style="display: none;",
                
                br(), wellPanel(
                    
                    htmlOutput("labQuestionario01"),
                    htmlOutput("labQuestionario02"),
                    htmlOutput("labQuestionario03"),
                    
                    br(),
                    
                    htmlOutput("dataAvaliacao"),
                    
                    br(),
                    
                    uiOutput("labItensObj"),
                    
                    actionLink("linkHSItensObj", "Mostrar | Ocultar"),
                    
                    tags$br(),br(),
                    
                    div( id="panelRespItensObj", style="display: none;",
                    
                        wellPanel( uiOutput("relatItensObj") )
                        
                    ),
                    
                    br(),
                
                    uiOutput("labItensDis"),
                    
                    actionLink("linkHSItensDis", "Mostrar | Ocultar"),
                    
                    tags$br(),br(),
                    
                    div( id="panelRespItensDis", style="display: none;",
                    
                        wellPanel( uiOutput("relatItensDis") )
            
                    ),
                    
                    br(),
                
                    uiOutput("labResultAval"),
                
                    actionLink("linkHSResultAval", "Mostrar | Ocultar"),
                
                    tags$br(),br(),
                
                    div( id="panelResultAval", style="display: none;",
                
                        wellPanel( 
                        
                            uiOutput("relatConclusAval"),
                            
                            br(),
                            
                            uiOutput("relatRequisAval")
                            
                        )
            
                    )
        
                ))#<- fecha Sub01
        
            )#<- fecha wellPanel: "Questionário - Resposta do Avaliador"
        
        ),#<- fecha panelQuestionario

        ####################################################################
        #                                                                  #
        #        Mostra o painel de Desistência do Congresso               #
        #                                                                  #
        ####################################################################

        br(),
        
        div( id="panelDesistencia", style="display: none;",
        
            wellPanel( HTML("<h4>&bull; Desistência do Evento &bull;</h4>"),
            
                actionLink("linkHSDesistencia", "Mostrar | Ocultar"),
            
                div( id="panelDesistenciaSub01", style="display: none;",
            
                    tags$br(),br(),
                
                    wellPanel( br(),
        
                        wellPanel( br(),
                        
                            fluidRow( column( width = 4, offset = 4,
                            
                                actionButton("butDesistencia", "Desistir da Participação nesse Evento", icon( name="remove-sign", lib="glyphicon" ) )
                                
                            ))
                            
                        ),
                        
                        htmlOutput("labDesistencia01"),
                        htmlOutput("labDesistencia02"),
                        htmlOutput("labDesistencia03"),
                    
                    )
                
                )
            
            )
        
        ),
    
        ####################################################################
        #                                                                  #
        #        Mostra o painel de rodapé                                 #
        #                                                                  #
        ####################################################################

        br(),
        
        div( id="panelRodapePart", style="display: none;",
        
            wellPanel( " ",
        
                # Colocar algo aqui de rodapé!!! Figura por exemplo
            
            )
        
        )

    ))# <- aqui fecha o fluidRow da página - interfaceParticipante
        
    )#<- aqui fecha a "interfaceParticipante"
