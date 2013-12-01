window.TaskView = Backbone.View.extend

	tagName: 'tr'

	events: 
		'click .state' : 'changeState'
		'click button.delete': -> @model.destroy()
		
	initialize: ->
		@template = _.template $("#viewTask").html()
		@listenTo @model, "change", @render
		@listenTo @model, "destroy", @delete
		@render()

	render: ->
		@$el.html @template @model.toJSON()

	changeState: (ev)->
		@model.set(done: not (@model.get "done"))
		@model.save()

	delete: ->
		$(@el).remove()

#-------------------------------------------------------------

window.TasksView = Backbone.View.extend
	events:
		"click .addTask": "addTask"
		"click button.clearList": "clearlist"
		"click" : "distribution"

	initialize: ->
		@template = _.template $("#viewTasks").html()
		@allCount = 0
		@collAll = new TasksCollection()
		@collAll.fetch()
		@collDisplayed = new Backbone.Collection()
		@dispLayedItemsType = "all"
		@listenTo @collAll, "add", @addOne
		@listenTo @collDisplayed, "add", @showOne
		@render()
		@$("div.alert").hide()
		$('#newDate').datepicker()

	addTask: ->
		nameCorect = checkName()
		dateCorect = checkDate()
		if (nameCorect and dateCorect)
			@collAll.add
				name: @$("#newName").val()
				date: @$("#newDate").val()
				done: false
			@distribution()		
			@$("#newName").val("")
			@$("#newDate").val("")
			@$(".alert").hide()

	addOne: (model)->
		model.save()

	showOne: (model)->
		view = new TaskView
			model: model
		@$("tbody").append view.render()
	
	hideAll: -> 
		@$("tbody").html ""
		@collDisplayed.reset()

	distribution: ->
		@updateFooter()
		if @dispLayedItemsType is "done"
			@renderList @collAll.filter (model) ->
				model.get("done") is true
		else if @dispLayedItemsType is "notDone"
			@renderList @collAll.filter (model) ->
				model.get("done") is false
		else
			@renderList @collAll.models

	render: ->
		@$el.html @template

	renderList: (list)->
		@hideAll()
		for i in [0..list.length]
			@collDisplayed.add list[i]

	clearlist: ->
		do model.destroy while model = @collAll.first()

	updateFooter: ->
		@$(".allCount").text @collAll.length
		@$(".doneCount").text @collAll.filter( (model) ->
				model.get("done") is true
				).length
		@$(".notDoneCount").text @collAll.filter((model) ->
				model.get("done") is false
				).length

	changeViewType: (type) ->
		@dispLayedItemsType = type
		@distribution()