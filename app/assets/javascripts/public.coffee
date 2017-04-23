$ ->
  $active_link = $('.nav-link.active')
  if $active_link.length
    $active_link.parents('.collapse-wrapper').collapse 'show'

