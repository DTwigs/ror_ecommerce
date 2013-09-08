namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

$ ->
	$(window).resize ()->
		rcr.home.setBannerSize()


namespace 'rcr.home', (exports) ->
	exports.init = ->
		$ ->
			exports.setBannerSize()
			eventHandlers()
			$("#scrollTab").addClass("active")

	exports.setBannerSize = ->
		scnHeight = 	$(window).height() - 60
		$('.big-banner').css("height", scnHeight)

	eventHandlers = ->
		$("#scrollTab").click (evt)->
			evt.preventDefault()

			$('html,body').animate({scrollTop:1000}, 1000,'swing');