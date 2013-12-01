// Generated by CoffeeScript 1.6.2
(function() {
  window.TaskModel = Backbone.Model.extend({
    defaults: {
      name: "New Task",
      date: "26.01.1992",
      done: false
    },
    initialize: function() {
      var date, done, name;

      name = "name";
      date = "01.01.2001";
      return done = false;
    }
  });

  window.TasksCollection = Backbone.Collection.extend({
    model: TaskModel,
    url: "/Tasks",
    localStorage: new Backbone.LocalStorage("Tasks")
  });

}).call(this);