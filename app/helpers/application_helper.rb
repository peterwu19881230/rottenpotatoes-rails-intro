module ApplicationHelper
    def sortable(column,title)
        css_class = "hilite"
        link_to title, {:sort => column}, {:class => css_class}
    end
        
end
