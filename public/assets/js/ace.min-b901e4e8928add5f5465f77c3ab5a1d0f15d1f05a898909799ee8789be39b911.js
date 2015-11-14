function handle_side_menu(){$("#menu-toggler").on(ace.click_event,function(){return $("#sidebar").toggleClass("display"),$(this).toggleClass("display"),!1});var t=$("#sidebar").hasClass("menu-min");$("#sidebar-collapse").on(ace.click_event,function(){$("#sidebar").toggleClass("menu-min"),$(this).find('[class*="icon-"]:eq(0)').toggleClass("icon-double-angle-right"),t=$("#sidebar").hasClass("menu-min"),t&&$(".open > .submenu").removeClass("open")});"ontouchend"in document;$(".nav-list").on(ace.click_event,function(e){var i=$(e.target).closest("a");if(i&&0!=i.length){if(i.hasClass("dropdown-toggle")){var n=i.next().get(0);if(!$(n).is(":visible")){var s=$(n.parentNode).closest("ul");if(t&&s.hasClass("nav-list"))return;s.find("> .open > .submenu").each(function(){this==n||$(this.parentNode).hasClass("active")||$(this).slideUp(200).parent().removeClass("open")})}return t&&$(n.parentNode.parentNode).hasClass("nav-list")?!1:($(n).slideToggle(200).parent().toggleClass("open"),!1)}if(t&&"tap"==ace.click_event&&i.get(0).parentNode.parentNode==this){var o=i.find(".menu-text").get(0);if(e.target!=o&&!$.contains(o,e.target))return!1}}})}function enable_search_ahead(){$("#nav-search-input").typeahead({source:["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"],updater:function(t){return $("#nav-search-input").focus(),t}})}function general_things(){$('.ace-nav [class*="icon-animated-"]').closest("a").on("click",function(){var t=$(this).find('[class*="icon-animated-"]').eq(0),e=t.attr("class").match(/icon\-animated\-([\d\w]+)/);t.removeClass(e[0]),$(this).off("click")}),$(".nav-list .badge[title],.nav-list .label[title]").tooltip({placement:"right"}),$("#ace-settings-btn").on(ace.click_event,function(){$(this).toggleClass("open"),$("#ace-settings-box").toggleClass("open")}),$("#ace-settings-header").removeAttr("checked").on("click",function(){this.checked||$("#ace-settings-sidebar").get(0).checked&&$("#ace-settings-sidebar").click(),$(".navbar").toggleClass("navbar-fixed-top"),$(document.body).toggleClass("navbar-fixed")}),$("#ace-settings-sidebar").removeAttr("checked").on("click",function(){this.checked?$("#ace-settings-header").get(0).checked||$("#ace-settings-header").click():$("#ace-settings-breadcrumbs").get(0).checked&&$("#ace-settings-breadcrumbs").click(),$("#sidebar").toggleClass("fixed")}),$("#ace-settings-breadcrumbs").removeAttr("checked").on("click",function(){this.checked&&($("#ace-settings-sidebar").get(0).checked||$("#ace-settings-sidebar").click()),$("#breadcrumbs").toggleClass("fixed"),$(document.body).toggleClass("breadcrumbs-fixed")}),$("#ace-settings-rtl").removeAttr("checked").on("click",function(){switch_direction()}),$("#btn-scroll-up").on(ace.click_event,function(){var t=Math.max(100,parseInt($("html").scrollTop()/3));return $("html,body").animate({scrollTop:0},t),!1}),$("#skin-colorpicker").ace_colorpicker().on("change",function(){var t=$(this).find("option:selected").data("class"),e=$(document.body);e.removeClass("skin-1 skin-2 skin-3"),"default"!=t&&e.addClass(t),"skin-1"==t?$(".ace-nav > li.grey").addClass("dark"):$(".ace-nav > li.grey").removeClass("dark"),"skin-2"==t?($(".ace-nav > li").addClass("no-border margin-1"),$(".ace-nav > li:not(:last-child)").addClass("light-pink").find('> a > [class*="icon-"]').addClass("pink").end().eq(0).find(".badge").addClass("badge-warning")):($(".ace-nav > li").removeClass("no-border margin-1"),$(".ace-nav > li:not(:last-child)").removeClass("light-pink").find('> a > [class*="icon-"]').removeClass("pink").end().eq(0).find(".badge").removeClass("badge-warning")),"skin-3"==t?$(".ace-nav > li.grey").addClass("red").find(".badge").addClass("badge-yellow"):$(".ace-nav > li.grey").removeClass("red").find(".badge").removeClass("badge-yellow")})}function widget_boxes(){$(".page-content").delegate(".widget-toolbar > [data-action]","click",function(t){t.preventDefault();var e=$(this),i=e.data("action"),n=e.closest(".widget-box");if(!n.hasClass("ui-sortable-helper"))if("collapse"==i){var s=n.find(".widget-body"),o=e.find("[class*=icon-]").eq(0),r=o.attr("class").match(/icon\-(.*)\-(up|down)/),a="icon-"+r[1]+"-down",l="icon-"+r[1]+"-up",h=s.find(".widget-body-inner");s=0==h.length?s.wrapInner('<div class="widget-body-inner"></div>').find(":first-child").eq(0):h.eq(0);var c=300,u=200;n.hasClass("collapsed")?(o&&o.addClass(l).removeClass(a),n.removeClass("collapsed"),s.slideUp(0,function(){s.slideDown(c)})):(o&&o.addClass(a).removeClass(l),s.slideUp(u,function(){n.addClass("collapsed")}))}else if("close"==i){var p=parseInt(e.data("close-speed"))||300;n.hide(p,function(){n.remove()})}else if("reload"==i){e.blur();var d=!1;"static"==n.css("position")&&(d=!0,n.addClass("position-relative")),n.append('<div class="widget-box-layer"><i class="icon-spinner icon-spin icon-2x white"></i></div>'),setTimeout(function(){n.find(".widget-box-layer").remove(),d&&n.removeClass("position-relative")},parseInt(1e3*Math.random()+1e3))}})}function switch_direction(){function t(t,i){e.find("."+t).removeClass(t).addClass("tmp-rtl-"+t).end().find("."+i).removeClass(i).addClass(t).end().find(".tmp-rtl-"+t).removeClass("tmp-rtl-"+t).addClass(i)}var e=$(document.body);e.toggleClass("rtl").find(".dropdown-menu:not(.datepicker-dropdown,.colorpicker)").toggleClass("pull-right").end().find('.pull-right:not(.dropdown-menu,blockquote,.dropdown-submenu,.profile-skills .pull-right,.control-group .controls > [class*="span"]:first-child)').removeClass("pull-right").addClass("tmp-rtl-pull-right").end().find(".pull-left:not(.dropdown-submenu,.profile-skills .pull-left)").removeClass("pull-left").addClass("pull-right").end().find(".tmp-rtl-pull-right").removeClass("tmp-rtl-pull-right").addClass("pull-left").end().find(".chzn-container").toggleClass("chzn-rtl").end().find('.control-group .controls > [class*="span"]:first-child').toggleClass("pull-right").end(),t("align-left","align-right"),t("arrowed","arrowed-right"),t("arrowed-in","arrowed-in-right");var i=$("#piechart-placeholder");if(i.size()>0){var n=$(document.body).hasClass("rtl")?"nw":"ne";i.data("draw").call(i.get(0),i,i.data("chart"),n)}}jQuery(function(){handle_side_menu(),enable_search_ahead(),general_things(),widget_boxes()});