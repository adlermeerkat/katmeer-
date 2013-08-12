$ ->
	$('a.load-more-users').on 'inview', (e, visible) ->
		return unless visible

		$.getScript $(this).attr('href')