module GroupsHelper
    def button_name
        if controller.action_name == "new"
            return "Create"
        elsif controller.action_name == "update"
            return "Update"
        end
    end
end