module ApplicationHelper
    def sortable(column,title) #not used for now
        css_class = "hilite" 
        link_to title, {:sort => column}, {:class => css_class}
    end
        
end
