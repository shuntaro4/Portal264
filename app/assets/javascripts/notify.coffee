###
    jquery.js
    bootstrap-notify.js
###
@notifySuccess = (message) ->
    $.notify({message: message},{type: 'success',})

@notifyInfo = (message) ->
    $.notify({message: message},{type: 'info',})

@notifyDanger = (message) ->
    $.notify({message: message},{type: 'danger',})

@notifyWarning = (message) ->
    $.notify({message: message},{type: 'warning',})
