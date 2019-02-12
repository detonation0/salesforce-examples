({
    filterRecords: function (component) {
        let filteredList = [];
        let searchTerm = component.get("v.searchValue").toLowerCase();
        component.set("v.filteredList", filteredList);

        if (searchTerm.length > 1) {
            let fullList = component.get("v.fullList");
            for (let i = 0; i < fullList.length; i++) {
                if (fullList[i].toLowerCase().includes(searchTerm)) {
                    filteredList.push(fullList[i]);
                }
            }
            component.set("v.filteredList", filteredList);
        }
    },

    selectItem: function (component, event) {
        component.set("v.searchValue", event.srcElement.text);
        component.set("v.filteredList", null);
    }
})