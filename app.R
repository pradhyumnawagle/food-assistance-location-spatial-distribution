library(shiny)
library(leaflet)

source('geocode.R')

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()
  

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      
      selectInput(
        "snap_retailers", "SNAP Retailers:",
        c("All agencies" = "all_agencies",
          "Closed Agencies" = "closed_agencies",
          "New Agencies" = "new_agencies",
          "Enter and Exit" = "enter_exit"),
        selected = "all_agencies"),
      
      selectInput(
        "snap_retailer_type", "SNAP Retailer type:",
        c(
          "Convenience Store" = "Convenience Store"  ,
          "Small Grocery Store" = "Small Grocery Store",
          "Medium Grocery Store" = "Medium Grocery Store",
          "Supermarket" = "Supermarket" ,
          "Meat/Poultry Specialty" = "Meat/Poultry Specialty" ,
          "Delivery Route" = "Delivery Route",
          "Combination Grocery/Other" = "Combination Grocery/Other",
          "Bakery Specialty" = "Bakery Specialty",
          "Farmers' Market" = "Farmers' Market",
          "Food Buying Co-op" = "Food Buying Co-op",
          "Large Grocery Store" = "Large Grocery Store",
          "Super Store" =  "Super Store",
          "Seafood Specialty" =  "Seafood Specialty",
          "Fruits/Veg Specialty " = "Fruits/Veg Specialty "),
        selected = "Convenience Store"),
      
      selectInput(
        "snap_retailer_type2", "Second SNAP Retailer type:",
        c(
          "Convenience Store" = "Convenience Store"  ,
          "Small Grocery Store" = "Small Grocery Store",
          "Medium Grocery Store" = "Medium Grocery Store",
          "Supermarket" = "Supermarket" ,
          "Meat/Poultry Specialty" = "Meat/Poultry Specialty" ,
          "Delivery Route" = "Delivery Route",
          "Combination Grocery/Other" = "Combination Grocery/Other",
          "Bakery Specialty" = "Bakery Specialty",
          "Farmers' Market" = "Farmers' Market",
          "Food Buying Co-op" = "Food Buying Co-op",
          "Large Grocery Store" = "Large Grocery Store",
          "Super Store" =  "Super Store",
          "Seafood Specialty" =  "Seafood Specialty",
          "Fruits/Veg Specialty " = "Fruits/Veg Specialty "),
        selected = "Convenience Store"),
      
      
    width = 2),
    mainPanel(
      leafletOutput("mymap", height = "95vh"),
      width = 10
    )
    
 )
)



server <- function(input, output, session){
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(lng = ~long,lat = ~lat,data = census_s1, popup = ~name, icon = icons("fbst_icon.png"))%>%
      addControl(html = paste("<img src= 'https://img.icons8.com/ultraviolet/344/marker.png' style='width:30px;height:30px;'>FBST Pantry</br>
               <img src= 'data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHZpZXdCb3g9IjAgMCAxNzIgMTcyIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9Im5vbnplcm8iIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBzdHJva2UtbGluZWNhcD0iYnV0dCIgc3Ryb2tlLWxpbmVqb2luPSJtaXRlciIgc3Ryb2tlLW1pdGVybGltaXQ9IjEwIiBzdHJva2UtZGFzaGFycmF5PSIiIHN0cm9rZS1kYXNob2Zmc2V0PSIwIiBmb250LWZhbWlseT0ibm9uZSIgZm9udC13ZWlnaHQ9Im5vbmUiIGZvbnQtc2l6ZT0ibm9uZSIgdGV4dC1hbmNob3I9Im5vbmUiIHN0eWxlPSJtaXgtYmxlbmQtbW9kZTogbm9ybWFsIj48cGF0aCBkPSJNMCwxNzJ2LTE3MmgxNzJ2MTcyeiIgZmlsbD0ibm9uZSI+PC9wYXRoPjxnIGZpbGw9IiNlNzRjM2MiPjxwYXRoIGQ9Ik04Niw0M2MtMjMuNzQ4MjQsMCAtNDMsMTkuMjUxNzYgLTQzLDQzYzAsMjMuNzQ4MjQgMTkuMjUxNzYsNDMgNDMsNDNjMjMuNzQ4MjQsMCA0MywtMTkuMjUxNzYgNDMsLTQzYzAsLTIzLjc0ODI0IC0xOS4yNTE3NiwtNDMgLTQzLC00M3oiPjwvcGF0aD48L2c+PC9nPjwvc3ZnPg==' style='width:30px;height:30px;'>SNAP: ",  input$snap_retailer_type ,"</br>
               <img src = 'https://img.icons8.com/ios-glyphs/344/full-stop--v1.png'  style='width:30px;height:30px;'> SNAP: ", input$snap_retailer_type2 )) %>%
      addMarkers(lng = ~long, lat = ~lat,data = get_snap_retailers(snap.agencies, input$snap_retailers, input$snap_retailer_type),icon = icons("snap_icon.png") , popup = ~store)%>%
    addMarkers(lng = ~long, lat = ~lat,data = get_snap_retailers(snap.agencies, input$snap_retailers, input$snap_retailer_type2),icon = icons("black_dot.png") , popup = ~store) 
    
  })
}

shinyApp(ui, server)