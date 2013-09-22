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

namespace 'rcr.youtube', (exports) ->
	exports.init = ->
		exports.bindEvents()

	exports.bindEvents = ->
		$('a#play-video').click (e)->
			e.preventDefault()
			dim = getVideoDimensions()
			autoPlayVideo('OtiqzwODN6Q', dim.height , dim.width)
			$("#promo-video").show()
		$(".video-close").click ->
			$("#promo-video .video").html("")
			$("#promo-video").hide();
		$("#promo-video").not(".video").click ->
			$("#promo-video .video").html("")
			$("#promo-video").hide();


	autoPlayVideo = (vcode, height, width)->
		video = $("#promo-video .video")
		video.html('<iframe width="'+width+'" height="'+height+'" src="https://www.youtube.com/embed/'+vcode+'?autoplay=1&loop=1&rel=0&wmode=transparent&vq=hd1080" frameborder="0" allowfullscreen wmode="Opaque"></iframe>')
		top = ($(window).height() / 2) - (height / 2)
		left = ($(window).width() / 2) - (width / 2)
		video.css('top', top).css('left', left)

	getVideoDimensions = ->
		dimensions =
			height: 0,
			width: 0

		scnHeight = $(window).height()
		scnWidth = $(window).width()
		if  scnHeight >= 800 && scnWidth >= 960
			dimensions.height = 720
			dimensions.width = 960
		else if scnHeight >= 540 && scnWidth >= 640
			dimensions.height = 480
			dimensions.width = 640
		else
			dimensions.height = 360
			dimensions.width = 480
		return dimensions


namespace 'rcr.login', (exports) ->
	exports.init = ->
		$ ->
			$("form").validationEngine()

namespace 'rcr.products', (exports) ->
	exports.init = ->
		$ ->
			$(".interesting_items-image").mouseenter ->
					$(this).find(".product-caption").addClass("hovering")
				.mouseleave ->
					$(this).find(".product-caption").removeClass("hovering")

namespace 'rcr.product', (exports) ->
	exports.init = ->
		$ ->
			$('#your_product').change ->
				selected = $(this).find('option:selected')
				price = selected.attr('data-price')
				quantity = $('#cart_item_quantity').find('option:selected').val()
				setPrice(price, quantity)
				$('#cart_item_variant_id').val(selected.attr('data-variant_id'))

			$('#cart_item_quantity').change ->
				price = $('#your_product').find('option:selected').attr('data-price')
				quantity = $(this).find('option:selected').val()
				setPrice(price, quantity)

	setPrice = (price, quantity)->
		number = Number(price.replace(/[^0-9\.]+/g,""));
		newPrice = number * quantity
		newPrice = "$" + newPrice.toFixed(2)
		$('.product_content_price').text(newPrice)

namespace 'rcr.addresses', (exports) ->
	exports.init = ->
		$ ->
			width = $('#shopping_addresses_selections').width()
			bwidth = $('.boat-body').width()
			sol = (bwidth - width) / 2
			$('#shopping_addresses_selections').css('left', sol)

namespace 'rcr.shipping', (exports) ->
	exports.init = ->
		$ ->
			$('input[type="radio"]').first().prop('checked',true)
			$('.shipping-item').click ->
				$(this).find('input[type="radio"]').prop('checked',true)

namespace 'rcr.checkout', (exports) ->
	exports.init = ->
		$ ->
			$("form").validationEngine()




