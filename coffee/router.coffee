window.Router = Backbone.Router.extend
	routes:
		"": "showAll"
		"all": "showAll"
		"done": "showDone"
		"notdone": "showNotDone"

	initialize: ->
		Backbone.history.start()

	showAll : ->
		tasks_view.changeViewType "all"
		@toggleActiveMenuItem "All Tasks"
		

	showDone : ->
		tasks_view.changeViewType "done"
		@toggleActiveMenuItem "Done"
		

	showNotDone : ->
		tasks_view.changeViewType "notDone"
		@toggleActiveMenuItem "Not Done"
		

	toggleActiveMenuItem: (text) ->
		for i in $(".navbar-right li")
			if ($(i).text() == text)
				$(i).addClass "active"
			else
				$(i).removeClass "active"
