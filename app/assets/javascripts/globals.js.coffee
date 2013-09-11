namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

$ ->
	$(window).resize ()->
		rcr.home.setBannerSize()

	if $('.alert').length > 0
		$('.alert').removeClass("fresh")
		setTimeout (->
			$('.alert').addClass('fresh')
		), 3500

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
			exports.scrollToAnchor($("#info"))
		$(".anchorlink").click (evt)->
			evt.preventDefault()
			$(".bs-navbar-collapse").collapse('hide')
			dest = $(this).attr('href')
			dest = dest.replace('/', '')
			exports.scrollToAnchor($(dest))


	exports.scrollToAnchor = (anchor)->
		dest = $(anchor).offset().top
		$('html,body').animate({scrollTop:dest}, 700,'swing');


namespace 'rcr.login', (exports) ->
	exports.init = ->
		$ ->
			$("form").validationEngine()