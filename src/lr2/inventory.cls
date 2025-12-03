Class lr2.inventory Extends %RegisteredObject
{

    ClassMethod AddItem()
    {
        Read !, "1. Enter Region (String, e.g., 'US'): ", region
        
        Read !, "2. Enter Stock Date (YYYY-MM-DD): ", dateStr

        Set dateInt = $ZDateH(dateStr, 3) 
        
        Read !, "3. Enter Category (String, e.g., 'Toys'): ", category
        
        Read !, "4. Enter SKU (Number, e.g., 55): ", sku

        Read !, "--- Item Details ---",!
        Read "Product Name: ", name
        Read !, "Tags (comma separated list, e.g., 'Sale,Fragile'): ", tagList
        
        Set dataToStore = $ListBuild(name, tagList)

        Set ^ShopInventory(region, dateInt, category, sku) = dataToStore
        
        Write !, "Saved successfully!",!
    }

    ClassMethod Analyze()
    {
        Write !, "--- Inventory Report ---",!

        If '$Data(^ShopInventory) { 
            Write "Global ^ShopInventory is empty.",! 
            Quit 
        }

        Set node = $Query(^ShopInventory(""))
        
        While (node '= "") {
            
            Set value = $Get(@node)
            
            Set pName = $ListGet(value, 1)
            Set pTags = $ListGet(value, 2)
            
            Write "Location: ", $QSubscript(node, 1), " | "
            Write "Date: ", $ZDate($QSubscript(node, 2), 3), !
            Write " >> Product: ", pName, !
            Write " >> Tags (CSV): ", pTags, !, "----------------",!

            Set node = $Query(@node)
        }

        Write !, "--- Quick Category Scan (First Region/Date) ---",!
        
        Set r = $Order(^ShopInventory(""))
        Set d = $Order(^ShopInventory(r, ""))
        
        Set cat = ""
        For {
            Set cat = $Order(^ShopInventory(r, d, cat))
            Quit:cat=""
            Write "Category Found: ", cat, !
        }
    }
}