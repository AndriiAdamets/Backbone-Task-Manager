window.checkName = ->
	@$(".name-alert").hide()
	if @$("#newName").val() is ""
		@$(".name-alert.alert-danger").show(200)
		false
	else
		@$(".name-alert.alert-success").show(200)
		true

window.checkDate = ->
	@$(".date-alert").hide()
	if @$("#newDate").val() is ""
		@$(".date-alert.alert-danger").text("You can`t add task with no date")
		@$(".date-alert.alert-danger").show(200)
		return false
	validFormat = /^\d{2}\.\d{2}\.\d{4}$/
	if not validFormat.test @$("#newDate").val()
		@$(".date-alert.alert-danger").text("Wrong date format (dd.mm.yyyy). Reenter date or use datepicker.")
		@$(".date-alert.alert-danger").show(200)
		return false
	inpDate = @$("#newDate").val().split(".").map Number
	inpDate[1]--
	dayObj = new Date inpDate[2], inpDate[1], inpDate[0]
	if ((dayObj.getMonth() isnt inpDate[1]) or (dayObj.getDate() isnt inpDate[0]) or (dayObj.getFullYear()isnt inpDate[2]))
		@$(".date-alert.alert-danger").text("Impossible date, like 30-th of Febrary. Reenter date or use datepicker.")
		@$(".date-alert.alert-danger").show(200)
		return false
	@$(".date-alert.alert-success").show(200)
	true