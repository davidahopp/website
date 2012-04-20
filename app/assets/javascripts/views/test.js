website.views.Test = Backbone.View.extend({
  initialize: function(){
      _.bindAll(this, 'render')
    },
  render: function(){
    $(this.el).html(website.templates['test']())

    return this
  }
})