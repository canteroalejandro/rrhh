/* Flot plugin for automatically redrawing plots as the placeholder resizes.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

It works by listening for changes on the placeholder div (through the jQuery
resize event plugin) - if the size changes, it will redraw the plot.

There are no options. If you need to disable the plugin for some plots, you
can just fix the size of their placeholders.

*/
/* Inline dependency:
 * jQuery resize event - v1.1 - 3/14/2010
 * http://benalman.com/projects/jquery-resize-plugin/
 *
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
!function(t,e,i){function n(){s=e[a](function(){o.each(function(){var e=t(this),i=e.width(),n=e.height(),s=t.data(this,h);(i!==s.w||n!==s.h)&&e.trigger(l,[s.w=i,s.h=n])}),n()},r[c])}var s,o=t([]),r=t.resize=t.extend(t.resize,{}),a="setTimeout",l="resize",h=l+"-special-event",c="delay",u="throttleWindow";r[c]=250,r[u]=!0,t.event.special[l]={setup:function(){if(!r[u]&&this[a])return!1;var e=t(this);o=o.add(e),t.data(this,h,{w:e.width(),h:e.height()}),1===o.length&&n()},teardown:function(){if(!r[u]&&this[a])return!1;var e=t(this);o=o.not(e),e.removeData(h),o.length||clearTimeout(s)},add:function(e){function n(e,n,o){var r=t(this),a=t.data(this,h);a.w=n!==i?n:r.width(),a.h=o!==i?o:r.height(),s.apply(this,arguments)}if(!r[u]&&this[a])return!1;var s;return t.isFunction(e)?(s=e,n):(s=e.handler,void(e.handler=n))}}}(jQuery,this),function(t){function e(t){function e(){var e=t.getPlaceholder();0!=e.width()&&0!=e.height()&&(t.resize(),t.setupGrid(),t.draw())}function i(t,i){t.getPlaceholder().resize(e)}function n(t,i){t.getPlaceholder().unbind("resize",e)}t.hooks.bindEvents.push(i),t.hooks.shutdown.push(n)}var i={};t.plot.plugins.push({init:e,options:i,name:"resize",version:"1.0"})}(jQuery);