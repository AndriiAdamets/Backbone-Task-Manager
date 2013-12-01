window.TaskModel = Backbone.Model.extend
	defaults:
		name: "New Task"
		date: "26.01.1992"
		done: false

	initialize: ->
		name = "name"
		date = "01.01.2001"
		done = false

# ----------------------------------------

window.TasksCollection = Backbone.Collection.extend
	model: TaskModel
	url: "/Tasks"
	localStorage: new Backbone.LocalStorage "Tasks"