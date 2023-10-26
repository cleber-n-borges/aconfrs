
    ########################################################
    div( id="interfaceConferencia", style="display: none;",
    ########################################################
    fluidPage( column( width = 8, offset = 2,
    
        div( id="panelConferencia",
        
            # Carrossel com Bootstrap 3 - pacote: bsplus
            #############################################################################
            # bs_carousel(id = "with_the_beatles", use_indicators = TRUE) %>%
            #     bs_append(content = bs_carousel_image(src = "www/sitebook/la.jpg")) %>%
            #     bs_append(content = bs_carousel_image(src = "www/sitebook/ny.jpg")) %>%
            #     bs_append(content = bs_carousel_image(src = "www/sitebook/ch.jpg")) %>%
            #     bs_append(content = bs_carousel_image(src = "www/sitebook/ny.jpg")),
            #############################################################################

        
            #####################################################################
            #                                                                   #
            #           Inserir um carrosel de Bootstrap 4 (bs4Dash)            #
            #                                                                   #
            #####################################################################
        
            # carousel( id = "mycarousel",
            # 
            #     carouselItem( caption = "Item 1",
            #         tags$img(src = "https://via.placeholder.com/500")
            #     ),
            #     
            #     carouselItem( caption = "Item 2",
            #         tags$img(src = "https://via.placeholder.com/500")
            #     )
            #     
            # )

            #####################################################################
            #                                                                   #
            #                   Inserir Site Independente                       #
            #                                                                   #            
            #####################################################################
		
			# https://community.rstudio.com/t/bookdown-inside-shiny-app/80958/2
			tags$iframe(
			
				frameborder="0",
				
				style="width: 100%; height: 100%dvh; ", # height: 100vmax;", overflow: hidden;",
				
				src="book/index.html",
				
            
				onload="this.style.height=(this.contentWindow.document.body.scrollHeight+20)+'px';"
				
			)
			
        )
        
    ))#<- fecha fluidPage
    
    )#<- fecha div id="interfaceConferencia"

