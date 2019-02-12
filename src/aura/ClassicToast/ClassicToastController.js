({
    handleShowToast: function (component, event, helper) {
        component.set("v.message", event.getParam("message"));
        component.set("v.type", event.getParam("type"));

        if (event.getParam("title")) {
            component.set("v.title", event.getParam("title"));
        }

        if (event.getParam("duration")) {
            component.set("v.duration", event.getParam("duration"));
        }

        component.set("v.showToast", true);

        window.setTimeout(
            $A.getCallback(function() {
                component.set("v.showToast", false);
            }), component.get("v.duration")
        );
    },

    hideToast: function (component) {
        component.set("v.showToast", false);
    }
})